Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVAHATM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVAHATM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 19:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVAGWv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:51:56 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.21]:49990 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S261688AbVAGWuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:50:54 -0500
Date: Fri, 7 Jan 2005 23:50:49 +0100
Message-Id: <200501072250.j07MonUe012310@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       wbsd-devel@list.drzeus.cx, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 540] MMC_WBSD depends on ISA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MMC_WBSD depends on ISA (needs isa_virt_to_bus())

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10/drivers/mmc/Kconfig	2004-12-26 10:47:03.000000000 +0100
+++ linux-m68k-2.6.10/drivers/mmc/Kconfig	2005-01-01 10:35:09.000000000 +0100
@@ -51,7 +51,7 @@ config MMC_PXA
 
 config MMC_WBSD
 	tristate "Winbond W83L51xD SD/MMC Card Interface support"
-	depends on MMC
+	depends on MMC && ISA
 	help
 	  This selects the Winbond(R) W83L51xD Secure digital and
           Multimedia card Interface.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
