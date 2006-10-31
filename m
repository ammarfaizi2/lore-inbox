Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422923AbWJaIG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422923AbWJaIG1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422928AbWJaIG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:06:27 -0500
Received: from hqemgate01.nvidia.com ([216.228.112.170]:60430 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S1422923AbWJaIGZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:06:25 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [Patch 1/2] SCSI: Add nvidia SATA controllers of MCP67 support to sata_nv.c
Date: Tue, 31 Oct 2006 16:01:06 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0C42D597@hkemmail01.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch 1/2] SCSI: Add nvidia SATA controllers of MCP67 support to sata_nv.c
Thread-Index: Acb8wDGkGXuect/5R+q0iHR+L8zrowAAm9kA
From: "Peer Chen" <pchen@nvidia.com>
To: <jgarzik@pobox.com>, <linux-ide@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 31 Oct 2006 08:01:08.0641 (UTC) FILETIME=[B9208910:01C6FCC2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support for SATA controllers of MCP67.
The following sata_nv.c patch is based on kernel 2.6.18.

Signed-off by: Peer Chen <pchen@nvidia.com>
===================================

--- sata_nv.c.orig	2006-10-31 13:43:19.000000000 +0800
+++ sata_nv.c	2006-10-31 13:49:21.000000000 +0800
@@ -134,10 +134,22 @@ static const struct pci_device_id nv_pci
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
-	{ PCI_VENDOR_ID_NVIDIA, 0x045c, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
GENERIC },
-	{ PCI_VENDOR_ID_NVIDIA, 0x045d, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
GENERIC },
-	{ PCI_VENDOR_ID_NVIDIA, 0x045e, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
GENERIC },
-	{ PCI_VENDOR_ID_NVIDIA, 0x045f, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA2,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA3,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA4,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_SATA,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_SATA2,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_SATA3,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_SATA4,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },    
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
