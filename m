Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283003AbRL0XT5>; Thu, 27 Dec 2001 18:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283012AbRL0XTr>; Thu, 27 Dec 2001 18:19:47 -0500
Received: from [62.47.19.152] ([62.47.19.152]:12930 "HELO twinny.dyndns.org")
	by vger.kernel.org with SMTP id <S283003AbRL0XTd>;
	Thu, 27 Dec 2001 18:19:33 -0500
Message-ID: <3C2BAAA3.4BAC6751@webit.com>
Date: Fri, 28 Dec 2001 00:11:31 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sis drm module
Content-Type: multipart/mixed;
 boundary="------------C247268508FF5BB8974018B3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C247268508FF5BB8974018B3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Hi,

without this patch, only root can execute DRI applications under X.
Users can't and just receive a (incorrect) "out of video memory" error,
which is basically a "permission denied".

Please apply.

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:tw@webit.com              *** http://www.webit.com/tw
--------------C247268508FF5BB8974018B3
Content-Type: text/plain; charset=us-ascii;
 name="sis_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sis_patch"

--- /usr/src/linux/drivers/char/drm/sis_drv_old.c	Thu Dec 27 23:52:11 2001
+++ /usr/src/linux/drivers/char/drm/sis_drv.c	Thu Dec 27 23:45:48 2001
@@ -40,8 +40,8 @@
 #define DRIVER_PATCHLEVEL  0
 
 #define DRIVER_IOCTLS \
-        [DRM_IOCTL_NR(SIS_IOCTL_FB_ALLOC)]   = { sis_fb_alloc,	  1, 1 }, \
-        [DRM_IOCTL_NR(SIS_IOCTL_FB_FREE)]    = { sis_fb_free,	  1, 1 }, \
+        [DRM_IOCTL_NR(SIS_IOCTL_FB_ALLOC)]   = { sis_fb_alloc,	  1, 0 }, \
+        [DRM_IOCTL_NR(SIS_IOCTL_FB_FREE)]    = { sis_fb_free,	  1, 0 }, \
         /* AGP Memory Management */					  \
         [DRM_IOCTL_NR(SIS_IOCTL_AGP_INIT)]   = { sisp_agp_init,	  1, 1 }, \
         [DRM_IOCTL_NR(SIS_IOCTL_AGP_ALLOC)]  = { sisp_agp_alloc,  1, 1 }, \

--------------C247268508FF5BB8974018B3--

