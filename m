Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262317AbTANLbR>; Tue, 14 Jan 2003 06:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262380AbTANLbR>; Tue, 14 Jan 2003 06:31:17 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:59822 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S262317AbTANLbO>; Tue, 14 Jan 2003 06:31:14 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 14 Jan 2003 12:47:48 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [bk patch] v4l: move some files around
Message-ID: <20030114114747.GA28973@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch moves some v4l files.  I've created drivers/media/common
directory for stuff shared by v4l drivers, moved a number of source
files to that place, created new config options for the shared stuff
(video-buf.o, i2c tv tuning modules) to cleanup the Makefiles.

The gnu patch included below includes only the kbuild changes (Kconfig
and Makefiles), not the file moves itself to keep the filesize small.

Please apply,

  Gerd
  
==============================[ cut here ]==============================
# ChangeSet
#   1.1025 03/01/14 12:20:09 kraxel@bytesex.org +15 -0
#   created drivers/media/common directory for stuff shared by 
#   v4l drivers, moved a number of source files to that place,
#   created new config options for the shared stuff (video-buf.o,
#   i2c tv tuning modules) to cleanup the Makefiles.
# 
#   drivers/media/common/Makefile
#     1.1 03/01/14 12:18:39 kraxel@bytesex.org +6 -0
# 
#   drivers/media/common/Kconfig
#     1.1 03/01/14 12:18:39 kraxel@bytesex.org +12 -0
# 
#   drivers/media/video/saa7134/Makefile
#     1.3 03/01/14 12:18:39 kraxel@bytesex.org +1 -1
#     created drivers/media/common directory for stuff shared by 
#     v4l drivers, moved a number of source files to that place,
#     created new config options for the shared stuff (video-buf.o,
#     i2c tv tuning modules) to cleanup the Makefiles.
# 
#   drivers/media/video/Makefile
#     1.17 03/01/14 12:18:39 kraxel@bytesex.org +4 -5
#     created drivers/media/common directory for stuff shared by 
#     v4l drivers, moved a number of source files to that place,
#     created new config options for the shared stuff (video-buf.o,
#     i2c tv tuning modules) to cleanup the Makefiles.
# 
#   drivers/media/common/Makefile
#     1.0 03/01/14 12:18:39 kraxel@bytesex.org +0 -0
#     BitKeeper file /work/bk/2.5/v4l/drivers/media/common/Makefile
# 
#   drivers/media/common/Kconfig
#     1.0 03/01/14 12:18:39 kraxel@bytesex.org +0 -0
#     BitKeeper file /work/bk/2.5/v4l/drivers/media/common/Kconfig
# 
#   drivers/media/Kconfig
#     1.3 03/01/14 12:18:39 kraxel@bytesex.org +2 -0
#     created drivers/media/common directory for stuff shared by 
#     v4l drivers, moved a number of source files to that place,
#     created new config options for the shared stuff (video-buf.o,
#     i2c tv tuning modules) to cleanup the Makefiles.
# 
#   drivers/media/common/audiochip.h
#     1.4 03/01/14 12:04:13 kraxel@bytesex.org +0 -0
#     Rename: drivers/media/video/audiochip.h -> drivers/media/common/audiochip.h
# 
#   drivers/media/common/id.h
#     1.4 03/01/14 12:03:34 kraxel@bytesex.org +0 -0
#     Rename: drivers/media/video/id.h -> drivers/media/common/id.h
# 
#   drivers/media/common/videodev.c
#     1.18 03/01/14 11:23:57 kraxel@bytesex.org +0 -0
#     Rename: drivers/media/video/videodev.c -> drivers/media/common/videodev.c
# 
#   drivers/media/common/v4l2-common.c
#     1.2 03/01/14 11:23:57 kraxel@bytesex.org +0 -0
#     Rename: drivers/media/video/v4l2-common.c -> drivers/media/common/v4l2-common.c
# 
#   drivers/media/common/v4l1-compat.c
#     1.2 03/01/14 11:23:57 kraxel@bytesex.org +0 -0
#     Rename: drivers/media/video/v4l1-compat.c -> drivers/media/common/v4l1-compat.c
# 
#   drivers/media/common/tuner.h
#     1.8 03/01/14 11:23:57 kraxel@bytesex.org +0 -0
#     Rename: drivers/media/video/tuner.h -> drivers/media/common/tuner.h
# 
#   drivers/media/common/tuner.c
#     1.15 03/01/14 11:23:57 kraxel@bytesex.org +0 -0
#     Rename: drivers/media/video/tuner.c -> drivers/media/common/tuner.c
# 
#   drivers/media/common/tda9887.c
#     1.3 03/01/14 11:23:57 kraxel@bytesex.org +0 -0
#     Rename: drivers/media/video/tda9887.c -> drivers/media/common/tda9887.c
# 
#   drivers/media/common/video-buf.h
#     1.6 03/01/14 11:13:06 kraxel@bytesex.org +0 -0
#     Rename: drivers/media/video/video-buf.h -> drivers/media/common/video-buf.h
# 
#   drivers/media/common/video-buf.c
#     1.8 03/01/14 11:13:00 kraxel@bytesex.org +0 -0
#     Rename: drivers/media/video/video-buf.c -> drivers/media/common/video-buf.c
# 
======================================================================
diff -Nru a/drivers/media/Kconfig b/drivers/media/Kconfig
--- a/drivers/media/Kconfig	Tue Jan 14 12:24:13 2003
+++ b/drivers/media/Kconfig	Tue Jan 14 12:24:13 2003
@@ -32,5 +32,7 @@
 
 source "drivers/media/dvb/Kconfig"
 
+source "drivers/media/common/Kconfig"
+
 endmenu
 
diff -Nru a/drivers/media/common/Kconfig b/drivers/media/common/Kconfig
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/media/common/Kconfig	Tue Jan 14 12:24:13 2003
@@ -0,0 +1,12 @@
+config VIDEO_VIDEOBUF
+	tristate
+	default y if VIDEO_SAA7134=y || VIDEO_BT848=y
+	default m if VIDEO_SAA7134=m || VIDEO_BT848=m
+	depends on VIDEO_DEV
+
+config VIDEO_TUNER
+	tristate
+	default y if VIDEO_SAA7134=y || VIDEO_BT848=y
+	default m if VIDEO_SAA7134=m || VIDEO_BT848=m
+	depends on VIDEO_DEV
+
diff -Nru a/drivers/media/common/Makefile b/drivers/media/common/Makefile
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/media/common/Makefile	Tue Jan 14 12:24:13 2003
@@ -0,0 +1,6 @@
+
+export-objs     := videodev.o v4l2-common.o v4l1-compat.o video-buf.o
+
+obj-$(CONFIG_VIDEO_DEV)		+= videodev.o v4l2-common.o v4l1-compat.o
+obj-$(CONFIG_VIDEO_VIDEOBUF)	+= video-buf.o
+obj-$(CONFIG_VIDEO_TUNER)	+= tuner.o tda9887.o
diff -Nru a/drivers/media/video/Makefile b/drivers/media/video/Makefile
--- a/drivers/media/video/Makefile	Tue Jan 14 12:24:13 2003
+++ b/drivers/media/video/Makefile	Tue Jan 14 12:24:13 2003
@@ -5,17 +5,16 @@
 # All of the (potential) objects that export symbols.
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
 
-export-objs     :=	videodev.o v4l2-common.o v4l1-compat.o \
-			bttv-if.o cpia.o video-buf.o
+export-objs     :=	bttv-if.o cpia.o
 
 bttv-objs	:=	bttv-driver.o bttv-cards.o bttv-if.o \
 			bttv-risc.o bttv-vbi.o
 zoran-objs      :=	zr36120.o zr36120_i2c.o zr36120_mem.o
 
-obj-$(CONFIG_VIDEO_DEV) += videodev.o v4l2-common.o v4l1-compat.o
+EXTRA_CFLAGS = -I$(src)/../common
 
 obj-$(CONFIG_VIDEO_BT848) += bttv.o msp3400.o tvaudio.o \
-	tda7432.o tda9875.o tuner.o video-buf.o tda9887.o
+	tda7432.o tda9875.o
 obj-$(CONFIG_SOUND_TVMIXER) += tvmixer.o
 
 obj-$(CONFIG_VIDEO_ZR36120) += zoran.o
@@ -35,5 +34,5 @@
 obj-$(CONFIG_VIDEO_CPIA_PP) += cpia_pp.o
 obj-$(CONFIG_VIDEO_CPIA_USB) += cpia_usb.o
 obj-$(CONFIG_VIDEO_MEYE) += meye.o
-obj-$(CONFIG_VIDEO_SAA7134) += saa7134/ tuner.o tda9887.o video-buf.o
+obj-$(CONFIG_VIDEO_SAA7134) += saa7134/
 obj-$(CONFIG_TUNER_3036) += tuner-3036.o
diff -Nru a/drivers/media/video/saa7134/Makefile b/drivers/media/video/saa7134/Makefile
--- a/drivers/media/video/saa7134/Makefile	Tue Jan 14 12:24:13 2003
+++ b/drivers/media/video/saa7134/Makefile	Tue Jan 14 12:24:13 2003
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_VIDEO_SAA7134) += saa7134.o
 
-EXTRA_CFLAGS = -I$(src)/..
+EXTRA_CFLAGS = -I$(src)/../../common
======================================================================
This BitKeeper patch contains the following changesets:
1.1025
## Wrapped with gzip_uu ##


begin 664 bkpatch2415
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
!````
`
end
