Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUHMWCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUHMWCp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 18:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267602AbUHMWCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 18:02:45 -0400
Received: from zmamail05.zma.compaq.com ([161.114.64.105]:24582 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id S263962AbUHMWCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 18:02:43 -0400
Date: Fri, 13 Aug 2004 17:02:00 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: marcelo.tosatti@cyclades.com, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss update [1/5] PCI ID fix for cciss SATA hba
Message-ID: <20040813220200.GA1016@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 of 5.
This patch fixes the PCI ID for our cciss based SATA controller
due out later this year. Also adds the new PCI ID to pci_ids.h.
Applies to 2.4.27.

Thanks,
mikem
-------------------------------------------------------------------------------
diff -burNp lx2427.orig/drivers/block/cciss.c lx2427/drivers/block/cciss.c
--- lx2427.orig/drivers/block/cciss.c	2004-08-07 18:26:04.000000000 -0500
+++ lx2427/drivers/block/cciss.c	2004-08-13 15:38:30.808314376 -0500
@@ -80,7 +80,7 @@ const struct pci_device_id cciss_pci_dev
                         0x0E11, 0x4091, 0, 0, 0},
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
                         0x0E11, 0x409E, 0, 0, 0},
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
+	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISS,
                         0x103C, 0x3211, 0, 0, 0},
 	{0,}
 };
diff -burNp lx2427.orig/include/linux/pci_ids.h lx2427/include/linux/pci_ids.h
--- lx2427.orig/include/linux/pci_ids.h	2004-08-07 18:26:06.000000000 -0500
+++ lx2427/include/linux/pci_ids.h	2004-08-13 15:40:01.304556856 -0500
@@ -606,6 +606,7 @@
 #define PCI_DEVICE_ID_HP_ZX1_IOC	0x122a
 #define PCI_DEVICE_ID_HP_PCIX_LBA	0x122e
 #define PCI_DEVICE_ID_HP_SX1000_IOC	0x127c
+#define PCI_DEVICE_ID_HP_CISS		0x3210
 
 #define PCI_VENDOR_ID_PCTECH		0x1042
 #define PCI_DEVICE_ID_PCTECH_RZ1000	0x1000
