Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbVICB2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbVICB2k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 21:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVICB2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 21:28:40 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35853 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751355AbVICB2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 21:28:39 -0400
Date: Sat, 3 Sep 2005 03:28:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: coreteam@netfilter.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/netfilter/nfnetlink*: make functions static
Message-ID: <20050903012829.GF3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes needlessly global functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 net/netfilter/nfnetlink.c       |    4 ++--
 net/netfilter/nfnetlink_queue.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.13-mm1-full/net/netfilter/nfnetlink.c.old	2005-09-03 02:26:18.000000000 +0200
+++ linux-2.6.13-mm1-full/net/netfilter/nfnetlink.c	2005-09-03 02:27:21.000000000 +0200
@@ -344,14 +344,14 @@
 	} while(nfnl && nfnl->sk_receive_queue.qlen);
 }
 
-void __exit nfnetlink_exit(void)
+static void __exit nfnetlink_exit(void)
 {
 	printk("Removing netfilter NETLINK layer.\n");
 	sock_release(nfnl->sk_socket);
 	return;
 }
 
-int __init nfnetlink_init(void)
+static int __init nfnetlink_init(void)
 {
 	printk("Netfilter messages via NETLINK v%s.\n", nfversion);
 
--- linux-2.6.13-mm1-full/net/netfilter/nfnetlink_queue.c.old	2005-09-03 02:26:55.000000000 +0200
+++ linux-2.6.13-mm1-full/net/netfilter/nfnetlink_queue.c	2005-09-03 02:27:06.000000000 +0200
@@ -76,7 +76,7 @@
 
 static DEFINE_RWLOCK(instances_lock);
 
-u_int64_t htonll(u_int64_t in)
+static u_int64_t htonll(u_int64_t in)
 {
 	u_int64_t out;
 	int i;

