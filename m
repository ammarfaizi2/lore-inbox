Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267259AbUJVOAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267259AbUJVOAs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 10:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269960AbUJVOAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 10:00:47 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55560 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S269958AbUJVN75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 09:59:57 -0400
Date: Fri, 22 Oct 2004 15:59:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, kkeil@suse.de, kai.germaschewski@gmx.de
Cc: linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de
Subject: [patch] 2.6.9-mm1: ISDN hisax_fcpcipnp.c: kill unused variable
Message-ID: <20041022135924.GD2831@stusta.de>
References: <20041022032039.730eb226.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022032039.730eb226.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following compile warning comes from Linus' tree:

<--  snip  -->

...
  CC      drivers/isdn/hisax/hisax_fcpcipnp.o
...
drivers/isdn/hisax/hisax_fcpcipnp.c: In function `hisax_fcpcipnp_init':
drivers/isdn/hisax/hisax_fcpcipnp.c:999: warning: unused variable `pci_nr_found'
...

<--  snip  -->


Since all uses of this variable were removed, I'd suggest the patch 
below to remove the variable itself.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.9-mm1-full/drivers/isdn/hisax/hisax_fcpcipnp.c.old	2004-10-22 15:53:46.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/isdn/hisax/hisax_fcpcipnp.c	2004-10-22 15:55:02.000000000 +0200
@@ -996,7 +996,7 @@
 
 static int __init hisax_fcpcipnp_init(void)
 {
-	int retval, pci_nr_found;
+	int retval;
 
 	printk(KERN_INFO "hisax_fcpcipnp: Fritz!Card PCI/PCIv2/PnP ISDN driver v0.0.1\n");
 

