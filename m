Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752844AbWKCADE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbWKCADE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 19:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834AbWKCADE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 19:03:04 -0500
Received: from havoc.gtf.org ([69.61.125.42]:26542 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1752760AbWKCADB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 19:03:01 -0500
Date: Thu, 2 Nov 2006 19:03:00 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] libata PCI ids (updated)
Message-ID: <20061103000300.GA3759@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Updated with the necessary constant.



Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/ahci.c      |    8 ++++++++
 drivers/ata/pata_amd.c  |    2 ++
 include/linux/pci_ids.h |    1 +
 3 files changed, 11 insertions(+), 0 deletions(-)

Peer Chen:
      [libata] Add support for PATA controllers of MCP67 to pata_amd.c.
      [libata] Add support for AHCI controllers of MCP67.
      pci_ids.h: Add NVIDIA PCI ID

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 988f8bb..234197e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -334,6 +334,14 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(NVIDIA, 0x044d), board_ahci },		/* MCP65 */
 	{ PCI_VDEVICE(NVIDIA, 0x044e), board_ahci },		/* MCP65 */
 	{ PCI_VDEVICE(NVIDIA, 0x044f), board_ahci },		/* MCP65 */
+	{ PCI_VDEVICE(NVIDIA, 0x0554), board_ahci },		/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0555), board_ahci },		/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0556), board_ahci },		/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0557), board_ahci },		/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0558), board_ahci },		/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0559), board_ahci },		/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x055a), board_ahci },		/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x055b), board_ahci },		/* MCP67 */
 
 	/* SiS */
 	{ PCI_VDEVICE(SI, 0x1184), board_ahci }, /* SiS 966 */
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 29234c8..5c47a9e 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -677,6 +677,8 @@ static const struct pci_device_id amd[] 
 	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE),	8 },
 	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE),	8 },
 	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE),	8 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE),	8 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE),	8 },
 	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE),		9 },
 
 	{ },
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index f3a168f..fa4e1d7 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1213,6 +1213,7 @@ #define PCI_DEVICE_ID_NVIDIA_NVENET_20  
 #define PCI_DEVICE_ID_NVIDIA_NVENET_21              0x0451
 #define PCI_DEVICE_ID_NVIDIA_NVENET_22              0x0452
 #define PCI_DEVICE_ID_NVIDIA_NVENET_23              0x0453
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE       0x0560
 
 #define PCI_VENDOR_ID_IMS		0x10e0
 #define PCI_DEVICE_ID_IMS_TT128		0x9128
