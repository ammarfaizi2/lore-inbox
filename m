Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267438AbUHDV2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267438AbUHDV2E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 17:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267440AbUHDV2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 17:28:04 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:11790 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S267438AbUHDV12 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 17:27:28 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: cciss update [5 of 6]
Date: Wed, 4 Aug 2004 16:27:27 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107436096@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-topic: cciss update [5 of 6]
Thread-index: AcR6adcKXDlLzKZ9QTOO48FHLDilOQ==
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: <akpm@osdl.org>, <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Aug 2004 21:27:28.0014 (UTC) FILETIME=[D79382E0:01C47A69]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 5 of 6
Name: p005_lancer_id_fix_for_268rc2

This patch fixes the PCI ID defines for a new controller due to be out
this year. It also adds 2 new defines to pci_ids.h to support this
controller and a SAS cciss controller due out in March '05.
Please apply patches in order.

Thanks,
mikem
-------------------------------------------------------------------------------
diff -burpN lx268-rc2-p004/drivers/block/cciss.c lx268-rc2/drivers/block/cciss.c
--- lx268-rc2-p004/drivers/block/cciss.c        2004-08-03 11:17:05.000000000 -0500
+++ lx268-rc2/drivers/block/cciss.c     2004-08-03 14:19:26.195069488 -0500
@@ncer_id_fix_for_268rc2.patch -45,14 +45,14 @@
 #include <linux/completion.h>

 #define CCISS_DRIVER_VERSION(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
-#define DRIVER_NAME "Compaq CISS Driver (v 2.6.2)"
+#define DRIVER_NAME "HP CISS Driver (v 2.6.2)"
 #define DRIVER_VERSION CCISS_DRIVER_VERSION(2,6,2)

 /* Embedded module documentation macros - see modules.h */
 MODULE_AUTHOR("Hewlett-Packard Company");
 MODULE_DESCRIPTION("Driver for HP Controller SA5xxx SA6xxx version 2.6.2");
 MODULE_SUPPORTED_DEVICE("HP SA5i SA5i+ SA532 SA5300 SA5312 SA641 SA642 SA6400"
-                       " SA6i");
+                       " SA6i SA6422 V100");
 MODULE_LICENSE("GPL");

 #include "cciss_cmd.h"
@@ -81,7 +81,7 @@ const struct pci_device_id cciss_pci_dev
                0x0E11, 0x4091, 0, 0, 0},
        { PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
                0x0E11, 0x409E, 0, 0, 0},
-       { PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
+       { PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISS,
                0x103C, 0x3211, 0, 0, 0},
        {0,}
 };
diff -burpN lx268-rc2-p004/include/linux/pci_ids.h lx268-rc2/include/linux/pci_ids.h
--- lx268-rc2-p004/include/linux/pci_ids.h      2004-07-30 10:00:23.000000000 -0500
+++ lx268-rc2/include/linux/pci_ids.h   2004-08-03 14:14:03.646104384 -0500
@@ -670,6 +670,8 @@
 #define PCI_DEVICE_ID_HP_SX1000_IOC    0x127c
 #define PCI_DEVICE_ID_HP_DIVA_EVEREST  0x1282
 #define PCI_DEVICE_ID_HP_DIVA_AUX      0x1290
+#define PCI_DEVICE_ID_HP_CISS          0x3211
+#define PCI_DEVICE_ID_HP_CISSA         0x3225

 #define PCI_VENDOR_ID_PCTECH           0x1042
 #define PCI_DEVICE_ID_PCTECH_RZ1000    0x1000

