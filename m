Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270684AbTHOSQn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270671AbTHOSQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:16:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:21216 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270691AbTHOSQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:16:40 -0400
Date: Fri, 15 Aug 2003 11:16:26 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] class_device_rename can take const char *
Message-Id: <20030815111626.2d94aef8.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial change: rename can take a constant string.
diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Fri Aug 15 11:11:36 2003
+++ b/drivers/base/class.c	Fri Aug 15 11:11:36 2003
@@ -341,7 +341,7 @@
 	class_device_put(class_dev);
 }
 
-int class_device_rename(struct class_device *class_dev, char *new_name)
+int class_device_rename(struct class_device *class_dev, const char *new_name)
 {
 	class_dev = class_device_get(class_dev);
 	if (!class_dev)
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Fri Aug 15 11:11:36 2003
+++ b/include/linux/device.h	Fri Aug 15 11:11:36 2003
@@ -210,7 +210,7 @@
 extern int class_device_add(struct class_device *);
 extern void class_device_del(struct class_device *);
 
-extern int class_device_rename(struct class_device *, char *);
+extern int class_device_rename(struct class_device *, const char *);
 
 extern struct class_device * class_device_get(struct class_device *);
 extern void class_device_put(struct class_device *);
