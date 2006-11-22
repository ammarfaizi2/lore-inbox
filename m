Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757160AbWKVXPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757160AbWKVXPV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 18:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757162AbWKVXPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 18:15:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:36286 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1757160AbWKVXPU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 18:15:20 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,449,1157353200"; 
   d="scan'208"; a="165613415:sNHT17984974"
From: Jason Gaston <jason.d.gaston@intel.com>
To: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, khali@linux-fr.org,
       i2c@lm-sensors.nu, jason.d.gaston@intel.com
Subject: [PATCH 2.6.19-rc6] irq: irq and pci_ids patch for Intel ICH9
Date: Wed, 22 Nov 2006 15:15:08 -0800
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611221515.08246.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This updated patch adds the Intel ICH9 LPC and SMBus Controller DID's.

Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>

--- linux-2.6.19-rc6/arch/i386/pci/irq.c.orig	2006-11-22 06:23:25.000000000 -0800
+++ linux-2.6.19-rc6/arch/i386/pci/irq.c	2006-11-22 06:24:36.000000000 -0800
@@ -543,6 +543,12 @@
 		case PCI_DEVICE_ID_INTEL_ICH8_2:
 		case PCI_DEVICE_ID_INTEL_ICH8_3:
 		case PCI_DEVICE_ID_INTEL_ICH8_4:
+		case PCI_DEVICE_ID_INTEL_ICH9_0:
+		case PCI_DEVICE_ID_INTEL_ICH9_1:
+		case PCI_DEVICE_ID_INTEL_ICH9_2:
+		case PCI_DEVICE_ID_INTEL_ICH9_3:
+		case PCI_DEVICE_ID_INTEL_ICH9_4:
+		case PCI_DEVICE_ID_INTEL_ICH9_5:
 			r->name = "PIIX/ICH";
 			r->get = pirq_piix_get;
 			r->set = pirq_piix_set;
--- linux-2.6.19-rc6/include/linux/pci_ids.h.orig	2006-11-22 06:19:57.000000000 -0800
+++ linux-2.6.19-rc6/include/linux/pci_ids.h	2006-11-22 06:26:10.000000000 -0800
@@ -2211,6 +2211,13 @@
 #define PCI_DEVICE_ID_INTEL_ICH8_4	0x2815
 #define PCI_DEVICE_ID_INTEL_ICH8_5	0x283e
 #define PCI_DEVICE_ID_INTEL_ICH8_6	0x2850
+#define PCI_DEVICE_ID_INTEL_ICH9_0	0x2910
+#define PCI_DEVICE_ID_INTEL_ICH9_1	0x2911
+#define PCI_DEVICE_ID_INTEL_ICH9_2	0x2912
+#define PCI_DEVICE_ID_INTEL_ICH9_3	0x2913
+#define PCI_DEVICE_ID_INTEL_ICH9_4	0x2914
+#define PCI_DEVICE_ID_INTEL_ICH9_5	0x2915
+#define PCI_DEVICE_ID_INTEL_ICH9_6	0x2930
 #define PCI_DEVICE_ID_INTEL_82855PM_HB	0x3340
 #define PCI_DEVICE_ID_INTEL_82830_HB	0x3575
 #define PCI_DEVICE_ID_INTEL_82830_CGC	0x3577
