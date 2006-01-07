Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWAGSRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWAGSRZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 13:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752573AbWAGSRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 13:17:25 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35589 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750935AbWAGSRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 13:17:24 -0500
Date: Sat, 7 Jan 2006 19:17:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/ipv6/: small cleanups
Message-ID: <20060107181723.GP3774@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- addrconf.c: make addrconf_dad_stop() static
- inet6_connection_sock.c should #include <net/inet6_connection_sock.h>
  for getting the prototypes of it's global functions


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 net/ipv6/addrconf.c              |    2 +-
 net/ipv6/inet6_connection_sock.c |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.15-mm2-full/net/ipv6/addrconf.c.old	2006-01-07 17:30:04.000000000 +0100
+++ linux-2.6.15-mm2-full/net/ipv6/addrconf.c	2006-01-07 17:30:13.000000000 +0100
@@ -1228,7 +1228,7 @@
 
 /* Gets referenced address, destroys ifaddr */
 
-void addrconf_dad_stop(struct inet6_ifaddr *ifp)
+static void addrconf_dad_stop(struct inet6_ifaddr *ifp)
 {
 	if (ifp->flags&IFA_F_PERMANENT) {
 		spin_lock_bh(&ifp->lock);
--- linux-2.6.15-mm2-full/net/ipv6/inet6_connection_sock.c.old	2006-01-07 17:30:42.000000000 +0100
+++ linux-2.6.15-mm2-full/net/ipv6/inet6_connection_sock.c	2006-01-07 17:30:57.000000000 +0100
@@ -25,6 +25,7 @@
 #include <net/inet_hashtables.h>
 #include <net/ip6_route.h>
 #include <net/sock.h>
+#include <net/inet6_connection_sock.h>
 
 int inet6_csk_bind_conflict(const struct sock *sk,
 			    const struct inet_bind_bucket *tb)

