Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbUJXLON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbUJXLON (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 07:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbUJXLOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 07:14:12 -0400
Received: from nl-ams-slo-l4-01-pip-6.chellonetwork.com ([213.46.243.23]:2365
	"EHLO amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S261442AbUJXLLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 07:11:13 -0400
Date: Sun, 24 Oct 2004 13:11:10 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg Kroah-Hartman <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       sensors@stimpy.netroedge.com
Subject: [PATCH] SCx200_ACB depends on PCI
Message-ID: <Pine.LNX.4.61.0410241309580.27184@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


SCx200_ACB is a PCI driver and thus should depend on PCI

--- linux-2.6.10-rc1/drivers/i2c/busses/Kconfig.orig	2004-10-23 10:33:01.000000000 +0200
+++ linux-2.6.10-rc1/drivers/i2c/busses/Kconfig	2004-10-24 12:50:17.000000000 +0200
@@ -339,7 +339,7 @@ config SCx200_I2C_SDA
 
 config SCx200_ACB
 	tristate "NatSemi SCx200 ACCESS.bus"
-	depends on I2C
+	depends on I2C && PCI
 	help
 	  Enable the use of the ACCESS.bus controllers of a SCx200 processor.
 
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
