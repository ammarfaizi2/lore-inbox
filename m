Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVAHHgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVAHHgG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVAHHf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:35:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:40069 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261853AbVAHFsN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:13 -0500
Subject: Re: [PATCH] I2C patches for 2.6.10
In-Reply-To: <11051627751125@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:39:35 -0800
Message-Id: <11051627751181@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.445.6, 2004/12/17 13:32:32-08:00, khali@linux-fr.org

[PATCH] I2C: i2c-nforce2 supports the nForce3 250Gb

One more PCI ID for the i2c-nforce2 driver, this time for the nForce3
250Gb variant. Tested, works.

(Also cleans up a duplicate define in pci_ids.h.)

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-nforce2.c |    3 +++
 include/linux/pci_ids.h          |    2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c	2005-01-07 14:55:43 -08:00
+++ b/drivers/i2c/busses/i2c-nforce2.c	2005-01-07 14:55:43 -08:00
@@ -28,6 +28,7 @@
     nForce2 MCP			0064
     nForce2 Ultra 400 MCP	0084
     nForce3 Pro150 MCP		00D4
+    nForce3 250Gb MCP		00E4
 
     This driver supports the 2 SMBuses that are included in the MCP2 of the
     nForce2 chipset.
@@ -295,6 +296,8 @@
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SMBUS,
 	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS,
+	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SMBUS,
 	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0 }
 };
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2005-01-07 14:55:43 -08:00
+++ b/include/linux/pci_ids.h	2005-01-07 14:55:43 -08:00
@@ -1097,7 +1097,6 @@
 #define PCI_DEVICE_ID_NVIDIA_ITNT2		0x00A0
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3		0x00d1
 #define PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO		0x00da
-#define PCI_DEVICE_ID_NVIDIA_NFORCE3S  		0x00e1
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS	0x00d4
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE	0x00d5
 #define PCI_DEVICE_ID_NVIDIA_NVENET_3		0x00d6
@@ -1105,6 +1104,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NVENET_7		0x00df
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3S		0x00e1
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA	0x00e3
+#define PCI_DEVICE_ID_NVIDIA_NFORCE3S_SMBUS	0x00e4
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE	0x00e5
 #define PCI_DEVICE_ID_NVIDIA_NVENET_6		0x00e6
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2	0x00ee

