Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266134AbUGTTQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266134AbUGTTQU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUGTTOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:14:46 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:56882 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S266157AbUGTSju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:39:50 -0400
Date: Tue, 20 Jul 2004 20:39:49 +0200
Message-Id: <200407201839.i6KIdn4R015540@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] depends on PCI: Toshiba and VIA FIR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Toshiba and VIA FIR unconditionally depend on PCI

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/drivers/net/irda/Kconfig	2004-07-15 23:14:24.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/net/irda/Kconfig	2004-07-19 18:28:34.000000000 +0200
@@ -333,7 +333,7 @@
 
 config TOSHIBA_FIR
 	tristate "Toshiba Type-O IR Port"
-	depends on IRDA && !64BIT
+	depends on IRDA && PCI && !64BIT
 	help
 	  Say Y here if you want to build support for the Toshiba Type-O IR
 	  and Donau oboe chipsets. These chipsets are used by the Toshiba
@@ -385,7 +385,7 @@
 
 config VIA_FIR
 	tristate "VIA VT8231/VT1211 SIR/MIR/FIR"
-	depends on IRDA && ISA
+	depends on IRDA && ISA && PCI
 	help
 	  Say Y here if you want to build support for the VIA VT8231
 	  and VIA VT1211 IrDA controllers, found on the motherboards using

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
