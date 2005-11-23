Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbVKWBYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbVKWBYE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 20:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbVKWBYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 20:24:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10259 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030302AbVKWBYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 20:24:01 -0500
Date: Wed, 23 Nov 2005 02:23:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/ipv6/: make two functions static
Message-ID: <20051123012359.GH3963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 net/ipv6/ip6_output.c    |    3 ++-
 net/ipv6/ipv6_sockglue.c |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

--- linux-2.6.15-rc1-mm2-full/net/ipv6/ip6_output.c.old	2005-11-23 02:10:08.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/net/ipv6/ip6_output.c	2005-11-23 02:10:25.000000000 +0100
@@ -774,7 +774,8 @@
 	*dst = NULL;
 	return err;
 }
-inline int ip6_ufo_append_data(struct sock *sk,
+
+static inline int ip6_ufo_append_data(struct sock *sk,
 			int getfrag(void *from, char *to, int offset, int len,
 			int odd, struct sk_buff *skb),
 			void *from, int length, int hh_len, int fragheaderlen,
--- linux-2.6.15-rc1-mm2-full/net/ipv6/ipv6_sockglue.c.old	2005-11-23 02:10:43.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/net/ipv6/ipv6_sockglue.c	2005-11-23 02:11:02.000000000 +0100
@@ -628,8 +628,8 @@
 	return -EINVAL;
 }
 
-int ipv6_getsockopt_sticky(struct sock *sk, struct ipv6_opt_hdr *hdr,
-			   char __user *optval, int len)
+static int ipv6_getsockopt_sticky(struct sock *sk, struct ipv6_opt_hdr *hdr,
+				  char __user *optval, int len)
 {
 	if (!hdr)
 		return 0;

