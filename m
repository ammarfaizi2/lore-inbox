Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946045AbWKAHXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946045AbWKAHXm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 02:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423724AbWKAHXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 02:23:41 -0500
Received: from hqemgate02.nvidia.com ([216.228.112.143]:60482 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S1423642AbWKAHXk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 02:23:40 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 1/2] sata_nv: Add nvidia SATA controllers of MCP67 support to sata_nv.c
Date: Wed, 1 Nov 2006 15:23:23 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0C54F43D@hkemmail01.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/2] sata_nv: Add nvidia SATA controllers of MCP67 support to sata_nv.c
Thread-Index: Acb9hp1R0SerVHh8QJCQi/98gAldxw==
From: "Peer Chen" <pchen@nvidia.com>
To: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <jgarzik@pobox.com>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
X-OriginalArrivalTime: 01 Nov 2006 07:23:26.0548 (UTC) FILETIME=[9F3A4940:01C6FD86]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SATA controllers of MCP67.
The patch will be applied to kernel 2.6.19-rc4-git1.

Signed-off-by: Peer Chen <pchen@nvidia.com>

=============================================
--- linux-2.6.19-rc4-git1/drivers/ata/sata_nv.c.orig	2006-10-31
20:44:45.000000000 +0800
+++ linux-2.6.19-rc4-git1/drivers/ata/sata_nv.c	2006-11-01
00:14:48.000000000 +0800
@@ -117,10 +117,14 @@ static const struct pci_device_id nv_pci
 	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA),
GENERIC },
 	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA2),
GENERIC },
 	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3),
GENERIC },
-	{ PCI_VDEVICE(NVIDIA, 0x045c), GENERIC },
-	{ PCI_VDEVICE(NVIDIA, 0x045d), GENERIC },
-	{ PCI_VDEVICE(NVIDIA, 0x045e), GENERIC },
-	{ PCI_VDEVICE(NVIDIA, 0x045f), GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA),
GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA2),
GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA3),
GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA4),
GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_SATA),
GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_SATA2),
GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_SATA3),
GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_SATA4),
GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
