Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161013AbWGNJwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161013AbWGNJwe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 05:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWGNJwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 05:52:34 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:62375 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964812AbWGNJwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 05:52:33 -0400
From: Daniel Drake <dsd@gentoo.org>
To: greg@kroah.com
Cc: akpm@osdl.org
Cc: cw@f00f.org
Cc: harmon@ksu.edu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add SATA device to VIA IRQ quirk fixup list
Message-Id: <20060714095233.5678A8B6253@zog.reactivated.net>
Date: Fri, 14 Jul 2006 10:52:33 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gentoo users at http://bugs.gentoo.org/138036 reported a 2.6.16.17 regression:
new kernels will not boot their system from their VIA SATA hardware.

The solution is just to add the SATA device to the fixup list.
This should also fix the same problem reported by Scott J. Harmon on LKML.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

Index: linux/drivers/pci/quirks.c
===================================================================
--- linux.orig/drivers/pci/quirks.c
+++ linux/drivers/pci/quirks.c
@@ -668,6 +668,7 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_V
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, quirk_via_irq);
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, quirk_via_irq);
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, quirk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237_SATA, quirk_via_irq);
 
 /*
  * VIA VT82C598 has its device ID settable and many BIOSes
