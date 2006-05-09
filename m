Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWEIFWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWEIFWL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 01:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWEIFWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 01:22:10 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:17340 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751383AbWEIFWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 01:22:09 -0400
Subject: [PATCH] TI PCIxx12 CardBus controller support
From: Alex Williamson <alex.williamson@hp.com>
To: linux-pcmcia@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: LOSL
Date: Mon, 08 May 2006 23:22:07 -0600
Message-Id: <1147152127.8911.108.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   The patch below adds support for the TI PCIxx12 CardBus controllers.
This seems to be sufficient to detect the cardbus bridge on an HP nc6320
and works with an orinoco wifi card.  Thanks,

	Alex

Signed-off-by: Alex Williamson <alex.williamson@hp.com>
---

diff -r ce52ec65b1a0 drivers/pcmcia/ti113x.h
--- a/drivers/pcmcia/ti113x.h	Tue May  9 00:41:05 2006
+++ b/drivers/pcmcia/ti113x.h	Mon May  8 23:08:29 2006
@@ -647,6 +647,7 @@
 		 */
 		break;
 
+	case PCI_DEVICE_ID_TI_XX12:
 	case PCI_DEVICE_ID_TI_X515:
 	case PCI_DEVICE_ID_TI_X420:
 	case PCI_DEVICE_ID_TI_X620:
diff -r ce52ec65b1a0 drivers/pcmcia/yenta_socket.c
--- a/drivers/pcmcia/yenta_socket.c	Tue May  9 00:41:05 2006
+++ b/drivers/pcmcia/yenta_socket.c	Mon May  8 23:08:29 2006
@@ -1232,6 +1232,7 @@
 
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_XX21_XX11, TI12XX),
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_X515, TI12XX),
+	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_XX12, TI12XX),
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_X420, TI12XX),
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_X620, TI12XX),
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_7410, TI12XX),
diff -r ce52ec65b1a0 include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Tue May  9 00:41:05 2006
+++ b/include/linux/pci_ids.h	Mon May  8 23:08:29 2006
@@ -726,6 +726,7 @@
 #define PCI_DEVICE_ID_TI_4450		0x8011
 #define PCI_DEVICE_ID_TI_XX21_XX11	0x8031
 #define PCI_DEVICE_ID_TI_X515		0x8036
+#define PCI_DEVICE_ID_TI_XX12		0x8039
 #define PCI_DEVICE_ID_TI_1130		0xac12
 #define PCI_DEVICE_ID_TI_1031		0xac13
 #define PCI_DEVICE_ID_TI_1131		0xac15


