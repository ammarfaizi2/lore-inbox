Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267397AbUJBRAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267397AbUJBRAe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 13:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUJBRAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 13:00:33 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:27723 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S267397AbUJBRA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 13:00:26 -0400
Date: Sat, 2 Oct 2004 19:00:24 +0200
Message-Id: <200410021700.i92H0Oct021183@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 493] Amiga frame buffer: kill obsolete DMI Resolver code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga frame buffer: Kill remainings of the DMI Resolver support code that got
removed somewhere between 2.0 and 2.2.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.9-rc3/drivers/video/amifb.c	2004-09-30 18:08:25.000000000 +0200
+++ linux-m68k-2.6.9-rc3/drivers/video/amifb.c	2004-09-30 20:11:02.000000000 +0200
@@ -2268,19 +2268,6 @@ int __init amifb_init(void)
 		return -ENXIO;
 
 	/*
-	 * TODO: where should we put this? The DMI Resolver doesn't have a
-	 *	 frame buffer accessible by the CPU
-	 */
-
-#ifdef CONFIG_GSP_RESOLVER
-	if (amifb_resolver){
-		custom.dmacon = DMAF_MASTER | DMAF_RASTER | DMAF_COPPER |
-				DMAF_BLITTER | DMAF_SPRITE;
-		return 0;
-	}
-#endif
-
-	/*
 	 * We request all registers starting from bplpt[0]
 	 */
 	if (!request_mem_region(CUSTOM_PHYSADDR+0xe0, 0x120,

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
