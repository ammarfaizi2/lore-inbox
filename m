Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUHHVnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUHHVnN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 17:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbUHHVnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 17:43:13 -0400
Received: from hell.org.pl ([212.244.218.42]:20744 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S261474AbUHHVnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 17:43:08 -0400
Date: Sun, 8 Aug 2004 23:43:13 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: linux@brodo.de
Cc: linux-kernel@vger.kernel.org
Subject: ASUS L3C SMBus fixup
Message-ID: <20040808214313.GA18097@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Following the notes on bug #2976, here's the patch to add ASUS L3C notebook
to the list of machines hiding SMBus chip. The patch is against
2.6.8-rc3-mm1.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl

--- linux-2.6.8/drivers/pci/quirks.c~	2004-08-08 01:29:42.000000000 +0200
+++ linux-2.6.8/drivers/pci/quirks.c	2004-08-08 01:34:55.000000000 +0200
@@ -778,6 +778,7 @@
 			switch(dev->subsystem_device) {
 			case 0x8070: /* P4B */
 			case 0x8088: /* P4B533 */
+			case 0x1626: /* L3C notebook */
 				asus_hides_smbus = 1;
 			}
 		if (dev->device == PCI_DEVICE_ID_INTEL_82845G_HB)
@@ -837,6 +838,7 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_12,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc );
 
 /*
