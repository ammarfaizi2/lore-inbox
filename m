Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbVKAPOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbVKAPOJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 10:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbVKAPOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 10:14:09 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:42392 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750848AbVKAPOI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 10:14:08 -0500
Date: Tue, 1 Nov 2005 15:14:05 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] missing platform_device.h includes
Message-ID: <20051101151405.GX7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-base/arch/um/include/net_kern.h current/arch/um/include/net_kern.h
--- RC14-base/arch/um/include/net_kern.h	2005-06-17 15:48:29.000000000 -0400
+++ current/arch/um/include/net_kern.h	2005-11-01 03:11:57.000000000 -0500
@@ -6,10 +6,11 @@
 #ifndef __UM_NET_KERN_H
 #define __UM_NET_KERN_H
 
-#include "linux/netdevice.h"
-#include "linux/skbuff.h"
-#include "linux/socket.h"
-#include "linux/list.h"
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/skbuff.h>
+#include <linux/socket.h>
+#include <linux/list.h>
 
 struct uml_net {
 	struct list_head list;
diff -urN RC14-base/drivers/char/tlclk.c current/drivers/char/tlclk.c
--- RC14-base/drivers/char/tlclk.c	2005-11-01 02:43:04.000000000 -0500
+++ current/drivers/char/tlclk.c	2005-11-01 03:16:56.000000000 -0500
@@ -43,6 +43,7 @@
 #include <linux/sysfs.h>
 #include <linux/device.h>
 #include <linux/miscdevice.h>
+#include <linux/platform_device.h>
 #include <asm/io.h>		/* inb/outb */
 #include <asm/uaccess.h>
 
diff -urN RC14-base/drivers/char/tpm/tpm.h current/drivers/char/tpm/tpm.h
--- RC14-base/drivers/char/tpm/tpm.h	2005-10-30 23:22:38.000000000 -0500
+++ current/drivers/char/tpm/tpm.h	2005-11-01 03:15:26.000000000 -0500
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <linux/platform_device.h>
 
 enum tpm_timeout {
 	TPM_TIMEOUT = 5,	/* msecs */
diff -urN RC14-base/include/asm-ppc/mv64x60.h current/include/asm-ppc/mv64x60.h
--- RC14-base/include/asm-ppc/mv64x60.h	2005-10-28 16:42:48.000000000 -0400
+++ current/include/asm-ppc/mv64x60.h	2005-11-01 03:17:35.000000000 -0500
@@ -27,6 +27,8 @@
 #include <asm/pci-bridge.h>
 #include <asm/mv64x60_defs.h>
 
+struct platform_device;
+
 extern u8	mv64x60_pci_exclude_bridge;
 
 extern spinlock_t mv64x60_lock;
