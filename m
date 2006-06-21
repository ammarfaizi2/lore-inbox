Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751931AbWFUCcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbWFUCcH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 22:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbWFUCcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 22:32:07 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:2559 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751929AbWFUCcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 22:32:05 -0400
Date: Tue, 20 Jun 2006 22:32:02 -0400
From: Brice Goglin <brice@myri.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] Rename PCI_CAP_ID_HT_IRQCONF into PCI_CAP_ID_HT
Message-ID: <20060621023201.GB16292@myri.com>
References: <20060621023104.GA16271@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621023104.GA16271@myri.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2/6] Rename PCI_CAP_ID_HT_IRQCONF into PCI_CAP_ID_HT

0x08 is the HT capability, while PCI_CAP_ID_HT_IRQCONF would be
the subtype 0x80 that mpic_scan_ht_pic() uses.
Rename PCI_CAP_ID_HT_IRQCONF into PCI_CAP_ID_HT.

Signed-off-by: Brice Goglin <brice@myri.com>
---
 arch/powerpc/sysdev/mpic.c |    2 +-
 include/linux/pci_regs.h   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-mm/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-mm.orig/arch/powerpc/sysdev/mpic.c	2006-06-20 22:02:04.000000000 -0400
+++ linux-mm/arch/powerpc/sysdev/mpic.c	2006-06-20 22:03:28.000000000 -0400
@@ -250,7 +250,7 @@
 	for (pos = readb(devbase + PCI_CAPABILITY_LIST); pos != 0;
 	     pos = readb(devbase + pos + PCI_CAP_LIST_NEXT)) {
 		u8 id = readb(devbase + pos + PCI_CAP_LIST_ID);
-		if (id == PCI_CAP_ID_HT_IRQCONF) {
+		if (id == PCI_CAP_ID_HT) {
 			id = readb(devbase + pos + 3);
 			if (id == 0x80)
 				break;
Index: linux-mm/include/linux/pci_regs.h
===================================================================
--- linux-mm.orig/include/linux/pci_regs.h	2006-06-20 22:02:04.000000000 -0400
+++ linux-mm/include/linux/pci_regs.h	2006-06-20 22:03:28.000000000 -0400
@@ -196,7 +196,7 @@
 #define  PCI_CAP_ID_MSI		0x05	/* Message Signalled Interrupts */
 #define  PCI_CAP_ID_CHSWP	0x06	/* CompactPCI HotSwap */
 #define  PCI_CAP_ID_PCIX	0x07	/* PCI-X */
-#define  PCI_CAP_ID_HT_IRQCONF	0x08	/* HyperTransport IRQ Configuration */
+#define  PCI_CAP_ID_HT		0x08	/* HyperTransport */
 #define  PCI_CAP_ID_VNDR	0x09	/* Vendor specific capability */
 #define  PCI_CAP_ID_SHPC 	0x0C	/* PCI Standard Hot-Plug Controller */
 #define  PCI_CAP_ID_EXP 	0x10	/* PCI Express */
