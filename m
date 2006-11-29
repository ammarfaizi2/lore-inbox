Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967477AbWK2RFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967477AbWK2RFy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 12:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967483AbWK2RFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 12:05:54 -0500
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:55654 "EHLO
	outbound1-fra-R.bigfish.com") by vger.kernel.org with ESMTP
	id S967477AbWK2RFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 12:05:53 -0500
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Date: Wed, 29 Nov 2006 10:05:16 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-kernel@vger.kernel.org
cc: trivial@kernel.org
Subject: [PATCH] Trivial cleanup in the PCI IDs for the CS5535
Message-ID: <20061129170516.GF23793@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 29 Nov 2006 16:58:41.0792 (UTC)
 FILETIME=[9F7B9000:01C713D7]
X-WSS-ID: 697363F51WC1715394-09-01
Content-Type: multipart/mixed;
 boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Attached is a trivial patch that renames a poorly worded PCI ID 
for the Geode GX and CS5535 companion chips.  The graphics processor
and host bridge actually live in the northbridge on the integrated 
processor, not in the companion chip.  

---
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>

--jI8keyz6grp/JLjh
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=geode-trivial.patch
Content-Transfer-Encoding: 7bit

GEODE: Update and fixup the PCI IDs for the CS5535

From: Jordan Crouse <jordan.crouse@amd.com>

Clean up redundant and poorly worded PCI IDs

Signed-off-by:  Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/video/geode/gxfb_core.c |    2 +-
 include/linux/pci_ids.h         |    5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/geode/gxfb_core.c b/drivers/video/geode/gxfb_core.c
index 83ab18a..7b8d7d9 100644
--- a/drivers/video/geode/gxfb_core.c
+++ b/drivers/video/geode/gxfb_core.c
@@ -397,7 +397,7 @@ static void gxfb_remove(struct pci_dev *
 }
 
 static struct pci_device_id gxfb_id_table[] = {
-	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_VIDEO,
+	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_GX_VIDEO,
 	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
 	  0xff0000, 0 },
 	{ 0, }
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index fa4e1d7..9adbfbf 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -390,7 +390,7 @@ #define PCI_DEVICE_ID_NS_CS5535_ISA	0x00
 #define PCI_DEVICE_ID_NS_CS5535_IDE	0x002d
 #define PCI_DEVICE_ID_NS_CS5535_AUDIO	0x002e
 #define PCI_DEVICE_ID_NS_CS5535_USB	0x002f
-#define PCI_DEVICE_ID_NS_CS5535_VIDEO	0x0030
+#define PCI_DEVICE_ID_NS_GX_VIDEO	0x0030
 #define PCI_DEVICE_ID_NS_SATURN		0x0035
 #define PCI_DEVICE_ID_NS_SCx200_BRIDGE	0x0500
 #define PCI_DEVICE_ID_NS_SCx200_SMI	0x0501
@@ -403,8 +403,7 @@ #define PCI_DEVICE_ID_NS_SC1100_SMI	0x05
 #define PCI_DEVICE_ID_NS_SC1100_XBUS	0x0515
 #define PCI_DEVICE_ID_NS_87410		0xd001
 
-#define PCI_DEVICE_ID_NS_CS5535_HOST_BRIDGE  0x0028
-#define PCI_DEVICE_ID_NS_CS5535_ISA_BRIDGE   0x002b
+#define PCI_DEVICE_ID_NS_GX_HOST_BRIDGE  0x0028
 
 #define PCI_VENDOR_ID_TSENG		0x100c
 #define PCI_DEVICE_ID_TSENG_W32P_2	0x3202

--jI8keyz6grp/JLjh--


