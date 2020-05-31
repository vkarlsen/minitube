# $FreeBSD: head/multimedia/minitube/Makefile 517032 2019-11-08 05:36:35Z tobik $

PORTNAME=	minitube
DISTVERSION=	3.4
CATEGORIES=	multimedia www

MAINTAINER=	ports@FreeBSD.org
COMMENT=	TV-like client for YouTube

LICENSE=	GPLv3+
LICENSE_FILE=	${WRKSRC}/COPYING

LIB_DEPENDS=	libmpv.so:multimedia/mpv \
		libQt5X11Extras.so:x11/qt5-x11extras

USES=		compiler:c++11-lang gl qmake qt:5
USE_GITHUB=	yes
GH_ACCOUNT=	flaviotordini
GH_TUPLE=	flaviotordini:http:3b9a48a:http/lib/http \
		flaviotordini:idle:6aa092d:idle/lib/idle \
		flaviotordini:media:3e1efe6:media/lib/media
USE_GL=		gl
USE_QT=		core dbus declarative gui network phonon4 script sql widgets \
		buildtools_build imageformats_run sql-sqlite3_run x11extras
QMAKE_ARGS=	QMAKE_LRELEASE=${LRELEASE} \
		DEFINES+=APP_GOOGLE_API_KEY="${MINITUBE_GOOGLE_API_KEY}"

OPTIONS_DEFINE=	NLS
OPTIONS_SUB=	yes
NLS_USES=	qt:5
NLS_USE=	QT=linguisttools_build

post-patch-NLS-off:
	@${REINPLACE_CMD} -e '/include(locale\/locale.pri)/d' ${WRKSRC}/minitube.pro

.include <bsd.port.mk>
