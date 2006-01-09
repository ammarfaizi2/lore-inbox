Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWAIWG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWAIWG3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWAIWG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:06:29 -0500
Received: from fmr17.intel.com ([134.134.136.16]:55243 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750792AbWAIWG3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:06:29 -0500
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: mj@ucw.cz, akpm@osdl.org
Subject: [PATCH 2.6.15 1/6] irq and pci_ids: patch for Intel ICH8
Date: Mon, 9 Jan 2006 10:53:45 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601091053.46191.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch adds the Intel ICH8 DID's to the irq.c and pci_ids.h files.  This patch was built against the 2.6.15 kernel.  
If acceptable, please apply. 

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.15/arch/i386/pci/irq.c.orig	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15/arch/i386/pci/irq.c	2006-01-09 08:18:08.007292384 -0800
@@ -539,6 +539,11 @@
 		case PCI_DEVICE_ID_INTEL_ICH7_30:
 		case PCI_DEVICE_ID_INTEL_ICH7_31:
 		case PCI_DEVICE_ID_INTEL_ESB2_0:
+		case PCI_DEVICE_ID_INTEL_ICH8_0:
+		case PCI_DEVICE_ID_INTEL_ICH8_1:
+		case PCI_DEVICE_ID_INTEL_ICH8_2:
+		case PCI_DEVICE_ID_INTEL_ICH8_3:
+		case PCI_DEVICE_ID_INTEL_ICH8_4:
 			r->name = "PIIX/ICH";
 			r->get = pirq_piix_get;
 			r->set = pirq_piix_set;
--- linux-2.6.15/include/linux/pci_ids.h.orig	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15/include/linux/pci_ids.h	2006-01-09 08:18:08.015291168 -0800
@@ -2055,6 +2055,13 @@
 #define PCI_DEVICE_ID_INTEL_ICH7_19	0x27dd
 #define PCI_DEVICE_ID_INTEL_ICH7_20	0x27de
 #define PCI_DEVICE_ID_INTEL_ICH7_21	0x27df
+#define PCI_DEVICE_ID_INTEL_ICH8_0	0x2810
+#define PCI_DEVICE_ID_INTEL_ICH8_1	0x2811
+#define PCI_DEVICE_ID_INTEL_ICH8_2	0x2812
+#define PCI_DEVICE_ID_INTEL_ICH8_3	0x2814
+#define PCI_DEVICE_ID_INTEL_ICH8_4	0x2815
+#define PCI_DEVICE_ID_INTEL_ICH8_5	0x283e
+#define PCI_DEVICE_ID_INTEL_ICH8_6	0x2850
 #define PCI_DEVICE_ID_INTEL_82855PM_HB	0x3340
 #define PCI_DEVICE_ID_INTEL_82830_HB	0x3575
 #define PCI_DEVICE_ID_INTEL_82830_CGC	0x3577
