Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbUDMIiT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 04:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbUDMIiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 04:38:19 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:29971 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S263200AbUDMIiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 04:38:06 -0400
Date: Tue, 13 Apr 2004 10:38:03 +0200
Message-Id: <200404130838.i3D8c3rm018430@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 425] Pm2fb is broken on Amiga
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Permedia2: Mark pm2fb broken on Amiga, until somebody fixes it (pm2fb.c
explicitly tests for CONFIG_PCI right now)

--- linux-2.6.5-rc2/drivers/video/Kconfig	2004-03-04 11:31:17.000000000 +0100
+++ linux-m68k-2.6.5-rc2/drivers/video/Kconfig	2004-03-04 16:35:00.000000000 +0100
@@ -55,7 +55,7 @@
 
 config FB_PM2
 	tristate "Permedia2 support"
-	depends on FB && (AMIGA || PCI)
+	depends on FB && ((AMIGA && BROKEN) || PCI)
 	help
 	  This is the frame buffer device driver for the Permedia2 AGP frame
 	  buffer card from ASK, aka `Graphic Blaster Exxtreme'.  There is a

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
