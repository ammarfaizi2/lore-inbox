Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbTLVWL5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 17:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264553AbTLVWL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 17:11:57 -0500
Received: from firewall.indigita.com ([65.211.227.66]:31732 "EHLO
	control2.indigita.com") by vger.kernel.org with ESMTP
	id S264546AbTLVWL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 17:11:56 -0500
Date: Mon, 22 Dec 2003 15:12:11 -0800
From: Jim Radford <radford@indigita.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] ppdev MODULES_ALIAS
Message-ID: <20031222231206.GA4138@indigita.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I finally took the time to figure our why my parallel port wasn't
working... here's the patch.

-Jim

--- linux-2.6/drivers/char/ppdev.c.orig	2003-09-12 12:02:43.000000000 -0700
+++ linux-2.6/drivers/char/ppdev.c	2003-12-22 14:08:13.000000000 -0800
@@ -67,6 +67,7 @@
 #include <asm/uaccess.h>
 #include <linux/ppdev.h>
 #include <linux/smp_lock.h>
+#include <linux/device.h>
 
 #define PP_VERSION "ppdev: user-space parallel port driver"
 #define CHRDEV "ppdev"
@@ -782,4 +783,4 @@
 module_exit(ppdev_cleanup);
 
 MODULE_LICENSE("GPL");
-
+MODULE_ALIAS_CHARDEV_MAJOR(PP_MAJOR);
