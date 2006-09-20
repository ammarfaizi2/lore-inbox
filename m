Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWITTrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWITTrF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWITTrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:47:05 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:60866
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932333AbWITTrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:47:02 -0400
Subject: [PATCH] synclink_gt increase max devices
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 14:46:47 -0500
Message-Id: <1158781607.9073.1.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Increase maximum number of devices.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- linux-2.6.18/drivers/char/synclink_gt.c	2006-09-20 14:40:45.000000000 -0500
+++ b/drivers/char/synclink_gt.c	2006-09-20 14:43:23.000000000 -0500
@@ -1,5 +1,5 @@
 /*
- * $Id: synclink_gt.c,v 4.25 2006/02/06 21:20:33 paulkf Exp $
+ * $Id: synclink_gt.c,v 4.36 2006/08/28 20:47:14 paulkf Exp $
  *
  * Device driver for Microgate SyncLink GT serial adapters.
  *
@@ -91,12 +91,12 @@
  * module identification
  */
 static char *driver_name     = "SyncLink GT";
-static char *driver_version  = "$Revision: 4.25 $";
+static char *driver_version  = "$Revision: 4.36 $";
 static char *tty_driver_name = "synclink_gt";
 static char *tty_dev_prefix  = "ttySLG";
 MODULE_LICENSE("GPL");
 #define MGSL_MAGIC 0x5401
-#define MAX_DEVICES 12
+#define MAX_DEVICES 32
 
 static struct pci_device_id pci_table[] = {
 	{PCI_VENDOR_ID_MICROGATE, SYNCLINK_GT_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},


