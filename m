Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137159AbRATGt7>; Sat, 20 Jan 2001 01:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137184AbRATGts>; Sat, 20 Jan 2001 01:49:48 -0500
Received: from mail3.mia.bellsouth.net ([205.152.144.15]:4283 "EHLO
	mail3.mia.bellsouth.net") by vger.kernel.org with ESMTP
	id <S137159AbRATGth>; Sat, 20 Jan 2001 01:49:37 -0500
Message-ID: <3A68EEA7.1A806E6C@bellsouth.net>
Date: Sat, 20 Jan 2001 01:49:27 +0000
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: 2.4.1-pre9 fails to compile drm r128 as module
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.1-pre9 changes to drivers/char/drm/drm.h are incorrect.
Please reverse this small change to compile correctly.

r128_drv.c:124: `DRM_IOCTL_R128_PACKET' undeclared here (not in a function)
r128_drv.c:124: nonconstant array index in initializer for `r128_ioctls'
make[3]: *** [r128_drv.o] Error 1
make[2]: *** [_modsubdir_drm] Error 2
make[1]: *** [_modsubdir_char] Error 2

--- linux-2.4.1-pre9/drivers/char/drm/drm.h.orig        Sat Jan 20 00:43:11 2001
+++ linux/drivers/char/drm/drm.h        Sat Jan 20 00:49:17 2001
@@ -382,7 +382,7 @@
 #define DRM_IOCTL_R128_BLIT            DRM_IOW( 0x4c, drm_r128_blit_t)
 #define DRM_IOCTL_R128_DEPTH           DRM_IOW( 0x4d, drm_r128_depth_t)
 #define DRM_IOCTL_R128_STIPPLE         DRM_IOW( 0x4e, drm_r128_stipple_t)
-#define DRM_IOCTL_R128_INDIRECT                DRM_IOWR(0x4f, drm_r128_indirect_t)
+#define DRM_IOCTL_R128_PACKET          DRM_IOWR(0x4f, drm_r128_packet_t)
 
 /* Radeon specific ioctls */
 #define DRM_IOCTL_RADEON_CP_INIT       DRM_IOW( 0x40, drm_radeon_init_t)
-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
