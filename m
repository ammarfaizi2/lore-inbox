Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267542AbUHJQNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267542AbUHJQNG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267531AbUHJQLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:11:54 -0400
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:33550 "EHLO
	zcamail04.zca.compaq.com") by vger.kernel.org with ESMTP
	id S267490AbUHJQJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:09:57 -0400
Date: Tue, 10 Aug 2004 11:09:17 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss update [5/8] PCI ID fix for cciss based SATA hba
Message-ID: <20040810160917.GE19909@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch 5 of 8

This patch fixes the vendor ID for our cciss based SATA controller due
out later this year. It also adds the new PCI ID to pci_ids.h
Applies to 2.6.8-rc4. Please apply patches in order.

Thanks,
mikem
-------------------------------------------------------------------------------
diff -burNp lx268-rc3-p004/drivers/block/cciss.c lx268-rc3/drivers/block/cciss.c
--- lx268-rc3-p004/drivers/block/cciss.c	2004-08-05 11:16:03.000000000 -0500
+++ lx268-rc3/drivers/block/cciss.c	2004-08-05 14:16:11.567565016 -0500
@@ -46,14 +46,14 @@
 #include <linux/completion.h>
 
 #define CCISS_DRIVER_VERSION(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
-#define DRIVER_NAME "Compaq CISS Driver (v 2.6.2)"
+#define DRIVER_NAME "HP CISS Driver (v 2.6.2)"
 #define DRIVER_VERSION CCISS_DRIVER_VERSION(2,6,2)
 
 /* Embedded module documentation macros - see modules.h */
 MODULE_AUTHOR("Hewlett-Packard Company");
 MODULE_DESCRIPTION("Driver for HP Controller SA5xxx SA6xxx version 2.6.2");
 MODULE_SUPPORTED_DEVICE("HP SA5i SA5i+ SA532 SA5300 SA5312 SA641 SA642 SA6400"
-			" SA6i");
+			" SA6i V100");
 MODULE_LICENSE("GPL");
 
 #include "cciss_cmd.h"
@@ -82,7 +82,7 @@ const struct pci_device_id cciss_pci_dev
 		0x0E11, 0x4091, 0, 0, 0},
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
 		0x0E11, 0x409E, 0, 0, 0},
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
+	{ PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISS,
 		0x103C, 0x3211, 0, 0, 0},
 	{0,}
 };
diff -burNp lx268-rc3-p004/include/linux/pci_ids.h lx268-rc3/include/linux/pci_ids.h
--- lx268-rc3-p004/include/linux/pci_ids.h	2004-08-05 09:56:00.000000000 -0500
+++ lx268-rc3/include/linux/pci_ids.h	2004-08-05 14:16:33.841178912 -0500
@@ -670,6 +670,7 @@
 #define PCI_DEVICE_ID_HP_SX1000_IOC	0x127c
 #define PCI_DEVICE_ID_HP_DIVA_EVEREST	0x1282
 #define PCI_DEVICE_ID_HP_DIVA_AUX	0x1290
+#define PCI_DEVICE_ID_HP_CISS		0x3211
 
 #define PCI_VENDOR_ID_PCTECH		0x1042
 #define PCI_DEVICE_ID_PCTECH_RZ1000	0x1000
