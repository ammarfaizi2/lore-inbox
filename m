Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287014AbRL1UmK>; Fri, 28 Dec 2001 15:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287011AbRL1UmB>; Fri, 28 Dec 2001 15:42:01 -0500
Received: from mx7.airmail.net ([209.196.77.104]:18437 "EHLO mx7.airmail.net")
	by vger.kernel.org with ESMTP id <S287008AbRL1Ulv>;
	Fri, 28 Dec 2001 15:41:51 -0500
Message-Id: <5.1.0.14.0.20011228143629.00a30ec0@mail.airmail.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 28 Dec 2001 14:43:43 -0600
To: linux-kernel@vger.kernel.org
From: Jason Lott <tech2kjason@airmail.net>
Subject: Re: [PATCH] sis drm module
In-Reply-To: <3C2BAAA3.4BAC6751@webit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:11 AM 12/28/01 +0100, you wrote:

>Hi,
>
>without this patch, only root can execute DRI applications under X.
>Users can't and just receive a (incorrect) "out of video memory" error,
>which is basically a "permission denied".
>
>Please apply.
>
>Thomas


Definitely gets my vote... The patch also resolves a hard xfree86-4.1.0 
build error
of sis_alloc.c Thank you Thomas, you've helped to make my life a little bit 
easier!
Please, Apply the patch

Jason Lott

>--
>Thomas Winischhofer
>Vienna/Austria
>mailto:tw@webit.com              *** http://www.webit.com/tw--- 
>/usr/src/linux/drivers/char/drm/sis_drv_old.c   Thu Dec 27 23:52:11 2001
>+++ /usr/src/linux/drivers/char/drm/sis_drv.c   Thu Dec 27 23:45:48 2001
>@@ -40,8 +40,8 @@
>  #define DRIVER_PATCHLEVEL  0
>
>  #define DRIVER_IOCTLS \
>-        [DRM_IOCTL_NR(SIS_IOCTL_FB_ALLOC)]   = { sis_fb_alloc,   1, 1 }, \
>-        [DRM_IOCTL_NR(SIS_IOCTL_FB_FREE)]    = { sis_fb_free,    1, 1 }, \
>+        [DRM_IOCTL_NR(SIS_IOCTL_FB_ALLOC)]   = { sis_fb_alloc,   1, 0 }, \
>+        [DRM_IOCTL_NR(SIS_IOCTL_FB_FREE)]    = { sis_fb_free,    1, 0 }, \
>          /* AGP Memory Management */                                      \
>          [DRM_IOCTL_NR(SIS_IOCTL_AGP_INIT)]   = { 
> sisp_agp_init,          1, 1 }, \
>          [DRM_IOCTL_NR(SIS_IOCTL_AGP_ALLOC)]  = { sisp_agp_alloc,  1, 1 }, \

