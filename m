Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262643AbVDLUFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbVDLUFg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVDLT67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:58:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:40648 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262154AbVDLKbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:46 -0400
Message-Id: <200504121031.j3CAVfl5005376@shell0.pdx.osdl.net>
Subject: [patch 063/198] i2c-i801: I2C patch for Intel ESB2
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jason.d.gaston@intel.com,
       greg@kroah.com, Jason.d.gaston@intel.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jason Gaston <jason.d.gaston@intel.com>

This patch adds the Intel ESB2 DID's to the i2c-i801.c and Kconfig files for
I2C support.

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/i2c/busses/Kconfig    |    1 +
 25-akpm/drivers/i2c/busses/i2c-i801.c |    2 ++
 2 files changed, 3 insertions(+)

diff -puN drivers/i2c/busses/i2c-i801.c~i2c-i801-i2c-patch-for-intel-esb2 drivers/i2c/busses/i2c-i801.c
--- 25/drivers/i2c/busses/i2c-i801.c~i2c-i801-i2c-patch-for-intel-esb2	2005-04-12 03:21:18.342348440 -0700
+++ 25-akpm/drivers/i2c/busses/i2c-i801.c	2005-04-12 03:21:18.347347680 -0700
@@ -31,6 +31,7 @@
     6300ESB		25A4
     ICH6		266A
     ICH7		27DA
+    ESB2		269B
     This driver supports several versions of Intel's I/O Controller Hubs (ICH).
     For SMBus support, they are similar to the PIIX4 and are part
     of Intel's '810' and other chipsets.
@@ -558,6 +559,7 @@ static struct pci_device_id i801_ids[] =
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_16) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_17) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_17) },
 	{ 0, }
 };
 
diff -puN drivers/i2c/busses/Kconfig~i2c-i801-i2c-patch-for-intel-esb2 drivers/i2c/busses/Kconfig
--- 25/drivers/i2c/busses/Kconfig~i2c-i801-i2c-patch-for-intel-esb2	2005-04-12 03:21:18.343348288 -0700
+++ 25-akpm/drivers/i2c/busses/Kconfig	2005-04-12 03:21:18.347347680 -0700
@@ -123,6 +123,7 @@ config I2C_I801
 	    6300ESB
 	    ICH6
 	    ICH7
+	    ESB2
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
_
