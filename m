Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbTIPSSG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 14:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbTIPSSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 14:18:06 -0400
Received: from vena.lwn.net ([206.168.112.25]:15556 "HELO lwn.net")
	by vger.kernel.org with SMTP id S261984AbTIPSSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 14:18:03 -0400
Message-ID: <20030916181802.6046.qmail@lwn.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Export new char dev functions
cc: torvalds@osdl.org
From: Jonathan Corbet <corbet@lwn.net>
Date: Tue, 16 Sep 2003 12:18:02 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody told me that the failure to export these (like their block
counterparts) was anything but an oversight; modules will not be able to
use larger device numbers without them.  So...this patch exports the new
char device functions.

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net


--- test5-vanilla/kernel/ksyms.c	Wed Sep 17 01:58:05 2003
+++ test5/kernel/ksyms.c	Wed Sep 17 02:05:29 2003
@@ -42,6 +42,7 @@
 #include <linux/highuid.h>
 #include <linux/fs.h>
 #include <linux/fs_struct.h>
+#include <linux/cdev.h>
 #include <linux/uio.h>
 #include <linux/tty.h>
 #include <linux/in6.h>
@@ -355,6 +356,16 @@
 EXPORT_SYMBOL(tty_register_driver);
 EXPORT_SYMBOL(tty_unregister_driver);
 EXPORT_SYMBOL(tty_std_termios);
+EXPORT_SYMBOL(register_chrdev_region);
+EXPORT_SYMBOL(unregister_chrdev_region);
+EXPORT_SYMBOL(alloc_chrdev_region);
+EXPORT_SYMBOL(cdev_init);
+EXPORT_SYMBOL(cdev_alloc);
+EXPORT_SYMBOL(cdev_get);
+EXPORT_SYMBOL(cdev_put);
+EXPORT_SYMBOL(cdev_del);
+EXPORT_SYMBOL(cdev_add);
+EXPORT_SYMBOL(cdev_unmap);
 
 /* block device driver support */
 EXPORT_SYMBOL(bmap);
