Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbWHHTgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWHHTgw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbWHHTfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:35:15 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:34580 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030237AbWHHTfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:35:02 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Tue, 08 Aug 2006 21:34:25 +0200
Message-Id: <20060808193425.1396.92110.sendpatchset@lappy>
In-Reply-To: <20060808193325.1396.58813.sendpatchset@lappy>
References: <20060808193325.1396.58813.sendpatchset@lappy>
Subject: [RFC][PATCH 6/9] tg3 driver conversion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Update the driver to make use of the NETIF_F_MEMALLOC feature.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Daniel Phillips <phillips@google.com>

---
 drivers/net/tg3.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/drivers/net/tg3.c
===================================================================
--- linux-2.6.orig/drivers/net/tg3.c
+++ linux-2.6/drivers/net/tg3.c
@@ -11643,6 +11643,8 @@ static int __devinit tg3_init_one(struct
 	 */
 	pci_save_state(tp->pdev);
 
+	dev->features |= NETIF_F_MEMALLOC;
+
 	err = register_netdev(dev);
 	if (err) {
 		printk(KERN_ERR PFX "Cannot register net device, "
