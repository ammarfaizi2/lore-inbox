Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbUCITWI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbUCITRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:17:13 -0500
Received: from palrel13.hp.com ([156.153.255.238]:45991 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262124AbUCITOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:14:47 -0500
Date: Tue, 9 Mar 2004 11:14:43 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] (12/14) qos symbol exports
Message-ID: <20040309191443.GM14543@bougret.hpl.hp.com>
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

ir264_irsyms_12_qos.diff :
~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(12/14) qos symbol exports

Move qos related exports out of irsyms


diff -u -p -r linux/net/irda.sB/irsyms.c linux/net/irda/irsyms.c
--- linux/net/irda.sB/irsyms.c	Mon Mar  8 19:20:34 2004
+++ linux/net/irda/irsyms.c	Mon Mar  8 19:23:23 2004
@@ -80,8 +80,6 @@ EXPORT_SYMBOL(irda_param_pack);
 EXPORT_SYMBOL(irda_param_unpack);
 
 /* IrLAP */
-EXPORT_SYMBOL(irda_init_max_qos_capabilies);
-EXPORT_SYMBOL(irda_qos_bits_to_value);
 
 
 #ifdef CONFIG_IRDA_DEBUG
diff -u -p -r linux/net/irda.sB/qos.c linux/net/irda/qos.c
--- linux/net/irda.sB/qos.c	Wed Dec 17 18:59:29 2003
+++ linux/net/irda/qos.c	Mon Mar  8 19:23:23 2004
@@ -336,6 +336,7 @@ void irda_init_max_qos_capabilies(struct
 	qos->link_disc_time.bits &= 0xff;
 	qos->additional_bofs.bits = 0xff;
 }
+EXPORT_SYMBOL(irda_init_max_qos_capabilies);
 
 /*
  * Function irlap_adjust_qos_settings (qos)
@@ -774,3 +775,4 @@ void irda_qos_bits_to_value(struct qos_i
 	index = msb_index(qos->additional_bofs.bits);
 	qos->additional_bofs.value = add_bofs[index];
 }
+EXPORT_SYMBOL(irda_qos_bits_to_value);
