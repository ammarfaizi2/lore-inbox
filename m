Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264408AbTH1WKB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 18:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264415AbTH1WKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 18:10:00 -0400
Received: from mail.kroah.org ([65.200.24.183]:32665 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264408AbTH1WJ5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 18:09:57 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10621085972208@kroah.com>
Subject: Re: [PATCH] PCI Hotplug patches for 2.4.23-pre1
In-Reply-To: <10621085973972@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 28 Aug 2003 15:09:57 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       marcelo@conectiva.com.br
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1083.2.5, 2003/08/28 13:09:20-07:00, greg@kroah.com

[PATCH] PCI: add PCI_DEVICE() macro to make pci_device_id tables easier to read.


 include/linux/pci.h |   12 ++++++++++++
 1 files changed, 12 insertions(+)


diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Aug 28 15:02:28 2003
+++ b/include/linux/pci.h	Thu Aug 28 15:02:28 2003
@@ -520,6 +520,18 @@
 	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
 };
 
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

