Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVAGAni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVAGAni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVAGAna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:43:30 -0500
Received: from fmr20.intel.com ([134.134.136.19]:1929 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261152AbVAGAlb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:41:31 -0500
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: greg@kroah.com
Subject: [PATCH] I2C support for Intel ICH7 - 2.6.10 - resubmit
Date: Thu, 6 Jan 2005 09:47:14 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501060947.14595.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the Intel ICH7 DID to the i2c-i801.c driver and adds an entry to Kconfig for I2C(SMBus) support.  
Note: This patch relies on the already submitted and accepted PATA patch to pci_ids.h containing all ICH7 DID's.
If acceptable, please apply. 

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.10/drivers/i2c/busses/i2c-i801.c.orig	2004-12-30 05:58:04.000000000 -0800
+++ linux-2.6.10/drivers/i2c/busses/i2c-i801.c	2004-12-30 06:01:35.000000000 -0800
@@ -30,6 +30,7 @@
     82801EB		24D3   (HW PEC supported, 32 byte buffer not supported)
     6300ESB		25A4
     ICH6		266A
+    ICH7		27DA
     This driver supports several versions of Intel's I/O Controller Hubs (ICH).
     For SMBus support, they are similar to the PIIX4 and are part
     of Intel's '810' and other chipsets.
@@ -596,6 +597,12 @@
 		.subvendor =	PCI_ANY_ID,
 		.subdevice =	PCI_ANY_ID,
 	},
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_ICH7_17,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+	},
 	{ 0, }
 };
 
--- linux-2.6.10/drivers/i2c/busses/Kconfig.orig	2004-12-30 06:02:04.000000000 -0800
+++ linux-2.6.10/drivers/i2c/busses/Kconfig	2004-12-30 06:02:39.000000000 -0800
@@ -112,6 +112,7 @@
 	    82801EB
 	    6300ESB
 	    ICH6
+	    ICH7
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
