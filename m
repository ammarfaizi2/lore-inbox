Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSIACBM>; Sat, 31 Aug 2002 22:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSIACBM>; Sat, 31 Aug 2002 22:01:12 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:35857 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S314078AbSIACBM>; Sat, 31 Aug 2002 22:01:12 -0400
Date: Sun, 1 Sep 2002 12:05:13 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: "David S. Miller" <davem@redhat.com>, <kuznet@ms2.inr.ac.ru>
cc: netdev@oss.sgi.com, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipv6 compile fix, __FUNCTION__ pasting, 2.5.33
Message-ID: <Mutt.LNX.4.44.0209011201440.13950-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another __FUNCTION__ pasting fix, for 2.5.33.

- James
-- 
James Morris
<jmorris@intercode.com.au>

diff -urN -X dontdiff linux-2.5.33.orig/net/ipv6/af_inet6.c linux-2.5.33.w1/net/ipv6/af_inet6.c
--- linux-2.5.33.orig/net/ipv6/af_inet6.c	Sun Sep  1 11:34:46 2002
+++ linux-2.5.33.w1/net/ipv6/af_inet6.c	Sun Sep  1 12:00:07 2002
@@ -663,8 +663,8 @@
 					   sizeof(struct raw6_sock), 0,
                                            SLAB_HWCACHE_ALIGN, 0, 0);
         if (!tcp6_sk_cachep || !udp6_sk_cachep || !raw6_sk_cachep)
-                printk(KERN_CRIT __FUNCTION__
-                        ": Can't create protocol sock SLAB caches!\n");
+                printk(KERN_CRIT "%s: Can't create protocol sock SLAB "
+                       "caches!\n", __FUNCTION__);
 
 	/* Register the socket-side information for inet6_create.  */
 	for(r = &inetsw6[0]; r < &inetsw6[SOCK_MAX]; ++r)

