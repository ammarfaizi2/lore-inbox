Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbTIEVwX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 17:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265584AbTIEVqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 17:46:54 -0400
Received: from palrel13.hp.com ([156.153.255.238]:29611 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265407AbTIEVpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 17:45:20 -0400
Date: Fri, 5 Sep 2003 14:45:18 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] Dongle module aliases
Message-ID: <20030905214518.GH14233@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir2604_modules_aliases.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Rusty Russell>
	o [FEATURE] Add module aliases to dongle drivers


diff -u -p linux/drivers/net/irda.d3/act200l.c linux/drivers/net/irda/act200l.c
--- linux/drivers/net/irda.d3/act200l.c	Mon Mar 24 14:00:39 2003
+++ linux/drivers/net/irda/act200l.c	Thu Sep  4 15:38:14 2003
@@ -280,6 +280,7 @@ static int act200l_reset(struct irda_tas
 MODULE_AUTHOR("SHIMIZU Takuya <tshimizu@ga2.so-net.ne.jp>");
 MODULE_DESCRIPTION("ACTiSYS ACT-IR200L dongle driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("irda-dongle-10"); /* IRDA_ACT200L_DONGLE */
 
 /*
  * Function init_module (void)
diff -u -p linux/drivers/net/irda.d3/actisys-sir.c linux/drivers/net/irda/actisys-sir.c
--- linux/drivers/net/irda.d3/actisys-sir.c	Mon Mar 24 14:00:49 2003
+++ linux/drivers/net/irda/actisys-sir.c	Thu Sep  4 15:38:14 2003
@@ -235,6 +235,8 @@ static int actisys_reset(struct sir_dev 
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no> - Jean Tourrilhes <jt@hpl.hp.com>");
 MODULE_DESCRIPTION("ACTiSYS IR-220L and IR-220L+ dongle driver");	
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("irda-dongle-2"); /* IRDA_ACTISYS_DONGLE */
+MODULE_ALIAS("irda-dongle-3"); /* IRDA_ACTISYS_PLUS_DONGLE */
 
 module_init(actisys_sir_init);
 module_exit(actisys_sir_cleanup);
diff -u -p linux/drivers/net/irda.d3/actisys.c linux/drivers/net/irda/actisys.c
--- linux/drivers/net/irda.d3/actisys.c	Mon Mar 24 14:01:53 2003
+++ linux/drivers/net/irda/actisys.c	Thu Sep  4 15:38:14 2003
@@ -270,6 +270,8 @@ static int actisys_reset(struct irda_tas
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no> - Jean Tourrilhes <jt@hpl.hp.com>");
 MODULE_DESCRIPTION("ACTiSYS IR-220L and IR-220L+ dongle driver");	
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("irda-dongle-2"); /* IRDA_ACTISYS_DONGLE */
+MODULE_ALIAS("irda-dongle-3"); /* IRDA_ACTISYS_PLUS_DONGLE */
 
 		
 /*
diff -u -p linux/drivers/net/irda.d3/ep7211_ir.c linux/drivers/net/irda/ep7211_ir.c
--- linux/drivers/net/irda.d3/ep7211_ir.c	Mon Mar 24 13:59:56 2003
+++ linux/drivers/net/irda/ep7211_ir.c	Thu Sep  4 15:38:14 2003
@@ -120,6 +120,7 @@ static void __exit ep7211_ir_cleanup(voi
 MODULE_AUTHOR("Jon McClintock <jonm@bluemug.com>");
 MODULE_DESCRIPTION("EP7211 I/R driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("irda-dongle-8"); /* IRDA_EP7211_IR */
 		
 module_init(ep7211_ir_init);
 module_exit(ep7211_ir_cleanup);
diff -u -p linux/drivers/net/irda.d3/esi-sir.c linux/drivers/net/irda/esi-sir.c
--- linux/drivers/net/irda.d3/esi-sir.c	Mon Mar 24 14:01:15 2003
+++ linux/drivers/net/irda/esi-sir.c	Thu Sep  4 15:38:14 2003
@@ -139,6 +139,7 @@ static int esi_reset(struct sir_dev *dev
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("Extended Systems JetEye PC dongle driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("irda-dongle-1"); /* IRDA_ESI_DONGLE */
 
 module_init(esi_sir_init);
 module_exit(esi_sir_cleanup);
diff -u -p linux/drivers/net/irda.d3/esi.c linux/drivers/net/irda/esi.c
--- linux/drivers/net/irda.d3/esi.c	Mon Mar 24 14:00:40 2003
+++ linux/drivers/net/irda/esi.c	Thu Sep  4 15:38:14 2003
@@ -133,6 +133,7 @@ static int esi_reset(struct irda_task *t
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("Extended Systems JetEye PC dongle driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("irda-dongle-1"); /* IRDA_ESI_DONGLE */
 
 /*
  * Function init_module (void)
diff -u -p linux/drivers/net/irda.d3/girbil.c linux/drivers/net/irda/girbil.c
--- linux/drivers/net/irda.d3/girbil.c	Mon Mar 24 13:59:53 2003
+++ linux/drivers/net/irda/girbil.c	Thu Sep  4 15:38:14 2003
@@ -232,7 +232,7 @@ static int girbil_reset(struct irda_task
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("Greenwich GIrBIL dongle driver");
 MODULE_LICENSE("GPL");
-
+MODULE_ALIAS("irda-dongle-4"); /* IRDA_GIRBIL_DONGLE */
 	
 /*
  * Function init_module (void)
diff -u -p linux/drivers/net/irda.d3/litelink.c linux/drivers/net/irda/litelink.c
--- linux/drivers/net/irda.d3/litelink.c	Mon Mar 24 14:00:44 2003
+++ linux/drivers/net/irda/litelink.c	Thu Sep  4 15:38:14 2003
@@ -164,7 +164,7 @@ static int litelink_reset(struct irda_ta
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("Parallax Litelink dongle driver");	
 MODULE_LICENSE("GPL");
-
+MODULE_ALIAS("irda-dongle-5"); /* IRDA_LITELINK_DONGLE */
 		
 /*
  * Function init_module (void)
diff -u -p linux/drivers/net/irda.d3/ma600.c linux/drivers/net/irda/ma600.c
--- linux/drivers/net/irda.d3/ma600.c	Tue Sep  2 18:59:32 2003
+++ linux/drivers/net/irda/ma600.c	Thu Sep  4 15:38:14 2003
@@ -336,6 +336,7 @@ int ma600_reset(struct irda_task *task)
 MODULE_AUTHOR("Leung <95Etwl@alumni.ee.ust.hk> http://www.engsvr.ust/~eetwl95");
 MODULE_DESCRIPTION("MA600 dongle driver version 0.1");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("irda-dongle-11"); /* IRDA_MA600_DONGLE */
 		
 /*
  * Function init_module (void)
diff -u -p linux/drivers/net/irda.d3/mcp2120.c linux/drivers/net/irda/mcp2120.c
--- linux/drivers/net/irda.d3/mcp2120.c	Mon Mar 24 14:01:46 2003
+++ linux/drivers/net/irda/mcp2120.c	Thu Sep  4 15:38:14 2003
@@ -223,7 +223,7 @@ static int mcp2120_reset(struct irda_tas
 MODULE_AUTHOR("Felix Tang <tangf@eyetap.org>");
 MODULE_DESCRIPTION("Microchip MCP2120");
 MODULE_LICENSE("GPL");
-
+MODULE_ALIAS("irda-dongle-9"); /* IRDA_MCP2120_DONGLE */
 	
 /*
  * Function init_module (void)
diff -u -p linux/drivers/net/irda.d3/old_belkin.c linux/drivers/net/irda/old_belkin.c
--- linux/drivers/net/irda.d3/old_belkin.c	Tue Sep  2 19:00:32 2003
+++ linux/drivers/net/irda/old_belkin.c	Thu Sep  4 15:38:14 2003
@@ -149,7 +149,7 @@ static int old_belkin_reset(struct irda_
 MODULE_AUTHOR("Jean Tourrilhes <jt@hpl.hp.com>");
 MODULE_DESCRIPTION("Belkin (old) SmartBeam dongle driver");	
 MODULE_LICENSE("GPL");
-
+MODULE_ALIAS("irda-dongle-7"); /* IRDA_OLD_BELKIN_DONGLE */
 
 /*
  * Function init_module (void)
diff -u -p linux/drivers/net/irda.d3/tekram-sir.c linux/drivers/net/irda/tekram-sir.c
--- linux/drivers/net/irda.d3/tekram-sir.c	Tue Sep  2 19:00:58 2003
+++ linux/drivers/net/irda/tekram-sir.c	Thu Sep  4 15:38:14 2003
@@ -242,6 +242,7 @@ static int tekram_reset(struct sir_dev *
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("Tekram IrMate IR-210B dongle driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("irda-dongle-0"); /* IRDA_TEKRAM_DONGLE */
 		
 module_init(tekram_sir_init);
 module_exit(tekram_sir_cleanup);
diff -u -p linux/drivers/net/irda.d3/tekram.c linux/drivers/net/irda/tekram.c
--- linux/drivers/net/irda.d3/tekram.c	Mon Mar 24 14:00:44 2003
+++ linux/drivers/net/irda/tekram.c	Thu Sep  4 15:38:14 2003
@@ -265,6 +265,7 @@ int tekram_reset(struct irda_task *task)
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("Tekram IrMate IR-210B dongle driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("irda-dongle-0"); /* IRDA_TEKRAM_DONGLE */
 		
 /*
  * Function init_module (void)
