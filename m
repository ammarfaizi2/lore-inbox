Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263266AbTIAVDT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 17:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263268AbTIAVDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 17:03:19 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54510 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263266AbTIAVDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 17:03:15 -0400
Date: Mon, 1 Sep 2003 23:03:07 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: isdn4linux@listserv.isdn4linux.de
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.6 patch] add a missing return to drivers/isdn/hisax/ipacx.c
Message-ID: <20030901210307.GE23729@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below adds a missing return to drivers/isdn/hisax/ipacx.c.

I've tested the compilation with 2.6.0-test4-mm4.

Please apply
Adrian

--- linux-2.6.0-test4-mm4-no-smp/drivers/isdn/hisax/ipacx.c.old	2003-09-01 22:59:28.000000000 +0200
+++ linux-2.6.0-test4-mm4-no-smp/drivers/isdn/hisax/ipacx.c	2003-09-01 22:59:49.000000000 +0200
@@ -728,13 +728,15 @@
 
 int
 ipacx_setup(struct IsdnCardState *cs, struct dc_hw_ops *ipacx_dc_ops,
 	    struct bc_hw_ops *ipacx_bc_ops)
 {
 	u8 val;
 
 	cs->dc_hw_ops = ipacx_dc_ops;
 	cs->bc_hw_ops = ipacx_bc_ops;
 	val = ipacx_read_reg(cs, IPACX_ID) & 0x3f;
 	printk(KERN_INFO "HiSax: IPACX Design Id: %#x\n", val);
+
+	return 0;
 }
 
