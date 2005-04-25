Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbVDYS0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbVDYS0l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 14:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbVDYS01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 14:26:27 -0400
Received: from fmr18.intel.com ([134.134.136.17]:54752 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262699AbVDYSY1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 14:24:27 -0400
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: mj@ucw.cz, akpm@osdl.org
Subject: [PATCH 2.6.12-rc3 1/1] irq and pci_ids: patch for Intel ICH7DH & ICH7-M DH
Date: Mon, 25 Apr 2005 07:38:56 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504250738.56915.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch adds the Intel ICH7DH and ICH7-M DH DID's to the irq.c and pci_ids.h files.  This patch was built against the 2.6.12-rc3 kernel.  
If acceptable, please apply. 

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.12-rc3/arch/i386/pci/irq.c.orig	2005-04-25 07:26:14.689634256 -0700
+++ linux-2.6.12-rc3/arch/i386/pci/irq.c	2005-04-25 07:27:09.188349192 -0700
@@ -495,6 +495,8 @@
 		case PCI_DEVICE_ID_INTEL_ICH6_1:
 		case PCI_DEVICE_ID_INTEL_ICH7_0:
 		case PCI_DEVICE_ID_INTEL_ICH7_1:
+		case PCI_DEVICE_ID_INTEL_ICH7_30:
+		case PCI_DEVICE_ID_INTEL_ICH7_31:
 		case PCI_DEVICE_ID_INTEL_ESB2_0:
 			r->name = "PIIX/ICH";
 			r->get = pirq_piix_get;
--- linux-2.6.12-rc3/include/linux/pci_ids.h.orig	2005-04-25 07:20:04.330937336 -0700
+++ linux-2.6.12-rc3/include/linux/pci_ids.h	2005-04-25 07:25:13.983862936 -0700
@@ -2414,6 +2414,8 @@
 #define PCI_DEVICE_ID_INTEL_ICH7_1	0x27b9
 #define PCI_DEVICE_ID_INTEL_ICH7_2	0x27c0
 #define PCI_DEVICE_ID_INTEL_ICH7_3	0x27c1
+#define PCI_DEVICE_ID_INTEL_ICH7_30	0x27b0
+#define PCI_DEVICE_ID_INTEL_ICH7_31	0x27bd
 #define PCI_DEVICE_ID_INTEL_ICH7_5	0x27c4
 #define PCI_DEVICE_ID_INTEL_ICH7_6	0x27c5
 #define PCI_DEVICE_ID_INTEL_ICH7_7	0x27c8
