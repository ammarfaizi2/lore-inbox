Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbUCITWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbUCITQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:16:10 -0500
Received: from palrel13.hp.com ([156.153.255.238]:14499 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262110AbUCITNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:13:25 -0500
Date: Tue, 9 Mar 2004 11:13:23 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] (10/14) irlap symbol exports
Message-ID: <20040309191323.GK14543@bougret.hpl.hp.com>
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

ir264_irsyms_10_irlap.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(10/14) irlap symbol exports   

Move irlap exports out of irsyms



diff -u -p -r linux/net/irda.s9/irlap.c linux/net/irda/irlap.c
--- linux/net/irda.s9/irlap.c	Wed Dec 17 18:59:39 2003
+++ linux/net/irda/irlap.c	Mon Mar  8 19:18:01 2004
@@ -37,6 +37,7 @@
 #include <linux/proc_fs.h>
 #include <linux/init.h>
 #include <linux/random.h>
+#include <linux/module.h>
 #include <linux/seq_file.h>
 
 #include <net/irda/irda.h>
@@ -173,6 +174,7 @@ struct irlap_cb *irlap_open(struct net_d
 
 	return self;
 }
+EXPORT_SYMBOL(irlap_open);
 
 /*
  * Function __irlap_close (self)
@@ -233,6 +235,7 @@ void irlap_close(struct irlap_cb *self)
 	}
 	__irlap_close(lap);
 }
+EXPORT_SYMBOL(irlap_close);
 
 /*
  * Function irlap_connect_indication (self, skb)
diff -u -p -r linux/net/irda.s9/irsyms.c linux/net/irda/irsyms.c
--- linux/net/irda.s9/irsyms.c	Mon Mar  8 19:15:41 2004
+++ linux/net/irda/irsyms.c	Mon Mar  8 19:18:01 2004
@@ -80,8 +80,6 @@ EXPORT_SYMBOL(irda_param_pack);
 EXPORT_SYMBOL(irda_param_unpack);
 
 /* IrLAP */
-EXPORT_SYMBOL(irlap_open);
-EXPORT_SYMBOL(irlap_close);
 EXPORT_SYMBOL(irda_init_max_qos_capabilies);
 EXPORT_SYMBOL(irda_qos_bits_to_value);
 EXPORT_SYMBOL(irda_device_setup);
