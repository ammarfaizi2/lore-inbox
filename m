Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbVDLUFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbVDLUFh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVDLT6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:58:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:41160 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262155AbVDLKbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:46 -0400
Message-Id: <200504121031.j3CAVbLW005356@shell0.pdx.osdl.net>
Subject: [patch 058/198] irq and pci_ids: patch for Intel ESB2
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jason.d.gaston@intel.com,
       Jason.d.gaston@intel.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jason Gaston <jason.d.gaston@intel.com>

This patch adds the Intel ESB2 DID's to the irq.c and pci_ids.h files.

Signed-off-by: Jason Gaston <Jason.d.gaston@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/i386/pci/irq.c     |    1 +
 25-akpm/include/linux/pci_ids.h |   31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff -puN arch/i386/pci/irq.c~irq-and-pci_ids-patch-for-intel-esb2 arch/i386/pci/irq.c
--- 25/arch/i386/pci/irq.c~irq-and-pci_ids-patch-for-intel-esb2	2005-04-12 03:21:17.257513360 -0700
+++ 25-akpm/arch/i386/pci/irq.c	2005-04-12 03:21:17.262512600 -0700
@@ -495,6 +495,7 @@ static __init int intel_router_probe(str
 		case PCI_DEVICE_ID_INTEL_ICH6_1:
 		case PCI_DEVICE_ID_INTEL_ICH7_0:
 		case PCI_DEVICE_ID_INTEL_ICH7_1:
+		case PCI_DEVICE_ID_INTEL_ESB2_0:
 			r->name = "PIIX/ICH";
 			r->get = pirq_piix_get;
 			r->set = pirq_piix_set;
diff -puN include/linux/pci_ids.h~irq-and-pci_ids-patch-for-intel-esb2 include/linux/pci_ids.h
--- 25/include/linux/pci_ids.h~irq-and-pci_ids-patch-for-intel-esb2	2005-04-12 03:21:17.258513208 -0700
+++ 25-akpm/include/linux/pci_ids.h	2005-04-12 03:21:17.265512144 -0700
@@ -2391,6 +2391,25 @@
 #define PCI_DEVICE_ID_INTEL_ICH6_17	0x266d
 #define PCI_DEVICE_ID_INTEL_ICH6_18	0x266e
 #define PCI_DEVICE_ID_INTEL_ICH6_19	0x266f
+#define PCI_DEVICE_ID_INTEL_ESB2_0	0x2670
+#define PCI_DEVICE_ID_INTEL_ESB2_1	0x2680
+#define PCI_DEVICE_ID_INTEL_ESB2_2	0x2681
+#define PCI_DEVICE_ID_INTEL_ESB2_3	0x2682
+#define PCI_DEVICE_ID_INTEL_ESB2_4	0x2683
+#define PCI_DEVICE_ID_INTEL_ESB2_5	0x2688
+#define PCI_DEVICE_ID_INTEL_ESB2_6	0x2689
+#define PCI_DEVICE_ID_INTEL_ESB2_7	0x268a
+#define PCI_DEVICE_ID_INTEL_ESB2_8	0x268b
+#define PCI_DEVICE_ID_INTEL_ESB2_9	0x268c
+#define PCI_DEVICE_ID_INTEL_ESB2_10	0x2690
+#define PCI_DEVICE_ID_INTEL_ESB2_11	0x2692
+#define PCI_DEVICE_ID_INTEL_ESB2_12	0x2694
+#define PCI_DEVICE_ID_INTEL_ESB2_13	0x2696
+#define PCI_DEVICE_ID_INTEL_ESB2_14	0x2698
+#define PCI_DEVICE_ID_INTEL_ESB2_15	0x2699
+#define PCI_DEVICE_ID_INTEL_ESB2_16	0x269a
+#define PCI_DEVICE_ID_INTEL_ESB2_17	0x269b
+#define PCI_DEVICE_ID_INTEL_ESB2_18	0x269e
 #define PCI_DEVICE_ID_INTEL_ICH7_0	0x27b8
 #define PCI_DEVICE_ID_INTEL_ICH7_1	0x27b9
 #define PCI_DEVICE_ID_INTEL_ICH7_2	0x27c0
@@ -2415,6 +2434,18 @@
 #define PCI_DEVICE_ID_INTEL_ICH7_22	0x27e0
 #define PCI_DEVICE_ID_INTEL_ICH7_23	0x27e2
 #define PCI_DEVICE_ID_INTEL_82855PM_HB	0x3340
+#define PCI_DEVICE_ID_INTEL_ESB2_19	0x3500
+#define PCI_DEVICE_ID_INTEL_ESB2_20	0x3501
+#define PCI_DEVICE_ID_INTEL_ESB2_21	0x3504
+#define PCI_DEVICE_ID_INTEL_ESB2_22	0x3505
+#define PCI_DEVICE_ID_INTEL_ESB2_23	0x350c
+#define PCI_DEVICE_ID_INTEL_ESB2_24	0x350d
+#define PCI_DEVICE_ID_INTEL_ESB2_25	0x3510
+#define PCI_DEVICE_ID_INTEL_ESB2_26	0x3511
+#define PCI_DEVICE_ID_INTEL_ESB2_27	0x3514
+#define PCI_DEVICE_ID_INTEL_ESB2_28	0x3515
+#define PCI_DEVICE_ID_INTEL_ESB2_29	0x3518
+#define PCI_DEVICE_ID_INTEL_ESB2_30	0x3519
 #define PCI_DEVICE_ID_INTEL_82830_HB	0x3575
 #define PCI_DEVICE_ID_INTEL_82830_CGC	0x3577
 #define PCI_DEVICE_ID_INTEL_82855GM_HB	0x3580
_
