Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266201AbUGTTGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266201AbUGTTGK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUGTSlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:41:35 -0400
Received: from amsfep18-int.chello.nl ([213.46.243.13]:37701 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S266137AbUGTSiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:38:09 -0400
Date: Tue, 20 Jul 2004 20:38:08 +0200
Message-Id: <200407201838.i6KIc8i0015414@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 469] dnfb sparse struct init
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apollo Frame buffer: Fix C99 struct initializers (found by sparse)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/drivers/video/dnfb.c	2004-04-28 15:49:59.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/video/dnfb.c	2004-07-10 21:06:54.000000000 +0200
@@ -118,23 +118,23 @@
 };
 
 struct fb_var_screeninfo dnfb_var __devinitdata = {
-	.xres		1280,
-	.yres		1024,
-	.xres_virtual	2048,
-	.yres_virtual	1024,
-	.bits_per_pixel	1,
-	.height		-1,
-	.width		-1,
-	.vmode		FB_VMODE_NONINTERLACED,
+	.xres		= 1280,
+	.yres		= 1024,
+	.xres_virtual	= 2048,
+	.yres_virtual	= 1024,
+	.bits_per_pixel	= 1,
+	.height		= -1,
+	.width		= -1,
+	.vmode		= FB_VMODE_NONINTERLACED,
 };
 
 static struct fb_fix_screeninfo dnfb_fix __devinitdata = {
-	.id		"Apollo Mono",
-	.smem_start	(FRAME_BUFFER_START + IO_BASE),
-	.smem_len	FRAME_BUFFER_LEN,
-	.type		FB_TYPE_PACKED_PIXELS,
-	.visual		FB_VISUAL_MONO10,
-	.line_length	256,
+	.id		= "Apollo Mono",
+	.smem_start	= (FRAME_BUFFER_START + IO_BASE),
+	.smem_len	= FRAME_BUFFER_LEN,
+	.type		= FB_TYPE_PACKED_PIXELS,
+	.visual		= FB_VISUAL_MONO10,
+	.line_length	= 256,
 };
 
 static int dnfb_blank(int blank, struct fb_info *info)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
