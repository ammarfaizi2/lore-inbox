Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262875AbTHURdV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbTHURbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:31:36 -0400
Received: from mail.kroah.org ([65.200.24.183]:15558 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262850AbTHURbC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:31:02 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10614870691817@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test3
In-Reply-To: <10614870682543@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 21 Aug 2003 10:31:09 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1123.21.3, 2003/08/18 15:22:01-07:00, greg@kroah.com

[PATCH] PCI: add PCI_DEVICE_CLASS() macro to match PCI_DEVICE() macro.


 include/linux/pci.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+)


diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Aug 21 10:22:30 2003
+++ b/include/linux/pci.h	Thu Aug 21 10:22:30 2003
@@ -537,6 +537,20 @@
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
 

