Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbTHURdU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbTHURbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:31:41 -0400
Received: from mail.kroah.org ([65.200.24.183]:16070 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262854AbTHURbC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:31:02 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10614870683797@kroah.com>
Subject: [PATCH] PCI fixes for 2.6.0-test3
In-Reply-To: <20030821172922.GA3761@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 21 Aug 2003 10:31:08 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1123.21.1, 2003/08/13 10:45:56-07:00, greg@kroah.com

[PATCH] PCI: add PCI_DEVICE() macro to make pci_device_id tables easier to read.


 include/linux/pci.h |   12 ++++++++++++
 1 files changed, 12 insertions(+)


diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Aug 21 10:23:14 2003
+++ b/include/linux/pci.h	Thu Aug 21 10:23:14 2003
@@ -524,6 +524,18 @@
 
 #define	to_pci_driver(drv) container_of(drv,struct pci_driver, driver)
 
+/**
+ * PCI_DEVICE - macro used to describe a specific pci device
+ * @vend: the 16 bit PCI Vendor ID
+ * @dev: the 16 bit PCI Device ID
+ *
+ * This macro is used to create a struct pci_device_id that matches a
+ * specific device.  The subvendor and subdevice fields will be set to
+ * PCI_ANY_ID.
+ */
+#define PCI_DEVICE(vend,dev) \
+	.vendor = (vend), .device = (dev), \
+	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
 
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI

