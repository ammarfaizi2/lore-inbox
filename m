Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267344AbSLKWdp>; Wed, 11 Dec 2002 17:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267345AbSLKWdh>; Wed, 11 Dec 2002 17:33:37 -0500
Received: from [195.39.17.254] ([195.39.17.254]:7428 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267344AbSLKWcE>;
	Wed, 11 Dec 2002 17:32:04 -0500
Date: Tue, 10 Dec 2002 22:52:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Kill crap from hp100.c
Message-ID: <20021210215236.GA494@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This kills assorted crap from hp100 driver. (For 2.4 and 2.5)
								Pavel


--- clean/drivers/net/hp100.c	2002-11-23 19:55:22.000000000 +0100
+++ linux-swsusp/drivers/net/hp100.c	2002-12-09 21:19:48.000000000 +0100
@@ -117,7 +117,6 @@
 #include <asm/bitops.h>
 #include <asm/io.h>
 
-#define LINUX_2_1
 typedef struct net_device_stats hp100_stats_t;
 
 #include "hp100.h"
@@ -285,7 +284,6 @@
 
 #define HP100_PCI_IDS_SIZE	(sizeof(hp100_pci_ids)/sizeof(struct hp100_pci_id))
 
-#if LINUX_VERSION_CODE >= 0x20400
 static struct pci_device_id hp100_pci_tbl[] __initdata = {
 	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_J2585A, PCI_ANY_ID, PCI_ANY_ID,},
 	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_J2585B, PCI_ANY_ID, PCI_ANY_ID,},
@@ -294,7 +292,6 @@
 	{}			/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(pci, hp100_pci_tbl);
-#endif				/* LINUX_VERSION_CODE >= 0x20400 */
 
 static int hp100_rx_ratio = HP100_DEFAULT_RX_RATIO;
 static int hp100_priority_tx = HP100_DEFAULT_PRIORITY_TX;

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
