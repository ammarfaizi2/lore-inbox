Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVFAE6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVFAE6h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 00:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVFAE6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 00:58:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:9437 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261251AbVFAE6U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 00:58:20 -0400
Cc: acurrid@nvidia.com
Subject: [PATCH] PCI: amd74xx patch for new NVIDIA device IDs
In-Reply-To: <11176025241488@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 31 May 2005 22:08:44 -0700
Message-Id: <111760252426@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: amd74xx patch for new NVIDIA device IDs

Here's the 2.6 amd74xx patch for NVIDIA MCP51.

Signed-off-by: Andy Currid <acurrid@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit af00f9811e0ccbd3db84ddc4cffb0da942653393
tree 5a9c3b7f7d61d96d3624ad130b173a761cb7dac2
parent 2ac2610b26c9da72820443328ff2c56c7b8c87b8
author Andy Currid <acurrid@nvidia.com> Mon, 23 May 2005 08:55:45 -0700
committer Greg KH <gregkh@suse.de> Tue, 31 May 2005 14:26:38 -0700

 drivers/ide/pci/amd74xx.c |    3 +++
 include/linux/pci_ids.h   |    6 ++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/pci/amd74xx.c b/drivers/ide/pci/amd74xx.c
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -72,6 +72,7 @@ static struct amd_ide_chip {
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	0x50, AMD_UDMA_133 },
 	{ 0 }
 };
 
@@ -487,6 +488,7 @@ static ide_pci_device_t amd74xx_chipsets
 	/* 12 */ DECLARE_NV_DEV("NFORCE3-250-SATA2"),
 	/* 13 */ DECLARE_NV_DEV("NFORCE-CK804"),
 	/* 14 */ DECLARE_NV_DEV("NFORCE-MCP04"),
+	/* 15 */ DECLARE_NV_DEV("NFORCE-MCP51"),
 };
 
 static int __devinit amd74xx_probe(struct pci_dev *dev, const struct pci_device_id *id)
@@ -521,6 +523,7 @@ static struct pci_device_id amd74xx_pci_
 #endif
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, amd74xx_pci_tbl);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1230,6 +1230,12 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_900XGL	0x0258
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_750XGL	0x0259
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL	0x025B
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE	0x0265
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA	0x0266
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2	0x0267
+#define PCI_DEVICE_ID_NVIDIA_NVENET_12		0x0268
+#define PCI_DEVICE_ID_NVIDIA_NVENET_13		0x0269
+#define PCI_DEVICE_ID_NVIDIA_MCP51_AUDIO	0x026B
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4800	0x0280
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4800_8X    0x0281
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4800SE     0x0282

