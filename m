Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbULAAPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbULAAPs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbULAAPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:15:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:32228 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261184AbULAAOO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:14:14 -0500
Subject: Re: [PATCH] I2C fixes for 2.6.10-rc2
In-Reply-To: <11018600193653@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Nov 2004 16:13:39 -0800
Message-Id: <11018600193669@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2223.2.10, 2004/11/29 15:41:38-08:00, khali@linux-fr.org

[PATCH] I2C: Add support for the nForce2 Ultra 400 to i2c-nforce2

This simple patch adds support for the nForce2 Ultra 400 to i2c-nforce2.
I just made a similar update on the 2.4/CVS version of the driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-nforce2.c |    9 ++++++---
 include/linux/pci_ids.h          |    1 +
 2 files changed, 7 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c	2004-11-30 16:00:37 -08:00
+++ b/drivers/i2c/busses/i2c-nforce2.c	2004-11-30 16:00:37 -08:00
@@ -24,9 +24,10 @@
 */
 
 /*
-    SUPPORTED DEVICES	PCI ID
-    nForce2 MCP		0064
-    nForce3 Pro150 MCP	00D4
+    SUPPORTED DEVICES		PCI ID
+    nForce2 MCP			0064
+    nForce2 Ultra 400 MCP	0084
+    nForce3 Pro150 MCP		00D4
 
     This driver supports the 2 SMBuses that are included in the MCP2 of the
     nForce2 chipset.
@@ -290,6 +291,8 @@
 
 static struct pci_device_id nforce2_ids[] = {
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS,
+	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SMBUS,
 	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS,
 	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2004-11-30 16:00:37 -08:00
+++ b/include/linux/pci_ids.h	2004-11-30 16:00:37 -08:00
@@ -1087,6 +1087,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
 #define PCI_DEVICE_ID_NVIDIA_NVENET_2		0x0066
 #define PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO		0x006a
+#define PCI_DEVICE_ID_NVIDIA_NFORCE2S_SMBUS	0x0084
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE	0x0085
 #define PCI_DEVICE_ID_NVIDIA_NVENET_4		0x0086
 #define PCI_DEVICE_ID_NVIDIA_NVENET_5		0x008c

