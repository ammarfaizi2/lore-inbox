Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWBKAPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWBKAPf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 19:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWBKAPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 19:15:35 -0500
Received: from [85.8.13.51] ([85.8.13.51]:35462 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932263AbWBKAPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 19:15:35 -0500
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 1/2] [PCI] Secure Digital Host Controller id and regs
Date: Sat, 11 Feb 2006 01:15:23 +0100
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Message-Id: <20060211001523.10315.34499.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Class code and register definitions for the Secure Digital Host Controller
standard.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 include/linux/pci_ids.h  |    1 +
 include/linux/pci_regs.h |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 7a61ccd..5fa8ebe 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -69,6 +69,7 @@
 #define PCI_CLASS_SYSTEM_TIMER		0x0802
 #define PCI_CLASS_SYSTEM_RTC		0x0803
 #define PCI_CLASS_SYSTEM_PCI_HOTPLUG	0x0804
+#define PCI_CLASS_SYSTEM_SDHCI		0x0805
 #define PCI_CLASS_SYSTEM_OTHER		0x0880
 
 #define PCI_BASE_CLASS_INPUT		0x09
diff --git a/include/linux/pci_regs.h b/include/linux/pci_regs.h
index d27a78b..e6deda5 100644
--- a/include/linux/pci_regs.h
+++ b/include/linux/pci_regs.h
@@ -108,6 +108,9 @@
 #define PCI_INTERRUPT_PIN	0x3d	/* 8 bits */
 #define PCI_MIN_GNT		0x3e	/* 8 bits */
 #define PCI_MAX_LAT		0x3f	/* 8 bits */
+#define PCI_SLOT_INFO		0x40	/* 8 bits */
+#define  PCI_SLOT_INFO_SLOTS(x)		((x >> 4) & 7)
+#define  PCI_SLOT_INFO_FIRST_BAR_MASK	0x07
 
 /* Header type 1 (PCI-to-PCI bridges) */
 #define PCI_PRIMARY_BUS		0x18	/* Primary bus number */

