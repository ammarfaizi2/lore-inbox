Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbUCITWI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbUCITR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:17:27 -0500
Received: from palrel12.hp.com ([156.153.255.237]:56550 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262129AbUCITPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:15:16 -0500
Date: Tue, 9 Mar 2004 11:15:14 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] (13/14) irda_param symbol exports
Message-ID: <20040309191514.GN14543@bougret.hpl.hp.com>
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

ir264_irsyms_13_param.diff :
~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(13/14) irda_param symbol exports

Move irda_param related exports out of irsyms



diff -u -p -r linux/net/irda.sC/irsyms.c linux/net/irda/irsyms.c
--- linux/net/irda.sC/irsyms.c	Mon Mar  8 19:23:23 2004
+++ linux/net/irda/irsyms.c	Mon Mar  8 19:24:58 2004
@@ -73,11 +73,6 @@ extern int  irlap_driver_rcv(struct sk_b
 EXPORT_SYMBOL(irda_debug);
 #endif
 EXPORT_SYMBOL(irda_notify_init);
-EXPORT_SYMBOL(irda_param_insert);
-EXPORT_SYMBOL(irda_param_extract);
-EXPORT_SYMBOL(irda_param_extract_all);
-EXPORT_SYMBOL(irda_param_pack);
-EXPORT_SYMBOL(irda_param_unpack);
 
 /* IrLAP */
 
diff -u -p -r linux/net/irda.sC/parameters.c linux/net/irda/parameters.c
--- linux/net/irda.sC/parameters.c	Wed Dec 17 18:59:05 2003
+++ linux/net/irda/parameters.c	Mon Mar  8 19:24:58 2004
@@ -29,6 +29,8 @@
  ********************************************************************/
 
 #include <linux/types.h>
+#include <linux/module.h>
+
 #include <asm/unaligned.h>
 #include <asm/byteorder.h>
 
@@ -393,6 +395,7 @@ int irda_param_pack(__u8 *buf, char *fmt
 
 	return 0;
 }
+EXPORT_SYMBOL(irda_param_pack);
 
 /*
  * Function irda_param_unpack (skb, fmt, ...)
@@ -437,6 +440,7 @@ int irda_param_unpack(__u8 *buf, char *f
 
 	return 0;
 }
+EXPORT_SYMBOL(irda_param_unpack);
 
 /*
  * Function irda_param_insert (self, pi, buf, len, info)
@@ -489,6 +493,7 @@ int irda_param_insert(void *self, __u8 p
 						 pi_minor_info->func);
 	return ret;
 }
+EXPORT_SYMBOL(irda_param_insert);
 
 /*
  * Function irda_param_extract_all (self, buf, len, info)
@@ -544,6 +549,7 @@ int irda_param_extract(void *self, __u8 
 						  type, pi_minor_info->func);
 	return ret;
 }
+EXPORT_SYMBOL(irda_param_extract);
 
 /*
  * Function irda_param_extract_all (self, buf, len, info)
@@ -575,4 +581,4 @@ int irda_param_extract_all(void *self, _
 	}
 	return n;
 }
-
+EXPORT_SYMBOL(irda_param_extract_all);
