Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266197AbUGTSvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266197AbUGTSvq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 14:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266194AbUGTSsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:48:51 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.20]:56410 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S266185AbUGTSos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:44:48 -0400
Date: Tue, 20 Jul 2004 20:39:45 +0200
Message-Id: <200407201839.i6KIdjeU015520@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       kkeil@suse.de, kai.germaschewski@gmx.de
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] depends on PCI: Fritz!PCI/PCIv2/PnP and HYSDN
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fritz!PCI/PCIv2/PnP and HYSDN unconditionally depend on PCI

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/drivers/isdn/hisax/Kconfig	2004-07-18 15:55:15.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/isdn/hisax/Kconfig	2004-07-19 23:37:24.000000000 +0200
@@ -413,7 +414,7 @@
 
 config HISAX_FRITZ_PCIPNP
 	tristate "AVM Fritz!Card PCI/PCIv2/PnP support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This enables the driver for the AVM Fritz!Card PCI,
 	  Fritz!Card PCI v2 and Fritz!Card PnP.
--- linux-2.6.8-rc2/drivers/isdn/hysdn/Kconfig	2004-02-29 09:31:48.000000000 +0100
+++ linux-m68k-2.6.8-rc2/drivers/isdn/hysdn/Kconfig	2004-07-19 18:25:19.000000000 +0200
@@ -3,7 +3,7 @@
 #
 config HYSDN
 	tristate "Hypercope HYSDN cards (Champ, Ergo, Metro) support (module only)"
-	depends on m && PROC_FS && BROKEN_ON_SMP
+	depends on m && PROC_FS && PCI && BROKEN_ON_SMP
 	help
 	  Say Y here if you have one of Hypercope's active PCI ISDN cards
 	  Champ, Ergo and Metro. You will then get a module called hysdn.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
