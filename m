Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285159AbSAAQnk>; Tue, 1 Jan 2002 11:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286311AbSAAQna>; Tue, 1 Jan 2002 11:43:30 -0500
Received: from [62.47.19.152] ([62.47.19.152]:38530 "HELO twinny.dyndns.org")
	by vger.kernel.org with SMTP id <S285159AbSAAQnW>;
	Tue, 1 Jan 2002 11:43:22 -0500
Message-ID: <3C31E513.BECEF41@webit.com>
Date: Tue, 01 Jan 2002 17:34:27 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sis drm module (revised)
Content-Type: multipart/mixed;
 boundary="------------92C19835745EA52BE508B326"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------92C19835745EA52BE508B326
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

without this patch, only root can execute DRI applications under X.
Users can't and just receive a (incorrect) "out of video memory" error,
which is basically a "permission denied".

The revised version of this patch also makes newer DRI applications
(such as "Soldier of Furtune") run.

Please apply. Now for real! :)

Thomas

PS: The file to be patched is located in drivers/char/drm/ in the kernel
tree.

-- 
Thomas Winischhofer
Vienna/Austria
mailto:tw@webit.com              *** http://www.webit.com/tw
--------------92C19835745EA52BE508B326
Content-Type: text/plain; charset=us-ascii;
 name="sis_drm_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sis_drm_patch"

--- sis_drv_old.c	Thu Dec 27 23:52:11 2001
+++ sis_drv.c	Tue Jan  1 16:45:03 2002
@@ -40,12 +40,12 @@
 #define DRIVER_PATCHLEVEL  0
 
 #define DRIVER_IOCTLS \
-        [DRM_IOCTL_NR(SIS_IOCTL_FB_ALLOC)]   = { sis_fb_alloc,	  1, 1 }, \
-        [DRM_IOCTL_NR(SIS_IOCTL_FB_FREE)]    = { sis_fb_free,	  1, 1 }, \
+        [DRM_IOCTL_NR(SIS_IOCTL_FB_ALLOC)]   = { sis_fb_alloc,	  1, 0 }, \
+        [DRM_IOCTL_NR(SIS_IOCTL_FB_FREE)]    = { sis_fb_free,	  1, 0 }, \
         /* AGP Memory Management */					  \
-        [DRM_IOCTL_NR(SIS_IOCTL_AGP_INIT)]   = { sisp_agp_init,	  1, 1 }, \
-        [DRM_IOCTL_NR(SIS_IOCTL_AGP_ALLOC)]  = { sisp_agp_alloc,  1, 1 }, \
-        [DRM_IOCTL_NR(SIS_IOCTL_AGP_FREE)]   = { sisp_agp_free,	  1, 1 }
+        [DRM_IOCTL_NR(SIS_IOCTL_AGP_INIT)]   = { sisp_agp_init,	  1, 0 }, \
+        [DRM_IOCTL_NR(SIS_IOCTL_AGP_ALLOC)]  = { sisp_agp_alloc,  1, 0 }, \
+        [DRM_IOCTL_NR(SIS_IOCTL_AGP_FREE)]   = { sisp_agp_free,	  1, 0 }
 #if 0 /* these don't appear to be defined */
 	/* SIS Stereo */						 
 	[DRM_IOCTL_NR(DRM_IOCTL_CONTROL)]    = { sis_control,	  1, 1 }, 

--------------92C19835745EA52BE508B326--

