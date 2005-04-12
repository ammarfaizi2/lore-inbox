Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262638AbVDLUBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbVDLUBP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVDLT7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:59:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:40136 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262152AbVDLKbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:45 -0400
Message-Id: <200504121031.j3CAVc0R005360@shell0.pdx.osdl.net>
Subject: [patch 059/198] piix: IDE PATA patch for Intel ESB2
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jason.d.gaston@intel.com,
       Jason.d.gaston@intel.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jason Gaston <jason.d.gaston@intel.com>

This patch adds the Intel ESB2 DID's to the piix.c file for IDE PATA support.

Signed-off-by: Jason Gaston <Jason.d.gaston@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/ide/pci/piix.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN drivers/ide/pci/piix.c~piix-ide-pata-patch-for-intel-esb2 drivers/ide/pci/piix.c
--- 25/drivers/ide/pci/piix.c~piix-ide-pata-patch-for-intel-esb2	2005-04-12 03:21:17.487478400 -0700
+++ 25-akpm/drivers/ide/pci/piix.c	2005-04-12 03:21:17.491477792 -0700
@@ -134,6 +134,7 @@ static u8 piix_ratemask (ide_drive_t *dr
 		case PCI_DEVICE_ID_INTEL_ESB_2:
 		case PCI_DEVICE_ID_INTEL_ICH6_19:
 		case PCI_DEVICE_ID_INTEL_ICH7_21:
+		case PCI_DEVICE_ID_INTEL_ESB2_18:
 			mode = 3;
 			break;
 		/* UDMA 66 capable */
@@ -447,6 +448,7 @@ static unsigned int __devinit init_chips
 		case PCI_DEVICE_ID_INTEL_ESB_2:
 		case PCI_DEVICE_ID_INTEL_ICH6_19:
 		case PCI_DEVICE_ID_INTEL_ICH7_21:
+		case PCI_DEVICE_ID_INTEL_ESB2_18:
 		{
 			unsigned int extra = 0;
 			pci_read_config_dword(dev, 0x54, &extra);
@@ -572,6 +574,7 @@ static ide_pci_device_t piix_pci_info[] 
 	/* 20 */ DECLARE_PIIX_DEV("ICH6"),
 	/* 21 */ DECLARE_PIIX_DEV("ICH7"),
 	/* 22 */ DECLARE_PIIX_DEV("ICH4"),
+	/* 23 */ DECLARE_PIIX_DEV("ESB2"),
 };
 
 /**
@@ -647,6 +650,7 @@ static struct pci_device_id piix_pci_tbl
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_19, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 20},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_21, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 21},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 22},
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_18, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 23},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
_
