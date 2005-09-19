Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbVISNRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVISNRx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 09:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVISNRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 09:17:53 -0400
Received: from hqemgate03.nvidia.com ([216.228.112.143]:32841 "EHLO
	HQEMGATE03.nvidia.com") by vger.kernel.org with ESMTP
	id S932314AbVISNRw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 09:17:52 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 2.6.14-rc1] Fix broken NVIDIA device ID in sata_nv
Date: Mon, 19 Sep 2005 06:17:52 -0700
Message-ID: <8E5ACAE05E6B9E44A2903C693A5D4E8A091D1CD6@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.14-rc1] Fix broken NVIDIA device ID in sata_nv
Thread-Index: AcW9HIuy+dqb0lglTBCNE4zn+Ec75w==
From: "Andy Currid" <ACurrid@nvidia.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Sep 2005 13:17:51.0705 (UTC) FILETIME=[89B5BC90:01C5BD1C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please apply this patch that corrects an NVIDIA SATA device ID in
2.6.14-rc1.

Thanks

Andy
--


Signed-off-by: Andy Currid <acurrid@nvidia.com>

diff -upr linux-2.6.14-rc1/drivers/scsi/sata_nv.c
linux-2.6.14-rc1devel/drivers/scsi/sata_nv.c
--- linux-2.6.14-rc1/drivers/scsi/sata_nv.c	2005-09-16
18:48:18.000000000 -0700
+++ linux-2.6.14-rc1devel/drivers/scsi/sata_nv.c	2005-09-16
18:49:38.000000000 -0700
@@ -158,6 +158,8 @@ static struct pci_device_id nv_pci_tbl[]
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP51 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP55 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP55 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
diff -upr linux-2.6.14-rc1/include/linux/pci_ids.h
linux-2.6.14-rc1devel/include/linux/pci_ids.h
--- linux-2.6.14-rc1/include/linux/pci_ids.h	2005-09-16
18:48:20.000000000 -0700
+++ linux-2.6.14-rc1devel/include/linux/pci_ids.h	2005-09-16
18:49:18.000000000 -0700
@@ -1249,7 +1249,8 @@
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA	0x0266
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2	0x0267
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE	0x036E
-#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA	0x036F
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA	0x037E
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2	0x037F
 #define PCI_DEVICE_ID_NVIDIA_NVENET_12		0x0268
 #define PCI_DEVICE_ID_NVIDIA_NVENET_13		0x0269
 #define PCI_DEVICE_ID_NVIDIA_MCP51_AUDIO	0x026B
