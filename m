Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWAQSkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWAQSkH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWAQSkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:40:07 -0500
Received: from [81.2.110.250] ([81.2.110.250]:54956 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932345AbWAQSkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:40:06 -0500
Subject: PATCH: cassini printk format warning
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, asun@darksunrising.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Jan 2006 18:39:34 +0000
Message-Id: <1137523175.14135.84.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

compwb is u64, %lx is not u64.

Signed-off-by: Alan Cox <alan@redhat.com>

--- linux.vanilla-2.6.16-rc1/drivers/net/cassini.c	2006-01-17 15:36:31.000000000 +0000
+++ linux-2.6.16-rc1/drivers/net/cassini.c	2006-01-17 18:23:50.398383416 +0000
@@ -1925,7 +1925,7 @@
 	u64 compwb = le64_to_cpu(cp->init_block->tx_compwb);
 #endif
 	if (netif_msg_intr(cp))
-		printk(KERN_DEBUG "%s: tx interrupt, status: 0x%x, %lx\n",
+		printk(KERN_DEBUG "%s: tx interrupt, status: 0x%x, %llx\n",
 			cp->dev->name, status, compwb);
 	/* process all the rings */
 	for (ring = 0; ring < N_TX_RINGS; ring++) {

