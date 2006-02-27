Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWB0WFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWB0WFc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbWB0WFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:05:32 -0500
Received: from cassiel.sirena.org.uk ([80.68.93.111]:59662 "EHLO
	cassiel.sirena.org.uk") by vger.kernel.org with ESMTP
	id S1751487AbWB0WFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:05:31 -0500
Date: Mon, 27 Feb 2006 22:05:17 +0000
From: Mark Brown <broonie@sirena.org.uk>
To: cramerj@intel.com, john.ronciak@intel.com, ganesh.venkatesan@intel.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] e1000: Support e1000 OEMed onto Aculab cards
Message-ID: <20060227220517.GA8611@sirena.org.uk>
Mail-Followup-To: cramerj@intel.com, john.ronciak@intel.com,
	ganesh.venkatesan@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-OfflineIMAP-x1096346433-4361737369656c-706f7374706f6e6564: 1140899439-0276240372166-v4.0.11
X-Cookie: It's all in the mind, ya know.
User-Agent: Mutt/1.5.11+cvs20060126
X-Spam-Score: -2.4 (--)
X-Spam-Report: Spam detection software, running on the system "cassiel.sirena.org.uk", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Add PCI IDs for chips OEMed onto some Aculab cards to
	the e1000 driver. Signed-Off-By: Mark Brown <broonie@sirena.org.uk>
	Index: e1000-queue/drivers/net/e1000/e1000.h
	=================================================================== ---
	e1000-queue.orig/drivers/net/e1000/e1000.h 2006-02-25
	12:50:12.000000000 +0000 +++ e1000-queue/drivers/net/e1000/e1000.h
	2006-02-25 13:01:10.000000000 +0000 @@ -84,6 +84,9 @@ #define
	INTEL_E1000_ETHERNET_DEVICE(device_id) {\
	PCI_DEVICE(PCI_VENDOR_ID_INTEL, device_id)} [...] 
	Content analysis details:   (-2.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 UPPERCASE_25_50        message body is 25-50% uppercase
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCI IDs for chips OEMed onto some Aculab cards to the e1000 driver.

Signed-Off-By: Mark Brown <broonie@sirena.org.uk>

Index: e1000-queue/drivers/net/e1000/e1000.h
===================================================================
--- e1000-queue.orig/drivers/net/e1000/e1000.h	2006-02-25 12:50:12.000000000 +0000
+++ e1000-queue/drivers/net/e1000/e1000.h	2006-02-25 13:01:10.000000000 +0000
@@ -84,6 +84,9 @@
 #define INTEL_E1000_ETHERNET_DEVICE(device_id) {\
 	PCI_DEVICE(PCI_VENDOR_ID_INTEL, device_id)}
 
+#define ACULAB_E1000_ETHERNET_DEVICE(device_id) {\
+	PCI_DEVICE(PCI_VENDOR_ID_ACULAB, device_id)}
+
 struct e1000_adapter;
 
 #include "e1000_hw.h"
Index: e1000-queue/drivers/net/e1000/e1000_main.c
===================================================================
--- e1000-queue.orig/drivers/net/e1000/e1000_main.c	2006-02-25 12:50:12.000000000 +0000
+++ e1000-queue/drivers/net/e1000/e1000_main.c	2006-02-25 13:01:10.000000000 +0000
@@ -98,6 +98,7 @@ static struct pci_device_id e1000_pci_tb
 	INTEL_E1000_ETHERNET_DEVICE(0x108B),
 	INTEL_E1000_ETHERNET_DEVICE(0x108C),
 	INTEL_E1000_ETHERNET_DEVICE(0x109A),
+	ACULAB_E1000_ETHERNET_DEVICE(0x1078),
 	/* required last entry */
 	{0,}
 };

Index: e1000-queue/include/linux/pci_ids.h
===================================================================
--- e1000-queue.orig/include/linux/pci_ids.h	2006-02-25 12:50:12.000000000 +0000
+++ e1000-queue/include/linux/pci_ids.h	2006-02-25 12:51:51.000000000 +0000
@@ -1572,6 +1572,8 @@
 #define PCI_VENDOR_ID_NVIDIA_SGS	0x12d2
 #define PCI_DEVICE_ID_NVIDIA_SGS_RIVA128 0x0018
 
+#define PCI_VENDOR_ID_ACULAB 0x12d9
+
 #define PCI_SUBVENDOR_ID_CHASE_PCIFAST		0x12E0
 #define PCI_SUBDEVICE_ID_CHASE_PCIFAST4		0x0031
 #define PCI_SUBDEVICE_ID_CHASE_PCIFAST8		0x0021

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
