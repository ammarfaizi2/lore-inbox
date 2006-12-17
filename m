Return-Path: <linux-kernel-owner+w=401wt.eu-S1750932AbWLQTeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWLQTeZ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 14:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWLQTeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 14:34:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53519 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbWLQTeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 14:34:25 -0500
Date: Sun, 17 Dec 2006 14:34:09 -0500
From: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux1394-devel@lists.sourceforge.net, stefanr@s5r6.in-berlin.de
Subject: [PATCH] Add PCI class ID for firewire OHCI controllers.
Message-ID: <20061217193409.GA19585@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pull this define out of drivers/ieee1394/ohci1394.c and rename to match
other PCI class defines.
---
 drivers/ieee1394/ohci1394.c |    4 +---
 include/linux/pci_ids.h     |    1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ieee1394/ohci1394.c b/drivers/ieee1394/ohci1394.c
index 6e8ea91..3bc55d4 100644
--- a/drivers/ieee1394/ohci1394.c
+++ b/drivers/ieee1394/ohci1394.c
@@ -3584,11 +3584,9 @@ #endif /* CONFIG_PPC_PMAC */
 }
 #endif /* CONFIG_PM */
 
-#define PCI_CLASS_FIREWIRE_OHCI     ((PCI_CLASS_SERIAL_FIREWIRE << 8) | 0x10)
-
 static struct pci_device_id ohci1394_pci_tbl[] = {
 	{
-		.class = 	PCI_CLASS_FIREWIRE_OHCI,
+		.class = 	PCI_CLASS_SERIAL_FIREWIRE_OHCI,
 		.class_mask = 	PCI_ANY_ID,
 		.vendor =	PCI_ANY_ID,
 		.device =	PCI_ANY_ID,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index c09da1e..4849b26 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -95,6 +95,7 @@ #define PCI_CLASS_PROCESSOR_CO		0x0b40
 
 #define PCI_BASE_CLASS_SERIAL		0x0c
 #define PCI_CLASS_SERIAL_FIREWIRE	0x0c00
+#define PCI_CLASS_SERIAL_FIREWIRE_OHCI	0x0c0010
 #define PCI_CLASS_SERIAL_ACCESS		0x0c01
 #define PCI_CLASS_SERIAL_SSA		0x0c02
 #define PCI_CLASS_SERIAL_USB		0x0c03
-- 
1.4.2.4
