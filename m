Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264941AbUAAUFR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264574AbUAAUEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:04:47 -0500
Received: from amsfep18-int.chello.nl ([213.46.243.14]:23877 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S264583AbUAAUBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:01:53 -0500
Date: Thu, 1 Jan 2004 21:01:51 +0100
Message-Id: <200401012001.i01K1p1C031727@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 347] Atari Hades PCI C99
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atari Hades PCI: Use C99 struct initializers

--- linux-2.6.0/arch/m68k/atari/hades-pci.c	Sun Jun 15 09:37:32 2003
+++ linux-m68k-2.6.0/arch/m68k/atari/hades-pci.c	Sun Oct  5 11:57:22 2003
@@ -40,13 +40,20 @@
 static const char pci_io_name[] = "PCI I/O space";
 static const char pci_config_name[] = "PCI config space";
 
-static struct resource config_space = { pci_config_name, HADES_CONFIG_BASE,
-										HADES_CONFIG_BASE + HADES_CONFIG_SIZE - 1 };
-static struct resource io_space = { pci_io_name, HADES_IO_BASE, HADES_IO_BASE +
-								    HADES_IO_SIZE - 1 };
+static struct resource config_space = {
+    .name = pci_config_name,
+    .start = HADES_CONFIG_BASE,
+    .end = HADES_CONFIG_BASE + HADES_CONFIG_SIZE - 1
+};
+static struct resource io_space = {
+    .name = pci_io_name,
+    .start = HADES_IO_BASE,
+    .end = HADES_IO_BASE + HADES_IO_SIZE - 1
+};
 
-static const unsigned long pci_conf_base_phys[] = { 0xA0080000, 0xA0040000,
-												    0xA0020000, 0xA0010000 };
+static const unsigned long pci_conf_base_phys[] = {
+    0xA0080000, 0xA0040000, 0xA0020000, 0xA0010000
+};
 static unsigned long pci_conf_base_virt[N_SLOTS];
 static unsigned long pci_io_base_virt;
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
