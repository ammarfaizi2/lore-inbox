Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbUCAXmo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 18:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUCAXmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 18:42:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:27353 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261493AbUCAXml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 18:42:41 -0500
Date: Mon, 1 Mar 2004 15:42:10 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: gregkh <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] rename sys_bus_init()
Message-Id: <20040301154210.5958fc02.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply to 2.6.current.

Thanks,
--
~Randy


// linux 2.6.4 2004.0301
desc:	rename sys_bus_init() to system_bus_init() so that
	it doesn't appear to be a syscall;

diffstat:=
 drivers/base/init.c |    4 ++--
 drivers/base/sys.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)


diff -Naurp ./drivers/base/init.c~sysbus ./drivers/base/init.c
--- ./drivers/base/init.c~sysbus	2004-03-01 14:07:21.000000000 -0800
+++ ./drivers/base/init.c	2004-03-01 14:55:55.000000000 -0800
@@ -15,7 +15,7 @@ extern int buses_init(void);
 extern int classes_init(void);
 extern int firmware_init(void);
 extern int platform_bus_init(void);
-extern int sys_bus_init(void);
+extern int system_bus_init(void);
 extern int cpu_dev_init(void);
 
 /**
@@ -37,6 +37,6 @@ void __init driver_init(void)
 	 * core core pieces.
 	 */
 	platform_bus_init();
-	sys_bus_init();
+	system_bus_init();
 	cpu_dev_init();
 }
diff -Naurp ./drivers/base/sys.c~sysbus ./drivers/base/sys.c
--- ./drivers/base/sys.c~sysbus	2004-03-01 14:07:18.000000000 -0800
+++ ./drivers/base/sys.c	2004-03-01 14:55:44.000000000 -0800
@@ -384,7 +384,7 @@ int sysdev_resume(void)
 }
 
 
-int __init sys_bus_init(void)
+int __init system_bus_init(void)
 {
 	system_subsys.kset.kobj.parent = &devices_subsys.kset.kobj;
 	return subsystem_register(&system_subsys);
