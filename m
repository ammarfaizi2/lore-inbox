Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVCRQeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVCRQeL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 11:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVCRQeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 11:34:11 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:48560 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S261727AbVCRQaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 11:30:30 -0500
Subject: [PATCH] new hp diva console port
From: Alex Williamson <alex.williamson@hp.com>
To: rmk+serial@arm.linux.org.uk
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: LOSL
Date: Fri, 18 Mar 2005 09:30:22 -0700
Message-Id: <1111163422.6693.6.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   The patch below adds IDs and setup for a new PCI Diva console port.
This device provides a single UART described by PCI Bar 1.  ID already
submitted to pciids.sf.net.  Please apply.  Thanks,

	Alex


Signed-off-by: Alex Williamson <alex.williamson@hp.com>

===== drivers/pci/pci.ids 1.74 vs edited =====
--- 1.74/drivers/pci/pci.ids	2005-03-15 08:33:16 -07:00
+++ edited/drivers/pci/pci.ids	2005-03-17 10:54:25 -07:00
@@ -1812,6 +1812,7 @@
 		103c 1226  Keystone SP2
 		103c 1227  Powerbar SP2
 		103c 1282  Everest SP2
+		103c 1301  Diva RMP3
 	1054  PCI Local Bus Adapter
 	1064  79C970 PCnet Ethernet Controller
 	108b  Visualize FXe
===== drivers/serial/8250_pci.c 1.51 vs edited =====
--- 1.51/drivers/serial/8250_pci.c	2005-03-08 15:08:47 -07:00
+++ edited/drivers/serial/8250_pci.c	2005-03-17 10:54:26 -07:00
@@ -2185,6 +2185,9 @@
 	 * HP Diva card
 	 */
 	{	PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_DIVA,
+		PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_DIVA_RMP3, 0, 0,
+		pbn_b1_1_115200 },
+	{	PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_DIVA,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_5_115200 },
 	{	PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_DIVA_AUX,
===== include/linux/pci_ids.h 1.208 vs edited =====
--- 1.208/include/linux/pci_ids.h	2005-03-15 08:27:33 -07:00
+++ edited/include/linux/pci_ids.h	2005-03-17 10:56:15 -07:00
@@ -709,6 +709,7 @@
 #define PCI_DEVICE_ID_HP_SX1000_IOC	0x127c
 #define PCI_DEVICE_ID_HP_DIVA_EVEREST	0x1282
 #define PCI_DEVICE_ID_HP_DIVA_AUX	0x1290
+#define PCI_DEVICE_ID_HP_DIVA_RMP3	0x1301
 #define PCI_DEVICE_ID_HP_CISSA		0x3220
 #define PCI_DEVICE_ID_HP_CISSB		0x3230
 #define PCI_DEVICE_ID_HP_ZX2_IOC	0x4031


