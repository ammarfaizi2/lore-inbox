Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTFSXrm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 19:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbTFSXrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 19:47:42 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:12247 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261939AbTFSXrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 19:47:40 -0400
Date: Fri, 20 Jun 2003 02:01:38 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: frible@teaser.fr
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [2.5 patch] yam.c: return IRQ_NONE in error case
Message-ID: <20030620000137.GG29247@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please check whether the following patch to return IRQ_NONE in case of
errors is correct:

--- linux-2.5.72-mm2/drivers/net/hamradio/yam.c.old	2003-06-20 01:57:02.000000000 +0200
+++ linux-2.5.72-mm2/drivers/net/hamradio/yam.c	2003-06-20 01:57:41.000000000 +0200
@@ -742,7 +742,7 @@
 
 			if (--counter <= 0) {
 				printk(KERN_ERR "%s: too many irq iir=%d\n", dev->name, iir);
-				return;
+				return IRQ_NONE;
 			}
 			if (msr & TX_RDY) {
 				++yp->nb_mdint;


TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

