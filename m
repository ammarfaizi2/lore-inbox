Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVDESgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVDESgZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVDESdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:33:21 -0400
Received: from fmr18.intel.com ([134.134.136.17]:406 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261874AbVDESbV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:31:21 -0400
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: bzolnier@gmail.com
Subject: [PATCH 2.6.11.6 2/6] piix: IDE PATA patch for Intel ESB2
Date: Tue, 5 Apr 2005 08:07:16 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504050807.16788.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch adds the Intel ESB2 DID's to the piix.c file for IDE PATA support.  This patch was built against the 2.6.11.6 kernel.  
If acceptable, please apply.   Note:  This patch depends on the previous 1/6 patch for pci_ids.h

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.11.6/drivers/ide/pci/piix.c.orig	2005-03-28 08:54:23.801062400 -0800
+++ linux-2.6.11.6/drivers/ide/pci/piix.c	2005-03-28 08:58:05.332384520 -0800
@@ -134,6 +134,7 @@
 		case PCI_DEVICE_ID_INTEL_ESB_2:
 		case PCI_DEVICE_ID_INTEL_ICH6_19:
 		case PCI_DEVICE_ID_INTEL_ICH7_21:
+		case PCI_DEVICE_ID_INTEL_ESB2_18:
 			mode = 3;
 			break;
 		/* UDMA 66 capable */
@@ -447,6 +448,7 @@
 		case PCI_DEVICE_ID_INTEL_ESB_2:
 		case PCI_DEVICE_ID_INTEL_ICH6_19:
 		case PCI_DEVICE_ID_INTEL_ICH7_21:
+		case PCI_DEVICE_ID_INTEL_ESB2_18:
 		{
 			unsigned int extra = 0;
 			pci_read_config_dword(dev, 0x54, &extra);
@@ -572,6 +574,7 @@
 	/* 20 */ DECLARE_PIIX_DEV("ICH6"),
 	/* 21 */ DECLARE_PIIX_DEV("ICH7"),
 	/* 22 */ DECLARE_PIIX_DEV("ICH4"),
+	/* 23 */ DECLARE_PIIX_DEV("ESB2"),
 };
 
 /**
@@ -647,6 +650,7 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_19, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 20},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_21, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 21},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 22},
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_18, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 23},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
