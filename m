Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756011AbWKVXTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011AbWKVXTT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 18:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757162AbWKVXTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 18:19:19 -0500
Received: from mga02.intel.com ([134.134.136.20]:19266 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1756011AbWKVXTT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 18:19:19 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,449,1157353200"; 
   d="scan'208"; a="165614373:sNHT19134969"
From: Jason Gaston <jason.d.gaston@intel.com>
To: khali@linux-fr.org, linux-kernel@vger.kernel.org, gregkh@suse.de,
       jason.d.gaston@intel.com, i2c@lm-sensors.org
Subject: [PATCH 2.6.19-rc6] i2c-i801: SMBus patch for Intel ICH9
Date: Wed, 22 Nov 2006 15:19:12 -0800
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611221519.12373.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This updated patch adds the Intel ICH9 LPC and SMBus Controller DID's.  This patch relies on the irq ICH9 patch to pci_ids.h.

Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>

--- linux-2.6.19-rc6/drivers/i2c/busses/i2c-i801.c.orig	2006-11-22 06:17:20.000000000 -0800
+++ linux-2.6.19-rc6/drivers/i2c/busses/i2c-i801.c	2006-11-22 06:27:12.000000000 -0800
@@ -33,6 +33,7 @@
     ICH7		27DA
     ESB2		269B
     ICH8		283E
+    ICH9		2930
     This driver supports several versions of Intel's I/O Controller Hubs (ICH).
     For SMBus support, they are similar to the PIIX4 and are part
     of Intel's '810' and other chipsets.
@@ -457,6 +458,7 @@
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_17) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_17) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH8_5) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH9_6) },
 	{ 0, }
 };
 
--- linux-2.6.19-rc6/drivers/i2c/busses/Kconfig.orig	2006-11-22 07:05:25.000000000 -0800
+++ linux-2.6.19-rc6/drivers/i2c/busses/Kconfig	2006-11-22 07:05:36.000000000 -0800
@@ -125,6 +125,7 @@
 	    ICH7
 	    ESB2
 	    ICH8
+	    ICH9
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
