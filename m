Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269793AbUJSQ6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269793AbUJSQ6S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269691AbUJSQ5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:57:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:46532 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269688AbUJSQil convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:41 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <10982037992819@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:41 -0700
Message-Id: <10982038014021@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1946.10.7, 2004/09/24 11:47:15-07:00, mochel@digitalimplant.org

[driver model] Change symbol exports to GPL only in sys.c

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/sys.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)


diff -Nru a/drivers/base/sys.c b/drivers/base/sys.c
--- a/drivers/base/sys.c	2004-10-19 09:21:42 -07:00
+++ b/drivers/base/sys.c	2004-10-19 09:21:42 -07:00
@@ -73,8 +73,8 @@
 	sysfs_remove_file(&s->kobj, &a->attr);
 }
 
-EXPORT_SYMBOL(sysdev_create_file);
-EXPORT_SYMBOL(sysdev_remove_file);
+EXPORT_SYMBOL_GPL(sysdev_create_file);
+EXPORT_SYMBOL_GPL(sysdev_remove_file);
 
 /*
  * declare system_subsys
@@ -98,8 +98,8 @@
 	kset_unregister(&cls->kset);
 }
 
-EXPORT_SYMBOL(sysdev_class_register);
-EXPORT_SYMBOL(sysdev_class_unregister);
+EXPORT_SYMBOL_GPL(sysdev_class_register);
+EXPORT_SYMBOL_GPL(sysdev_class_unregister);
 
 
 static LIST_HEAD(global_drivers);
@@ -157,8 +157,8 @@
 	up_write(&system_subsys.rwsem);
 }
 
-EXPORT_SYMBOL(sysdev_driver_register);
-EXPORT_SYMBOL(sysdev_driver_unregister);
+EXPORT_SYMBOL_GPL(sysdev_driver_register);
+EXPORT_SYMBOL_GPL(sysdev_driver_unregister);
 
 
 
@@ -392,5 +392,5 @@
 	return subsystem_register(&system_subsys);
 }
 
-EXPORT_SYMBOL(sysdev_register);
-EXPORT_SYMBOL(sysdev_unregister);
+EXPORT_SYMBOL_GPL(sysdev_register);
+EXPORT_SYMBOL_GPL(sysdev_unregister);

