Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266141AbUGTTQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266141AbUGTTQV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266139AbUGTTOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:14:38 -0400
Received: from nl-ams-slo-l4-01-pip-8.chellonetwork.com ([213.46.243.27]:46136
	"EHLO amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S266158AbUGTSjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:39:52 -0400
Date: Tue, 20 Jul 2004 20:39:49 +0200
Message-Id: <200407201839.i6KIdnMb015545@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       jt@hpl.hp.com
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] depends on PCI DMA API: Cisco/Aironet 34X/35X/4500/4800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cisco/Aironet 34X/35X/4500/4800 unconditionally depends on the PCI DMA API, so
mark it broken if !PCI

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/drivers/net/wireless/Kconfig	2004-07-18 15:55:25.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/net/wireless/Kconfig	2004-07-19 23:15:51.000000000 +0200
@@ -139,7 +139,7 @@
 
 config AIRO
 	tristate "Cisco/Aironet 34X/35X/4500/4800 ISA and PCI cards"
-	depends on NET_RADIO && (ISA || PCI)
+	depends on NET_RADIO && ISA && (PCI || BROKEN)
 	---help---
 	  This is the standard Linux driver to support Cisco/Aironet ISA and
 	  PCI 802.11 wireless cards.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
