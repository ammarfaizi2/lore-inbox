Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbTFTRbq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 13:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263558AbTFTRbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 13:31:46 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:34770 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263535AbTFTRbp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 13:31:45 -0400
Date: Fri, 20 Jun 2003 09:49:23 +0200
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH 2.5] pci: add Asus P4G8X Deluxe to asus_hides_smbus quirk
Message-ID: <20030620074923.GA10455@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another Asus motherboard hiding features

 quirks.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -ruN linux-original/drivers/pci/quirks.c linux/drivers/pci/quirks.c
--- linux-original/drivers/pci/quirks.c	2003-06-10 21:59:13.000000000 +0200
+++ linux/drivers/pci/quirks.c	2003-06-10 22:06:12.000000000 +0200
@@ -690,6 +690,9 @@
 	if ((dev->device == PCI_DEVICE_ID_INTEL_82850_HB) &&
 	    (dev->subsystem_device == 0x8030)) /* P4T533 */
 		asus_hides_smbus = 1;
+	if ((dev->device == PCI_DEVICE_ID_INTEL_7205_0) &&
+	    (dev->subsystem_device == 0x8070)) /* P4G8X Deluxe */
+		asus_hides_smbus = 1;
 	return;
 }
 
@@ -838,6 +841,7 @@
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845_HB,	asus_hides_smbus_hostbridge },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845G_HB,	asus_hides_smbus_hostbridge },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82850_HB,	asus_hides_smbus_hostbridge },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_7205_0,	asus_hides_smbus_hostbridge },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc },
 
