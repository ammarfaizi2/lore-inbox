Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751702AbWCBXL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbWCBXL1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWCBXJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:09:58 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:23984 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751290AbWCBXJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:09:48 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH 7/9] IRDA: adjust pnp_register_driver signature
Date: Thu, 2 Mar 2006 16:09:46 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Jean Tourrilhes <jt@hpl.hp.com>, irda-users@lists.sourceforge.net
References: <200603021601.27467.bjorn.helgaas@hp.com>
In-Reply-To: <200603021601.27467.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021609.46954.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that pnp_register_driver() returns the number of
devices claimed.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/drivers/net/irda/nsc-ircc.c
===================================================================
--- work-mm4.orig/drivers/net/irda/nsc-ircc.c	2006-02-22 09:55:50.000000000 -0700
+++ work-mm4/drivers/net/irda/nsc-ircc.c	2006-02-22 10:06:53.000000000 -0700
@@ -207,7 +207,7 @@
  	/* Register with PnP subsystem to detect disable ports */
 	ret = pnp_register_driver(&nsc_ircc_pnp_driver);
 
- 	if (ret >= 0)
+ 	if (!ret)
  		pnp_registered = 1;
 
 	ret = -ENODEV;
