Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267435AbUJBRMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267435AbUJBRMI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 13:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267433AbUJBRJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 13:09:03 -0400
Received: from nl-ams-slo-l4-01-pip-7.chellonetwork.com ([213.46.243.25]:17763
	"EHLO amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S267423AbUJBRF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 13:05:28 -0400
Date: Sat, 2 Oct 2004 19:05:24 +0200
Message-Id: <200410021705.i92H5OiC021807@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 163] Amiga frame buffer: kill obsolete DMI Resolver code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga frame buffer: Kill remainings of the DMI Resolver support code that got
removed somewhere between 2.0 and 2.2.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.4.28-pre3/drivers/video/amifb.c	2004-04-27 17:22:14.000000000 +0200
+++ linux-m68k-2.4.28-pre3/drivers/video/amifb.c	2004-09-30 20:11:34.000000000 +0200
@@ -1605,19 +1605,6 @@ int __init amifb_init(void)
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
