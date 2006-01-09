Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWAIWI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWAIWI2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWAIWI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:08:28 -0500
Received: from fmr17.intel.com ([134.134.136.16]:17100 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750797AbWAIWI1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:08:27 -0500
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: bzolnier@gmail.com
Subject: [PATCH 2.6.15 2/6] piix: IDE PATA patch for Intel ICH8M
Date: Mon, 9 Jan 2006 10:55:55 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601091055.55351.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch adds the Intel ICH8M DID to the piix.c file for IDE PATA support.  This patch was built against the 2.6.15 kernel.  
If acceptable, please apply.   Note:  This patch depends on the previous 1/6 patch for pci_ids.h

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.15/drivers/ide/pci/piix.c.orig	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15/drivers/ide/pci/piix.c	2006-01-09 08:18:08.010291928 -0800
@@ -135,6 +135,7 @@
 		case PCI_DEVICE_ID_INTEL_ICH6_19:
 		case PCI_DEVICE_ID_INTEL_ICH7_21:
 		case PCI_DEVICE_ID_INTEL_ESB2_18:
+		case PCI_DEVICE_ID_INTEL_ICH8_6:
 			mode = 3;
 			break;
 		/* UDMA 66 capable */
@@ -449,6 +450,7 @@
 		case PCI_DEVICE_ID_INTEL_ICH6_19:
 		case PCI_DEVICE_ID_INTEL_ICH7_21:
 		case PCI_DEVICE_ID_INTEL_ESB2_18:
+		case PCI_DEVICE_ID_INTEL_ICH8_6:
 		{
 			unsigned int extra = 0;
 			pci_read_config_dword(dev, 0x54, &extra);
@@ -575,6 +577,7 @@
 	/* 21 */ DECLARE_PIIX_DEV("ICH7"),
 	/* 22 */ DECLARE_PIIX_DEV("ICH4"),
 	/* 23 */ DECLARE_PIIX_DEV("ESB2"),
+	/* 24 */ DECLARE_PIIX_DEV("ICH8M"),
 };
 
 /**
@@ -651,6 +654,7 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_21, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 21},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 22},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_18, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 23},
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH8_6, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 24},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);

