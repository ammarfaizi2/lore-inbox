Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263461AbVCEAnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbVCEAnx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbVCEAjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:39:15 -0500
Received: from palrel12.hp.com ([156.153.255.237]:25316 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263429AbVCEA3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:29:05 -0500
Date: Fri, 4 Mar 2005 16:28:53 -0800
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] support NSC PC8738x
Message-ID: <20050305002853.GG23895@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir261_nsc_38x.diff :
~~~~~~~~~~~~~~~~~~
		<Original patch from Steffen Pingel>
	o [FEATURE] support NSC PC8738x chipset (IBM x40 & ...)
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>


diff -u -p linux/drivers/net/irda/nsc-ircc.d0.c  linux/drivers/net/irda/nsc-ircc.c
--- linux/drivers/net/irda/nsc-ircc.d0.c	Fri Feb  4 16:17:07 2005
+++ linux/drivers/net/irda/nsc-ircc.c	Mon Feb  7 14:35:05 2005
@@ -94,16 +94,13 @@ static nsc_chip_t chips[] = {
 	  nsc_ircc_probe_108, nsc_ircc_init_108 },
 	{ "PC87338", { 0x398, 0x15c, 0x2e }, 0x08, 0xb0, 0xf8, 
 	  nsc_ircc_probe_338, nsc_ircc_init_338 },
+	/* Contributed by Steffen Pingel - IBM X40 */
+	{ "PC8738x", { 0x164e, 0x4e, 0x0 }, 0x20, 0xf4, 0xff,
+	  nsc_ircc_probe_39x, nsc_ircc_init_39x },
 	/* Contributed by Jan Frey - IBM A30/A31 */
 	{ "PC8739x", { 0x2e, 0x4e, 0x0 }, 0x20, 0xea, 0xff, 
 	  nsc_ircc_probe_39x, nsc_ircc_init_39x },
 	{ NULL }
-#if 0
-	/* Probably bogus, "PC8739x" should be the real thing. Jean II */
-	/* Contributed by Kevin Thayer - OmniBook 6100 */
-	{ "PC87338?", { 0x2e, 0x15c, 0x398 }, 0x08, 0x00, 0xf8, 
-	  nsc_ircc_probe_338, nsc_ircc_init_338 },
-#endif
 };
 
 /* Max 4 instances for now */
