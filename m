Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbUBZDWD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbUBZDU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:20:57 -0500
Received: from palrel13.hp.com ([156.153.255.238]:64396 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262664AbUBZDSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:18:46 -0500
Date: Wed, 25 Feb 2004 19:18:44 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] infrared_mode
Message-ID: <20040226031844.GL32263@bougret.hpl.hp.com>
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

irXXX_infrared_mode.diff :
~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] remove unused code


diff -Nru a/include/net/irda/irda_device.h b/include/net/irda/irda_device.h
--- a/include/net/irda/irda_device.h	Mon Feb 16 10:35:53 2004
+++ b/include/net/irda/irda_device.h	Mon Feb 16 10:35:53 2004
@@ -243,8 +243,6 @@
 				    struct irda_task *parent, void *param);
 void irda_task_next_state(struct irda_task *task, IRDA_TASK_STATE state);
 
-extern const char *infrared_mode[];
-
 /*
  * Function irda_get_mtt (skb)
  *
diff -Nru a/net/irda/irda_device.c b/net/irda/irda_device.c
--- a/net/irda/irda_device.c	Mon Feb 16 10:35:53 2004
+++ b/net/irda/irda_device.c	Mon Feb 16 10:35:53 2004
@@ -60,13 +60,6 @@
 static hashbin_t *dongles = NULL;
 static hashbin_t *tasks = NULL;
 
-const char *infrared_mode[] = {
-	"IRDA_IRLAP",
-	"IRDA_RAW",
-	"SHARP_ASK",
-	"TV_REMOTE",
-};
-
 #ifdef CONFIG_IRDA_DEBUG
 static const char *task_state[] = {
 	"IRDA_TASK_INIT",
diff -Nru a/net/irda/irsyms.c b/net/irda/irsyms.c
--- a/net/irda/irsyms.c	Mon Feb 16 10:35:53 2004
+++ b/net/irda/irsyms.c	Mon Feb 16 10:35:53 2004
@@ -170,7 +170,6 @@
 #ifdef CONFIG_ISA
 EXPORT_SYMBOL(setup_dma);
 #endif
-EXPORT_SYMBOL(infrared_mode);
 
 #ifdef CONFIG_IRTTY
 EXPORT_SYMBOL(irtty_set_dtr_rts);
