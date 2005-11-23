Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbVKWAiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbVKWAiK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 19:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbVKWAiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 19:38:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61714 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030277AbVKWAiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 19:38:07 -0500
Date: Wed, 23 Nov 2005 01:38:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/ipv4/: make two functions static
Message-ID: <20051123003806.GD3963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 net/ipv4/ip_gre.c    |    2 +-
 net/ipv4/ip_output.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc1-mm2-full/net/ipv4/ip_output.c.old	2005-11-22 22:51:16.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/net/ipv4/ip_output.c	2005-11-22 22:51:29.000000000 +0100
@@ -690,7 +690,7 @@
 	return csum;
 }
 
-inline int ip_ufo_append_data(struct sock *sk,
+static inline int ip_ufo_append_data(struct sock *sk,
 			int getfrag(void *from, char *to, int offset, int len,
 			       int odd, struct sk_buff *skb),
 			void *from, int length, int hh_len, int fragheaderlen,
--- linux-2.6.15-rc1-mm2-full/net/ipv4/ip_gre.c.old	2005-11-22 22:59:32.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/net/ipv4/ip_gre.c	2005-11-22 22:59:45.000000000 +0100
@@ -1217,7 +1217,7 @@
 	return 0;
 }
 
-int __init ipgre_fb_tunnel_init(struct net_device *dev)
+static int __init ipgre_fb_tunnel_init(struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = (struct ip_tunnel*)dev->priv;
 	struct iphdr *iph = &tunnel->parms.iph;

