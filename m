Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267062AbSLDUQi>; Wed, 4 Dec 2002 15:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267070AbSLDUQi>; Wed, 4 Dec 2002 15:16:38 -0500
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:53771 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S267062AbSLDUQh>; Wed, 4 Dec 2002 15:16:37 -0500
Date: Wed, 4 Dec 2002 14:24:08 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializer fix for drivers/video/vfb.c
Message-ID: <20021204202408.GF9551@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch fixes a half-conversion to C99 initializers - the '='
characters were dropped. The patch is against 2.5.50.

Art Haas

--- linux-2.5.50/drivers/video/vfb.c.old	2002-12-04 13:25:50.000000000 -0600
+++ linux-2.5.50/drivers/video/vfb.c	2002-12-04 13:25:00.000000000 -0600
@@ -96,17 +96,17 @@
 		    struct vm_area_struct *vma);
 
 static struct fb_ops vfb_ops = {
-	.fb_set_var	gen_set_var,
-	.fb_get_cmap	gen_set_cmap,
-	.fb_set_cmap	gen_set_cmap,
-	.fb_check_var	vfb_check_var,
-	.fb_set_par	vfb_set_par,
-	.fb_setcolreg	vfb_setcolreg,
-	.fb_pan_display	vfb_pan_display,
-	.fb_fillrect	cfb_fillrect,
-	.fb_copyarea	cfb_copyarea,
-	.fb_imageblit	cfb_imageblit,
-	.fb_mmap	vfb_mmap,
+	.fb_set_var	= gen_set_var,
+	.fb_get_cmap	= gen_set_cmap,
+	.fb_set_cmap	= gen_set_cmap,
+	.fb_check_var	= vfb_check_var,
+	.fb_set_par	= vfb_set_par,
+	.fb_setcolreg	= vfb_setcolreg,
+	.fb_pan_display	= vfb_pan_display,
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+	.fb_mmap	= vfb_mmap,
 };
 
     /*
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
