Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUCCEdx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 23:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbUCCEdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 23:33:40 -0500
Received: from mail.kroah.org ([65.200.24.183]:39042 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262368AbUCCEWD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 23:22:03 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.4-rc1
In-Reply-To: <10782873983662@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 2 Mar 2004 20:16:39 -0800
Message-Id: <10782873993927@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1612.24.2, 2004/03/01 15:54:54-08:00, rddunlap@osdl.org

[PATCH] rename sys_bus_init()

	rename sys_bus_init() to system_bus_init() so that
	it doesn't appear to be a syscall;


 drivers/base/init.c |    4 ++--
 drivers/base/sys.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/drivers/base/init.c b/drivers/base/init.c
--- a/drivers/base/init.c	Tue Mar  2 19:49:05 2004
+++ b/drivers/base/init.c	Tue Mar  2 19:49:05 2004
@@ -15,7 +15,7 @@
 extern int classes_init(void);
 extern int firmware_init(void);
 extern int platform_bus_init(void);
-extern int sys_bus_init(void);
+extern int system_bus_init(void);
 extern int cpu_dev_init(void);
 
 /**
@@ -37,6 +37,6 @@
 	 * core core pieces.
 	 */
 	platform_bus_init();
-	sys_bus_init();
+	system_bus_init();
 	cpu_dev_init();
 }
diff -Nru a/drivers/base/sys.c b/drivers/base/sys.c
--- a/drivers/base/sys.c	Tue Mar  2 19:49:05 2004
+++ b/drivers/base/sys.c	Tue Mar  2 19:49:05 2004
@@ -384,7 +384,7 @@
 }
 
 
-int __init sys_bus_init(void)
+int __init system_bus_init(void)
 {
 	system_subsys.kset.kobj.parent = &devices_subsys.kset.kobj;
 	return subsystem_register(&system_subsys);

