Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbUBTTQJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbUBTTPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:15:32 -0500
Received: from mail.kroah.org ([65.200.24.183]:17382 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261366AbUBTTGs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:06:48 -0500
Subject: Re: [PATCH] PCI update for 2.6.3
In-Reply-To: <10773039813517@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Feb 2004 11:06:22 -0800
Message-Id: <10773039823749@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1581, 2004/02/20 10:25:25-08:00, greg@kroah.com

[PATCH] PCI Hotplug: fix build warnings on 64 bit processors


 drivers/pci/hotplug/cpqphp_sysfs.c |    4 ++--
 drivers/pci/hotplug/pciehp_sysfs.c |    4 ++--
 drivers/pci/hotplug/shpchp_sysfs.c |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)


diff -Nru a/drivers/pci/hotplug/cpqphp_sysfs.c b/drivers/pci/hotplug/cpqphp_sysfs.c
--- a/drivers/pci/hotplug/cpqphp_sysfs.c	Fri Feb 20 10:44:17 2004
+++ b/drivers/pci/hotplug/cpqphp_sysfs.c	Fri Feb 20 10:44:17 2004
@@ -38,7 +38,7 @@
 
 /* A few routines that create sysfs entries for the hot plug controller */
 
-static int show_ctrl (struct device *dev, char *buf)
+static ssize_t show_ctrl (struct device *dev, char *buf)
 {
 	struct pci_dev *pci_dev;
 	struct controller *ctrl;
@@ -82,7 +82,7 @@
 }
 static DEVICE_ATTR (ctrl, S_IRUGO, show_ctrl, NULL);
 
-static int show_dev (struct device *dev, char *buf)
+static ssize_t show_dev (struct device *dev, char *buf)
 {
 	struct pci_dev *pci_dev;
 	struct controller *ctrl;
diff -Nru a/drivers/pci/hotplug/pciehp_sysfs.c b/drivers/pci/hotplug/pciehp_sysfs.c
--- a/drivers/pci/hotplug/pciehp_sysfs.c	Fri Feb 20 10:44:17 2004
+++ b/drivers/pci/hotplug/pciehp_sysfs.c	Fri Feb 20 10:44:17 2004
@@ -38,7 +38,7 @@
 
 /* A few routines that create sysfs entries for the hot plug controller */
 
-static int show_ctrl (struct device *dev, char *buf)
+static ssize_t show_ctrl (struct device *dev, char *buf)
 {
 	struct pci_dev *pci_dev;
 	struct controller *ctrl;
@@ -82,7 +82,7 @@
 }
 static DEVICE_ATTR (ctrl, S_IRUGO, show_ctrl, NULL);
 
-static int show_dev (struct device *dev, char *buf)
+static ssize_t show_dev (struct device *dev, char *buf)
 {
 	struct pci_dev *pci_dev;
 	struct controller *ctrl;
diff -Nru a/drivers/pci/hotplug/shpchp_sysfs.c b/drivers/pci/hotplug/shpchp_sysfs.c
--- a/drivers/pci/hotplug/shpchp_sysfs.c	Fri Feb 20 10:44:17 2004
+++ b/drivers/pci/hotplug/shpchp_sysfs.c	Fri Feb 20 10:44:17 2004
@@ -38,7 +38,7 @@
 
 /* A few routines that create sysfs entries for the hot plug controller */
 
-static int show_ctrl (struct device *dev, char *buf)
+static ssize_t show_ctrl (struct device *dev, char *buf)
 {
 	struct pci_dev *pci_dev;
 	struct controller *ctrl;
@@ -82,7 +82,7 @@
 }
 static DEVICE_ATTR (ctrl, S_IRUGO, show_ctrl, NULL);
 
-static int show_dev (struct device *dev, char *buf)
+static ssize_t show_dev (struct device *dev, char *buf)
 {
 	struct pci_dev *pci_dev;
 	struct controller *ctrl;

