Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262920AbVAQV6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbVAQV6Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 16:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262900AbVAQVzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 16:55:20 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:53714 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262906AbVAQVtV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:49:21 -0500
Cc: greg@kroah.com
Subject: [PATCH] I2C: add MODULE_DEVICE_TABLE to via686a.c driver
In-Reply-To: <20050117214543.GB28400@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 17 Jan 2005 13:46:35 -0800
Message-Id: <11059983952870@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2329.2.1, 2005/01/14 14:41:19-08:00, greg@kroah.com

[PATCH] I2C: add MODULE_DEVICE_TABLE to via686a.c driver

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/via686a.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)


diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	2005-01-17 13:21:21 -08:00
+++ b/drivers/i2c/chips/via686a.c	2005-01-17 13:21:21 -08:00
@@ -786,14 +786,11 @@
 }
 
 static struct pci_device_id via686a_pci_ids[] = {
-       {
-	       .vendor 		= PCI_VENDOR_ID_VIA, 
-	       .device 		= PCI_DEVICE_ID_VIA_82C686_4, 
-	       .subvendor	= PCI_ANY_ID, 
-	       .subdevice	= PCI_ANY_ID, 
-       },
+       { PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4) },
        { 0, }
 };
+
+MODULE_DEVICE_TABLE(pci, via686a_pci_ids);
 
 static int __devinit via686a_pci_probe(struct pci_dev *dev,
                                       const struct pci_device_id *id)

