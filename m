Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUCITFE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbUCITFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:05:03 -0500
Received: from palrel10.hp.com ([156.153.255.245]:22195 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262103AbUCITEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:04:36 -0500
Date: Tue, 9 Mar 2004 11:04:35 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] (2/14) flush old irtty exports
Message-ID: <20040309190435.GC14543@bougret.hpl.hp.com>
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

(2/14) flush old irtty exports   

These irtty symbols were exported but never used!


diff -u -p -r linux/net/irda.s1/irsyms.c linux/net/irda/irsyms.c
--- linux/net/irda.s1/irsyms.c	Mon Mar  8 18:47:07 2004
+++ linux/net/irda/irsyms.c	Mon Mar  8 18:53:59 2004
@@ -165,13 +165,6 @@ EXPORT_SYMBOL(irda_calc_crc16);
 EXPORT_SYMBOL(irda_crc16_table);
 EXPORT_SYMBOL(irda_start_timer);
 
-#ifdef CONFIG_IRTTY
-EXPORT_SYMBOL(irtty_set_dtr_rts);
-EXPORT_SYMBOL(irtty_register_dongle);
-EXPORT_SYMBOL(irtty_unregister_dongle);
-EXPORT_SYMBOL(irtty_set_packet_mode);
-#endif
-
 #ifdef CONFIG_IRDA_DEBUG
 __u32 irda_debug = IRDA_DEBUG_LEVEL;
 #endif
