Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267438AbUHWTRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267438AbUHWTRa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267272AbUHWTPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:15:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:5316 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267269AbUHWSgx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:53 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860811120@kroah.com>
Date: Mon, 23 Aug 2004 11:34:41 -0700
Message-Id: <10932860812984@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1784.41.3, 2004/07/14 13:31:00-07:00, buytenh@wantstofly.org

[PATCH] PCI: more New PCI vendor/device ID for Radisys ENP-2611 board

OK, sorry to bother, some more bits.

- Add PCI IDs for the IXP2400 and IXP2800 network processors.
- Fix typo in description for 8086:9000.
- Correct tab->space after #define in definition of IXP4xx device ID.
- ENP-2611 can appear behind a 21555.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci.ids     |    5 ++++-
 include/linux/pci_ids.h |    4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)


diff -Nru a/drivers/pci/pci.ids b/drivers/pci/pci.ids
--- a/drivers/pci/pci.ids	2004-08-23 11:09:01 -07:00
+++ b/drivers/pci/pci.ids	2004-08-23 11:09:01 -07:00
@@ -8175,7 +8175,9 @@
 	84e6  460GX - 82466GX Wide and fast PCI eXpander Bridge (WXB)
 	84ea  460GX - 84460GX AGP Bridge (GXB function 1)
 	8500  IXP4xx Family  Network Processor (IXP420, 421, 422, 425 and IXC1100)
-	9000  Intel IXP2000 Familly Network Processor
+	9000  Intel IXP2000 Family Network Processor
+	9001  Intel IXP2400 Network Processor
+	9004  Intel IXP2800 Network Processor
 	9621  Integrated RAID
 	9622  Integrated RAID
 	9641  Integrated RAID
@@ -8184,6 +8186,7 @@
 # observed, and documented in Intel revision note; new mask of 1011:0026
 	b154  21154 PCI-to-PCI Bridge
 	b555  21555 Non transparent PCI-to-PCI Bridge
+		1331 0030  Radisys ENP-2611
 		4c53 1050  CT7 mainboard
 		4c53 1051  CE7 mainboard
 		e4bf 1000  CC8-1-BLUES
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2004-08-23 11:09:01 -07:00
+++ b/include/linux/pci_ids.h	2004-08-23 11:09:01 -07:00
@@ -2209,7 +2209,9 @@
 #define PCI_DEVICE_ID_INTEL_82451NX	0x84ca
 #define PCI_DEVICE_ID_INTEL_82454NX     0x84cb
 #define PCI_DEVICE_ID_INTEL_84460GX	0x84ea
-#define	PCI_DEVICE_ID_INTEL_IXP4XX	0x8500
+#define PCI_DEVICE_ID_INTEL_IXP4XX	0x8500
+#define PCI_DEVICE_ID_INTEL_IXP2400	0x9001
+#define PCI_DEVICE_ID_INTEL_IXP2800	0x9004
 
 #define PCI_VENDOR_ID_COMPUTONE		0x8e0e
 #define PCI_DEVICE_ID_COMPUTONE_IP2EX	0x0291

