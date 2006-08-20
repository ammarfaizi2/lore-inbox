Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWHTQSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWHTQSV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 12:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWHTQSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 12:18:20 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:40172 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1750896AbWHTQSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 12:18:20 -0400
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] PCI: add ICH7/8 ACPI/GPIO io resource quirks
Date: Sun, 20 Aug 2006 18:17:58 +0200
User-Agent: KMail/1.7.2
Cc: "linux-pci" <linux-pci@atrey.karlin.mff.cuni.cz>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608201817.59355.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-01.tornado.cablecom.ch 1378;
	Body=4 Fuz1=4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

( on top of pci-fix-ich6-quirks.patch )

[PATCH] PCI: add ICH7/8 ACPI/GPIO io resource quirks

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

--- a/drivers/pci/quirks.c	2006-08-20 16:00:07.000000000 +0200
+++ b/drivers/pci/quirks.c	2006-08-20 16:59:26.000000000 +0200
@@ -440,6 +440,12 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_0, quirk_ich6_lpc_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1, quirk_ich6_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH7_0, quirk_ich6_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH7_1, quirk_ich6_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH7_31, quirk_ich6_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH8_0, quirk_ich6_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH8_2, quirk_ich6_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH8_3, quirk_ich6_lpc_acpi );
 
 /*
  * VIA ACPI: One IO region pointed to by longword at
