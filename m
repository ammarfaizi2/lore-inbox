Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264943AbUAAUug (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbUAAUtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:49:42 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:57373 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S264928AbUAAUDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:03:41 -0500
Date: Thu, 1 Jan 2004 21:03:37 +0100
Message-Id: <200401012003.i01K3bn8031944@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 385] Cirrusfb extern inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cirrusfb: Replace `extern inline' by `static inline'

--- linux-2.6.0/drivers/video/cirrusfb.c	2003-06-15 09:38:50.000000000 +0200
+++ linux-m68k-2.6.0/drivers/video/cirrusfb.c	2003-11-23 21:07:51.000000000 +0100
@@ -3089,7 +3089,7 @@
 *********************************************************************/
 
 /* FIXME: use interrupts instead */
-extern inline void clgen_WaitBLT (caddr_t regbase)
+static inline void clgen_WaitBLT (caddr_t regbase)
 {
 	/* now busy-wait until we're done */
 	while (vga_rgfx (regbase, CL_GR31) & 0x08)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
