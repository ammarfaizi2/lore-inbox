Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbVKWDGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbVKWDGE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 22:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVKWDGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 22:06:04 -0500
Received: from ms.panoch.net ([82.208.32.9]:9351 "EHLO ms.panoch.net")
	by vger.kernel.org with ESMTP id S932488AbVKWDGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 22:06:03 -0500
Message-ID: <4383DC5E.3050601@panoch.net>
Date: Wed, 23 Nov 2005 04:05:02 +0100
From: Jan Panoch <jan@panoch.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PATA support for Intel ICH7 (intel 945G chipset) - 2.6.14.2
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds additional Intel ICH7 DID's for Intel chipset 945G to
the piix driver.
I need to add PATA support for new intel 945G chipset on Asus
motherboard P5LD2-VM.
If acceptable, please apply.

Thanks,

Jan

--- piix.c.orig 2005-11-23 11:46:12.000000000 +0100
+++ piix.c      2005-11-23 11:13:02.000000000 +0100
@@ -134,6 +134,7 @@
                case PCI_DEVICE_ID_INTEL_ESB_2:
                case PCI_DEVICE_ID_INTEL_ICH6_19:
                case PCI_DEVICE_ID_INTEL_ICH7_21:
+               case PCI_DEVICE_ID_INTEL_ICH7_2:
                case PCI_DEVICE_ID_INTEL_ESB2_18:
                        mode = 3;
                        break;
@@ -448,6 +449,7 @@
                case PCI_DEVICE_ID_INTEL_ESB_2:
                case PCI_DEVICE_ID_INTEL_ICH6_19:
                case PCI_DEVICE_ID_INTEL_ICH7_21:
+               case PCI_DEVICE_ID_INTEL_ICH7_2:
                case PCI_DEVICE_ID_INTEL_ESB2_18:
                {
                        unsigned int extra = 0;
@@ -575,6 +577,7 @@
        /* 21 */ DECLARE_PIIX_DEV("ICH7"),
        /* 22 */ DECLARE_PIIX_DEV("ICH4"),
        /* 23 */ DECLARE_PIIX_DEV("ESB2"),
+       /* 24 */ DECLARE_PIIX_DEV("ICH7"),
 };

 /**
@@ -651,6 +654,7 @@
        { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_21, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 21},
        { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_1,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 22},
        { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_18, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 23},
+       { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_2, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 24},
        { 0, },
 };
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);

-- 
Jan Panoch

======================
mail:   jan@panoch.net
Skype:  jan.panoch


