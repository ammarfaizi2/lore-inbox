Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbUJYAOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbUJYAOt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 20:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUJYANc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 20:13:32 -0400
Received: from [203.2.177.22] ([203.2.177.22]:264 "EHLO pinot.tusc.com.au")
	by vger.kernel.org with ESMTP id S261641AbUJYAMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 20:12:54 -0400
Subject: [PATCH TRIVIAL 2.6.8.1] ethertap debug no newline
From: Andrew Hendry <ahendry@tusc.com.au>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Content-Type: text/plain
Message-Id: <1098663052.3099.168.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 25 Oct 2004 10:10:52 +1000
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Oct 2004 00:13:31.0702 (UTC) FILETIME=[75DB6560:01C4BA27]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

very trivial, pretty debug.

Signed-off-by: Andrew Hendry <ahendry@tusc.com.au>

diff -up linux-2.6.8.1/drivers/net/ethertap.c.orig
linux-2.6.8.1/drivers/net/ethertap.c
--- linux-2.6.8.1/drivers/net/ethertap.c.orig   2004-10-25
09:38:05.460813120 +1000
+++ linux-2.6.8.1/drivers/net/ethertap.c        2004-10-25
09:38:47.337446904 +1000
@@ -124,7 +124,7 @@ static int ethertap_open(struct net_devi
        struct net_local *lp = netdev_priv(dev);
  
        if (ethertap_debug > 2)
-               printk(KERN_DEBUG "%s: Doing ethertap_open()...",
dev->name);
+               printk(KERN_DEBUG "%s: Doing ethertap_open()...\n",
dev->name);
  
        lp->nl = netlink_kernel_create(dev->base_addr, ethertap_rx);
        if (lp->nl == NULL)

