Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWAIWKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWAIWKm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWAIWKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:10:42 -0500
Received: from fmr20.intel.com ([134.134.136.19]:18862 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750809AbWAIWKl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:10:41 -0500
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: greg@kroah.com
Subject: [PATCH 2.6.15 3/6] i2c-i801: I2C patch for Intel ICH8
Date: Mon, 9 Jan 2006 10:58:08 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601091058.08652.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch adds the Intel ICH8 DID to the i2c-i801.c and Kconfig files for I2C support.  This patch was built against the 2.6.15 kernel.  
If acceptable, please apply.  Note:  This patch depends on the previous 1/6 patch for pci_ids.h

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.15/drivers/i2c/busses/i2c-i801.c.orig	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15/drivers/i2c/busses/i2c-i801.c	2006-01-09 08:18:08.008292232 -0800
@@ -32,6 +32,7 @@
     ICH6		266A
     ICH7		27DA
     ESB2		269B
+    ICH8		283E
     This driver supports several versions of Intel's I/O Controller Hubs (ICH).
     For SMBus support, they are similar to the PIIX4 and are part
     of Intel's '810' and other chipsets.
@@ -531,6 +532,7 @@
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_16) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_17) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_17) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH8_5) },
 	{ 0, }
 };
 
--- linux-2.6.15/drivers/i2c/busses/Kconfig.orig	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15/drivers/i2c/busses/Kconfig	2006-01-09 08:18:08.009292080 -0800
@@ -124,6 +124,7 @@
 	    ICH6
 	    ICH7
 	    ESB2
+	    ICH8
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
