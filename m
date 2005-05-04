Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbVEDHEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVEDHEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVEDHCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:02:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:62436 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262043AbVEDHCV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:02:21 -0400
Cc: R.Marek@sh.cvut.cz
Subject: [PATCH] PCI: Rapid Hance quirk
In-Reply-To: <11151901383259@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 May 2005 00:02:18 -0700
Message-Id: <1115190138979@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: Rapid Hance quirk

This patch just adds Intel's Hance Rapid south bridge IDs to ICH4 region quirk.
Patch was successfuly tested by Chunhao Huang from Winbond.

Signed-Off-By: Rudolf Marek <r.marek@sh.cvut.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 3aa8c4febf74b1f23bd9fc329321af6d531fe4dd
tree 7e0b5b3d9a0308224fb40e452d93ec842a3377fe
parent 034ecc724cc6ba662d0b2b5a1e11e7e66a768596
author R.Marek@sh.cvut.cz <R.Marek@sh.cvut.cz> 1114080546 +0000
committer Greg KH <gregkh@suse.de> 1115189116 -0700

Index: drivers/pci/quirks.c
===================================================================
--- d34ced60da68e2dca2aae90e2b29d8f94618ffbc/drivers/pci/quirks.c  (mode:100644 sha1:00388a14a3c61693ac734dee4c4cef172b2a0acc)
+++ 7e0b5b3d9a0308224fb40e452d93ec842a3377fe/drivers/pci/quirks.c  (mode:100644 sha1:026aa04669a29467559af822be1ad69d06f61ef0)
@@ -329,6 +329,7 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801DB_0,		quirk_ich4_lpc_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801DB_12,	quirk_ich4_lpc_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801EB_0,		quirk_ich4_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_ESB_1,		quirk_ich4_lpc_acpi );
 
 /*
  * VIA ACPI: One IO region pointed to by longword at

