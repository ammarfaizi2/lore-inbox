Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbTICIHU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 04:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbTICIGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 04:06:06 -0400
Received: from dp.samba.org ([66.70.73.150]:39073 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261613AbTICIEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 04:04:45 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jean Tourrilhes <jt@bougret.hpl.hp.com>, irda-users@lists.sourceforge.net
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH] MODULE_ALIAS for IRDA dongles
Date: Wed, 03 Sep 2003 17:49:36 +1000
Message-Id: <20030903080444.6FE6B2C085@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than hardcoded names in modprobe, modules can offer their own
aliases (which are overridden by config files).

Here are the IRDA dongle ones.

Please apply,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Module Aliases Inside Modules: IRDA
Author: Rusty Russell
Status: Trivial

D: MODULE_ALIAS() macros for IRDA.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12950-linux-2.6.0-test4-bk4/drivers/net/irda/act200l.c .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/act200l.c
--- .12950-linux-2.6.0-test4-bk4/drivers/net/irda/act200l.c	2003-02-07 19:16:15.000000000 +1100
+++ .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/act200l.c	2003-09-03 17:07:21.000000000 +1000
@@ -280,6 +280,7 @@ static int act200l_reset(struct irda_tas
 MODULE_AUTHOR("SHIMIZU Takuya <tshimizu@ga2.so-net.ne.jp>");
 MODULE_DESCRIPTION("ACTiSYS ACT-IR200L dongle driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("irda-dongle-10"); /* IRDA_ACT200L_DONGLE */
 
 /*
  * Function init_module (void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12950-linux-2.6.0-test4-bk4/drivers/net/irda/actisys-sir.c .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/actisys-sir.c
--- .12950-linux-2.6.0-test4-bk4/drivers/net/irda/actisys-sir.c	2003-03-18 05:01:45.000000000 +1100
+++ .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/actisys-sir.c	2003-09-03 17:12:50.000000000 +1000
@@ -235,6 +235,8 @@ static int actisys_reset(struct sir_dev 
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no> - Jean Tourrilhes <jt@hpl.hp.com>");
 MODULE_DESCRIPTION("ACTiSYS IR-220L and IR-220L+ dongle driver");	
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("irda-dongle-2"); /* IRDA_ACTISYS_DONGLE */
+MODULE_ALIAS("irda-dongle-3"); /* IRDA_ACTISYS_PLUS_DONGLE */
 
 module_init(actisys_sir_init);
 module_exit(actisys_sir_cleanup);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12950-linux-2.6.0-test4-bk4/drivers/net/irda/actisys.c .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/actisys.c
--- .12950-linux-2.6.0-test4-bk4/drivers/net/irda/actisys.c	2003-03-18 05:01:45.000000000 +1100
+++ .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/actisys.c	2003-09-03 17:08:10.000000000 +1000
@@ -270,6 +270,8 @@ static int actisys_reset(struct irda_tas
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no> - Jean Tourrilhes <jt@hpl.hp.com>");
 MODULE_DESCRIPTION("ACTiSYS IR-220L and IR-220L+ dongle driver");	
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("irda-ongle-2"); /* IRDA_ACTISYS_DONGLE */
+MODULE_ALIAS("irda-dongle-3"); /* IRDA_ACTISYS_PLUS_DONGLE */
 
 		
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12950-linux-2.6.0-test4-bk4/drivers/net/irda/ep7211_ir.c .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/ep7211_ir.c
--- .12950-linux-2.6.0-test4-bk4/drivers/net/irda/ep7211_ir.c	2003-02-07 19:16:15.000000000 +1100
+++ .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/ep7211_ir.c	2003-09-03 17:08:57.000000000 +1000
@@ -120,6 +120,7 @@ static void __exit ep7211_ir_cleanup(voi
 MODULE_AUTHOR("Jon McClintock <jonm@bluemug.com>");
 MODULE_DESCRIPTION("EP7211 I/R driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("irda-dongle-8"); /* IRDA_EP7211_IR */
 		
 module_init(ep7211_ir_init);
 module_exit(ep7211_ir_cleanup);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12950-linux-2.6.0-test4-bk4/drivers/net/irda/esi-sir.c .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/esi-sir.c
--- .12950-linux-2.6.0-test4-bk4/drivers/net/irda/esi-sir.c	2003-01-02 12:34:05.000000000 +1100
+++ .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/esi-sir.c	2003-09-03 17:13:12.000000000 +1000
@@ -139,6 +139,7 @@ static int esi_reset(struct sir_dev *dev
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("Extended Systems JetEye PC dongle driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("irda-dongle-1"); /* IRDA_ESI_DONGLE */
 
 module_init(esi_sir_init);
 module_exit(esi_sir_cleanup);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12950-linux-2.6.0-test4-bk4/drivers/net/irda/esi.c .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/esi.c
--- .12950-linux-2.6.0-test4-bk4/drivers/net/irda/esi.c	2003-02-07 19:16:15.000000000 +1100
+++ .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/esi.c	2003-09-03 17:06:17.000000000 +1000
@@ -133,6 +133,7 @@ static int esi_reset(struct irda_task *t
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("Extended Systems JetEye PC dongle driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("irda-dongle-1"); /* IRDA_ESI_DONGLE */
 
 /*
  * Function init_module (void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12950-linux-2.6.0-test4-bk4/drivers/net/irda/girbil.c .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/girbil.c
--- .12950-linux-2.6.0-test4-bk4/drivers/net/irda/girbil.c	2003-02-07 19:16:15.000000000 +1100
+++ .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/girbil.c	2003-09-03 17:09:57.000000000 +1000
@@ -232,7 +232,7 @@ static int girbil_reset(struct irda_task
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("Greenwich GIrBIL dongle driver");
 MODULE_LICENSE("GPL");
-
+MODULE_ALIAS("irda-dongle-4"); /* IRDA_GIRBIL_DONGLE */
 	
 /*
  * Function init_module (void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12950-linux-2.6.0-test4-bk4/drivers/net/irda/litelink.c .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/litelink.c
--- .12950-linux-2.6.0-test4-bk4/drivers/net/irda/litelink.c	2003-02-07 19:16:15.000000000 +1100
+++ .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/litelink.c	2003-09-03 17:10:24.000000000 +1000
@@ -164,7 +164,7 @@ static int litelink_reset(struct irda_ta
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("Parallax Litelink dongle driver");	
 MODULE_LICENSE("GPL");
-
+MODULE_ALIAS("irda-dongle-5"); /* IRDA_LITELINK_DONGLE */
 		
 /*
  * Function init_module (void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12950-linux-2.6.0-test4-bk4/drivers/net/irda/ma600.c .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/ma600.c
--- .12950-linux-2.6.0-test4-bk4/drivers/net/irda/ma600.c	2003-06-17 16:57:31.000000000 +1000
+++ .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/ma600.c	2003-09-03 17:10:46.000000000 +1000
@@ -336,6 +336,7 @@ int ma600_reset(struct irda_task *task)
 MODULE_AUTHOR("Leung <95Etwl@alumni.ee.ust.hk> http://www.engsvr.ust/~eetwl95");
 MODULE_DESCRIPTION("MA600 dongle driver version 0.1");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("irda-dongle-11"); /* IRDA_MA600_DONGLE */
 		
 /*
  * Function init_module (void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12950-linux-2.6.0-test4-bk4/drivers/net/irda/mcp2120.c .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/mcp2120.c
--- .12950-linux-2.6.0-test4-bk4/drivers/net/irda/mcp2120.c	2003-02-07 19:16:15.000000000 +1100
+++ .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/mcp2120.c	2003-09-03 17:11:03.000000000 +1000
@@ -223,7 +223,7 @@ static int mcp2120_reset(struct irda_tas
 MODULE_AUTHOR("Felix Tang <tangf@eyetap.org>");
 MODULE_DESCRIPTION("Microchip MCP2120");
 MODULE_LICENSE("GPL");
-
+MODULE_ALIAS("irda-dongle-9"); /* IRDA_MCP2120_DONGLE */
 	
 /*
  * Function init_module (void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12950-linux-2.6.0-test4-bk4/drivers/net/irda/old_belkin.c .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/old_belkin.c
--- .12950-linux-2.6.0-test4-bk4/drivers/net/irda/old_belkin.c	2003-07-14 16:58:36.000000000 +1000
+++ .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/old_belkin.c	2003-09-03 17:11:25.000000000 +1000
@@ -149,7 +149,7 @@ static int old_belkin_reset(struct irda_
 MODULE_AUTHOR("Jean Tourrilhes <jt@hpl.hp.com>");
 MODULE_DESCRIPTION("Belkin (old) SmartBeam dongle driver");	
 MODULE_LICENSE("GPL");
-
+MODULE_ALIAS("irda-dongle-7"); /* IRDA_OLD_BELKIN_DONGLE */
 
 /*
  * Function init_module (void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12950-linux-2.6.0-test4-bk4/drivers/net/irda/tekram-sir.c .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/tekram-sir.c
--- .12950-linux-2.6.0-test4-bk4/drivers/net/irda/tekram-sir.c	2003-08-12 06:57:45.000000000 +1000
+++ .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/tekram-sir.c	2003-09-03 16:15:26.000000000 +1000
@@ -242,6 +242,7 @@ static int tekram_reset(struct sir_dev *
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("Tekram IrMate IR-210B dongle driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("irda-dongle-0"); /* IRDA_TEKRAM_DONGLE */
 		
 module_init(tekram_sir_init);
 module_exit(tekram_sir_cleanup);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12950-linux-2.6.0-test4-bk4/drivers/net/irda/tekram.c .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/tekram.c
--- .12950-linux-2.6.0-test4-bk4/drivers/net/irda/tekram.c	2003-02-07 19:16:15.000000000 +1100
+++ .12950-linux-2.6.0-test4-bk4.updated/drivers/net/irda/tekram.c	2003-09-03 16:13:23.000000000 +1000
@@ -265,6 +265,7 @@ int tekram_reset(struct irda_task *task)
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("Tekram IrMate IR-210B dongle driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("irda-dongle-0"); /* IRDA_TEKRAM_DONGLE */
 		
 /*
  * Function init_module (void)
