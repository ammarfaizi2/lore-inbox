Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030599AbWFVEsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030599AbWFVEsr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 00:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932794AbWFVEsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 00:48:47 -0400
Received: from z06.nvidia.com ([209.213.198.25]:33742 "EHLO thelma.nvidia.com")
	by vger.kernel.org with ESMTP id S932793AbWFVEsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 00:48:46 -0400
Subject: [PATCH] Add MCP65 support for sata_nv driver
From: Andrew Chew <achew@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: jeff@garzik.org
Content-Type: text/plain
Date: Thu, 22 Jun 2006 00:38:45 -0700
Message-Id: <1150961925.5109.6.camel@achew-linux>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Splitting up patch and resending.

This patch adds MCP65 SATA controller support to the sata_nv driver.

Signed-off-by: Andrew Chew <achew@nvidia.com>




diff -uprN -X linux-2.6.16.19/Documentation/dontdiff linux-2.6.16.19.original/drivers/scsi/sata_nv.c linux-2.6.16.19/drivers/scsi/sata_nv.c
--- linux-2.6.16.19.original/drivers/scsi/sata_nv.c	2006-05-30 17:31:44.000000000 -0700
+++ linux-2.6.16.19/drivers/scsi/sata_nv.c	2006-06-05 17:20:48.000000000 -0700
@@ -166,12 +166,17 @@ static const struct pci_device_id nv_pci
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA2,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA3,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA4,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
-		PCI_ANY_ID, PCI_ANY_ID,
-		PCI_CLASS_STORAGE_RAID<<8, 0xffff00, GENERIC },
 	{ 0, } /* terminate list */
 };
 
diff -uprN -X linux-2.6.16.19/Documentation/dontdiff linux-2.6.16.19.original/include/linux/pci_ids.h linux-2.6.16.19/include/linux/pci_ids.h
--- linux-2.6.16.19.original/include/linux/pci_ids.h	2006-05-30 17:31:44.000000000 -0700
+++ linux-2.6.16.19/include/linux/pci_ids.h	2006-06-05 17:14:47.000000000 -0700
@@ -1171,6 +1171,15 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO_FX_1100         0x034E
 #define PCI_DEVICE_ID_NVIDIA_NVENET_14              0x0372
 #define PCI_DEVICE_ID_NVIDIA_NVENET_15              0x0373
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA      0x045C
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA2     0x045D
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA3     0x045E
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA4     0x045F
 
 #define PCI_VENDOR_ID_IMS		0x10e0
 #define PCI_DEVICE_ID_IMS_TT128		0x9128


