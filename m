Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbUBZDhb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbUBZDee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:34:34 -0500
Received: from palrel11.hp.com ([156.153.255.246]:33184 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262671AbUBZDWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:22:48 -0500
Date: Wed, 25 Feb 2004 19:22:46 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] dongles-12_dup_symbols
Message-ID: <20040226032246.GR32263@bougret.hpl.hp.com>
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

ir263_dongles-12_dup_symbols.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [FEATURE] rename dongle entry points for consistency


diff -u -p linux/drivers/net/irda.d9/act200l-sir.c linux/drivers/net/irda/act200l-sir.c
--- linux/drivers/net/irda.d9/act200l-sir.c	Wed Feb 18 11:09:20 2004
+++ linux/drivers/net/irda/act200l-sir.c	Wed Feb 25 18:28:53 2004
@@ -93,12 +93,12 @@ static struct dongle_driver act200l = {
 	.set_speed	= act200l_change_speed,
 };
 
-static int __init act200l_init(void)
+static int __init act200l_sir_init(void)
 {
 	return irda_register_dongle(&act200l);
 }
 
-static void __exit act200l_cleanup(void)
+static void __exit act200l_sir_cleanup(void)
 {
 	irda_unregister_dongle(&act200l);
 }
@@ -254,5 +254,5 @@ MODULE_DESCRIPTION("ACTiSYS ACT-IR200L d
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("irda-dongle-10"); /* IRDA_ACT200L_DONGLE */
 
-module_init(act200l_init);
-module_exit(act200l_cleanup);
+module_init(act200l_sir_init);
+module_exit(act200l_sir_cleanup);
diff -u -p linux/drivers/net/irda.d9/girbil-sir.c linux/drivers/net/irda/girbil-sir.c
--- linux/drivers/net/irda.d9/girbil-sir.c	Wed Feb 18 11:09:20 2004
+++ linux/drivers/net/irda/girbil-sir.c	Wed Feb 25 18:29:33 2004
@@ -72,12 +72,12 @@ static struct dongle_driver girbil = {
 	.set_speed	= girbil_change_speed,
 };
 
-static int __init girbil_init(void)
+static int __init girbil_sir_init(void)
 {
 	return irda_register_dongle(&girbil);
 }
 
-static void __exit girbil_cleanup(void)
+static void __exit girbil_sir_cleanup(void)
 {
 	irda_unregister_dongle(&girbil);
 }
@@ -254,5 +254,5 @@ MODULE_DESCRIPTION("Greenwich GIrBIL don
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("irda-dongle-4"); /* IRDA_GIRBIL_DONGLE */
 
-module_init(girbil_init);
-module_exit(girbil_cleanup);
+module_init(girbil_sir_init);
+module_exit(girbil_sir_cleanup);
diff -u -p linux/drivers/net/irda.d9/mcp2120-sir.c linux/drivers/net/irda/mcp2120-sir.c
--- linux/drivers/net/irda.d9/mcp2120-sir.c	Wed Feb 18 11:09:20 2004
+++ linux/drivers/net/irda/mcp2120-sir.c	Wed Feb 25 18:30:05 2004
@@ -49,12 +49,12 @@ static struct dongle_driver mcp2120 = {
 	.set_speed	= mcp2120_change_speed,
 };
 
-static int __init mcp2120_init(void)
+static int __init mcp2120_sir_init(void)
 {
 	return irda_register_dongle(&mcp2120);
 }
 
-static void __exit mcp2120_cleanup(void)
+static void __exit mcp2120_sir_cleanup(void)
 {
 	irda_unregister_dongle(&mcp2120);
 }
@@ -226,5 +226,5 @@ MODULE_DESCRIPTION("Microchip MCP2120");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("irda-dongle-9"); /* IRDA_MCP2120_DONGLE */
 
-module_init(mcp2120_init);
-module_exit(mcp2120_cleanup);
+module_init(mcp2120_sir_init);
+module_exit(mcp2120_sir_cleanup);
diff -u -p linux/drivers/net/irda.d9/old_belkin-sir.c linux/drivers/net/irda/old_belkin-sir.c 
--- linux/drivers/net/irda.d9/old_belkin-sir.c	Wed Feb 18 11:09:20 2004
+++ linux/drivers/net/irda/old_belkin-sir.c	Wed Feb 25 18:31:02 2004
@@ -78,12 +78,12 @@ static struct dongle_driver old_belkin =
 	.set_speed	= old_belkin_change_speed,
 };
 
-static int __init old_belkin_init(void)
+static int __init old_belkin_sir_init(void)
 {
 	return irda_register_dongle(&old_belkin);
 }
 
-static void __exit old_belkin_cleanup(void)
+static void __exit old_belkin_sir_cleanup(void)
 {
 	irda_unregister_dongle(&old_belkin);
 }
@@ -152,5 +152,5 @@ MODULE_DESCRIPTION("Belkin (old) SmartBe
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("irda-dongle-7"); /* IRDA_OLD_BELKIN_DONGLE */
 
-module_init(old_belkin_init);
-module_exit(old_belkin_cleanup);
+module_init(old_belkin_sir_init);
+module_exit(old_belkin_sir_cleanup);
