Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWCYRB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWCYRB4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 12:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWCYRBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 12:01:55 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14607 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751075AbWCYRBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 12:01:55 -0500
Date: Sat, 25 Mar 2006 18:01:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: stern@rowland.harvard.edu, gregkh@suse.de
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/usb/host/pci-quirks.c: proper prototypes
Message-ID: <20060325170153.GE4053@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a header file with proper prototypes for two functions 
in drivers/usb/host/pci-quirks.c.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/usb/host/pci-quirks.c |    1 +
 drivers/usb/host/pci-quirks.h |    7 +++++++
 drivers/usb/host/uhci-hcd.c   |    4 +---
 3 files changed, 9 insertions(+), 3 deletions(-)

--- /dev/null	2006-02-12 01:05:26.000000000 +0100
+++ linux-2.6.16-mm1-full/drivers/usb/host/pci-quirks.h	2006-03-25 15:55:14.000000000 +0100
@@ -0,0 +1,7 @@
+#ifndef __LINUX_USB_PCI_QUIRKS_H
+#define __LINUX_USB_PCI_QUIRKS_H
+
+void uhci_reset_hc(struct pci_dev *pdev, unsigned long base);
+int uhci_check_and_reset_hc(struct pci_dev *pdev, unsigned long base);
+
+#endif  /*  __LINUX_USB_PCI_QUIRKS_H  */
--- linux-2.6.16-mm1-full/drivers/usb/host/pci-quirks.c.old	2006-03-25 15:21:49.000000000 +0100
+++ linux-2.6.16-mm1-full/drivers/usb/host/pci-quirks.c	2006-03-25 15:55:34.000000000 +0100
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/acpi.h>
+#include "pci-quirks.h"
 
 
 #define UHCI_USBLEGSUP		0xc0		/* legacy support */
--- linux-2.6.16-mm1-full/drivers/usb/host/uhci-hcd.c.old	2006-03-25 15:22:20.000000000 +0100
+++ linux-2.6.16-mm1-full/drivers/usb/host/uhci-hcd.c	2006-03-25 15:55:54.000000000 +0100
@@ -50,6 +50,7 @@
 
 #include "../core/hcd.h"
 #include "uhci-hcd.h"
+#include "pci-quirks.h"
 
 /*
  * Version Information
@@ -100,9 +101,6 @@
 #include "uhci-q.c"
 #include "uhci-hub.c"
 
-extern void uhci_reset_hc(struct pci_dev *pdev, unsigned long base);
-extern int uhci_check_and_reset_hc(struct pci_dev *pdev, unsigned long base);
-
 /*
  * Finish up a host controller reset and update the recorded state.
  */

