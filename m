Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVDESxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVDESxA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVDESuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:50:32 -0400
Received: from fmr18.intel.com ([134.134.136.17]:5019 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261892AbVDESl5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:41:57 -0400
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: greg@kroah.com
Subject: [PATCH 2.6.11.6 6/6] i2c-i801: I2C patch for Intel ESB2
Date: Tue, 5 Apr 2005 08:17:51 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504050817.51563.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch adds the Intel ESB2 DID's to the i2c-i801.c and Kconfig files for I2C support.  This patch was built against the 2.6.11.6 kernel.  
If acceptable, please apply.  Note:  This patch depends on the previous 1/6 patch for pci_ids.h

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.11.6/drivers/i2c/busses/i2c-i801.c.orig	2005-03-28 09:07:27.647899568 -0800
+++ linux-2.6.11.6/drivers/i2c/busses/i2c-i801.c	2005-03-28 09:09:04.161227312 -0800
@@ -31,6 +31,7 @@
     6300ESB		25A4
     ICH6		266A
     ICH7		27DA
+    ESB2		269B
     This driver supports several versions of Intel's I/O Controller Hubs (ICH).
     For SMBus support, they are similar to the PIIX4 and are part
     of Intel's '810' and other chipsets.
@@ -558,6 +559,7 @@
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_16) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_17) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_17) },
 	{ 0, }
 };
 
--- linux-2.6.11.6/drivers/i2c/busses/Kconfig.orig	2005-03-28 09:09:12.982886216 -0800
+++ linux-2.6.11.6/drivers/i2c/busses/Kconfig	2005-03-28 09:09:32.875862024 -0800
@@ -123,6 +123,7 @@
 	    6300ESB
 	    ICH6
 	    ICH7
+	    ESB2
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
