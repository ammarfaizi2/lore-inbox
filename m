Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270273AbUJTBNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270273AbUJTBNv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270261AbUJTBJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 21:09:06 -0400
Received: from palrel13.hp.com ([156.153.255.238]:22194 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S269536AbUJTBGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 21:06:50 -0400
Date: Tue, 19 Oct 2004 18:06:49 -0700
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] Debug module param
Message-ID: <20041020010649.GI12932@bougret.hpl.hp.com>
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

irXXX_debug_mod_parm.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [CORRECT] irda 2.6 - fix module info
The module parameter info for irda is incorrect.
The debug parameter is named "debug", the variable is irda_debug.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>

diff -Nru a/net/irda/irmod.c b/net/irda/irmod.c
--- a/net/irda/irmod.c	2004-10-08 10:48:24 -07:00
+++ b/net/irda/irmod.c	2004-10-08 10:48:24 -07:00
@@ -62,7 +62,7 @@
 #ifdef CONFIG_IRDA_DEBUG
 unsigned int irda_debug = IRDA_DEBUG_LEVEL;
 module_param_named(debug, irda_debug, uint, 0);
-MODULE_PARM_DESC(irda_debug, "IRDA debugging level");
+MODULE_PARM_DESC(debug, "IRDA debugging level");
 EXPORT_SYMBOL(irda_debug);
 #endif
 
