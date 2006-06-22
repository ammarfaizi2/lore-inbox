Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030600AbWFVEtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030600AbWFVEtx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 00:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030602AbWFVEtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 00:49:53 -0400
Received: from z06.nvidia.com ([209.213.198.25]:16853 "EHLO thelma.nvidia.com")
	by vger.kernel.org with ESMTP id S1030600AbWFVEtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 00:49:52 -0400
Subject: [PATCH] Add MCP65 support for ahci driver
From: Andrew Chew <achew@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: jeff@garzik.org
Content-Type: text/plain
Date: Thu, 22 Jun 2006 00:40:04 -0700
Message-Id: <1150962004.5109.9.camel@achew-linux>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Splitting up patch and resending.

This patch adds support for the MCP65 AHCI controller to the AHCI driver.

Signed-off-by: Andrew Chew <achew@nvidia.com>




diff -uprN -X linux-2.6.16.19/Documentation/dontdiff linux-2.6.16.19.original/drivers/scsi/ahci.c linux-2.6.16.19/drivers/scsi/ahci.c
--- linux-2.6.16.19.original/drivers/scsi/ahci.c	2006-05-30 17:31:44.000000000 -0700
+++ linux-2.6.16.19/drivers/scsi/ahci.c	2006-06-05 17:17:57.000000000 -0700
@@ -290,6 +290,18 @@ static const struct pci_device_id ahci_p
 	  board_ahci }, /* JMicron JMB360 */
 	{ 0x197b, 0x2363, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* JMicron JMB363 */
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* MCP65 */
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI2,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* MCP65 */
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI3,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* MCP65 */
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI4,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* MCP65 */
 	{ }	/* terminate list */
 };
 
diff -uprN -X linux-2.6.16.19/Documentation/dontdiff linux-2.6.16.19.original/include/linux/pci_ids.h linux-2.6.16.19/include/linux/pci_ids.h
--- linux-2.6.16.19.original/include/linux/pci_ids.h	2006-05-30 17:31:44.000000000 -0700
+++ linux-2.6.16.19/include/linux/pci_ids.h	2006-06-05 17:14:47.000000000 -0700
@@ -1171,6 +1171,15 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO_FX_1100         0x034E
 #define PCI_DEVICE_ID_NVIDIA_NVENET_14              0x0372
 #define PCI_DEVICE_ID_NVIDIA_NVENET_15              0x0373
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI      0x044C
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI2     0x044D
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI3     0x044E
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI4     0x044F
 
 #define PCI_VENDOR_ID_IMS		0x10e0
 #define PCI_DEVICE_ID_IMS_TT128		0x9128


