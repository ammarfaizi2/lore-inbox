Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVLMQiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVLMQiN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 11:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVLMQiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 11:38:12 -0500
Received: from havoc.gtf.org ([69.61.125.42]:36740 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932390AbVLMQiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 11:38:08 -0500
Date: Tue, 13 Dec 2005 11:37:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patch] net driver build fix
Message-ID: <20051213163759.GA23530@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/skge.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Jeff Garzik:
      [netdrvr skge] fix build

diff --git a/drivers/net/skge.c b/drivers/net/skge.c
index 8b6e2a1..00d6830 100644
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -2280,7 +2280,7 @@ static int skge_xmit_frame(struct sk_buf
  	}
 
 	if (unlikely(skge->tx_avail < skb_shinfo(skb)->nr_frags +1)) {
-		if (!netif_stopped(dev)) {
+		if (!netif_queue_stopped(dev)) {
 			netif_stop_queue(dev);
 
 			printk(KERN_WARNING PFX "%s: ring full when queue awake!\n",
