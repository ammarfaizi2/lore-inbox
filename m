Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264415AbTH1WOw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 18:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264418AbTH1WNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 18:13:22 -0400
Received: from mail.kroah.org ([65.200.24.183]:38809 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264415AbTH1WKH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 18:10:07 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10621085972584@kroah.com>
Subject: Re: [PATCH] PCI Hotplug patches for 2.4.23-pre1
In-Reply-To: <10621085972208@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 28 Aug 2003 15:09:57 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       marcelo@conectiva.com.br
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1083.2.6, 2003/08/28 13:09:28-07:00, greg@kroah.com

[PATCH] PCI: add PCI_DEVICE_CLASS() macro to match PCI_DEVICE() macro.


 include/linux/pci.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+)


diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Aug 28 15:02:27 2003
+++ b/include/linux/pci.h	Thu Aug 28 15:02:27 2003
@@ -533,6 +533,20 @@
 	.vendor = (vend), .device = (dev), \
 	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
 
+/**
+ * PCI_DEVICE_CLASS - macro used to describe a specific pci device class
+ * @dev_class: the class, subclass, prog-if triple for this device
+ * @dev_class_mask: the class mask for this device
+ *
+ * This macro is used to create a struct pci_device_id that matches a
+ * specific PCI class.  The vendor, device, subvendor, and subdevice 
+ * fields will be set to PCI_ANY_ID.
+ */
+#define PCI_DEVICE_CLASS(dev_class,dev_class_mask) \
+	.class = (dev_class), .class_mask = (dev_class_mask), \
+	.vendor = PCI_ANY_ID, .device = PCI_ANY_ID, \
+	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
+
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 

