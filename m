Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318016AbSHCWaX>; Sat, 3 Aug 2002 18:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318008AbSHCW3N>; Sat, 3 Aug 2002 18:29:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61201 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318016AbSHCW2O>; Sat, 3 Aug 2002 18:28:14 -0400
To: <netfilter@lists.samba.org>
CC: <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 13: 2.5.29-ip6tables
Message-Id: <E17b7R2-0007aI-00@flint.arm.linux.org.uk>
Date: Sat, 03 Aug 2002 23:31:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has been verified to apply cleanly to 2.5.30

This patch is something I've been carrying around in the -rmk patch for
a while; I'm going to be dropping it out shortly.  If someone wants it,
that's fine by me.  If not, its about to find its way to patch heaven.

 net/ipv6/netfilter/ip6_tables.c |    2 +-
 1 files changed, 1 insertion, 1 deletion

diff -urN orig/net/ipv6/netfilter/ip6_tables.c linux/net/ipv6/netfilter/ip6_tables.c
--- orig/net/ipv6/netfilter/ip6_tables.c	Sat Jul  6 17:36:42 2002
+++ linux/net/ipv6/netfilter/ip6_tables.c	Sat Jun 22 01:04:05 2002
@@ -742,7 +742,7 @@
 	t = ip6t_get_target(e);
 	target = find_target_lock(t->u.user.name, &ret, &ip6t_mutex);
 	if (!target) {
-	  //		duprintf("check_entry: `%s' not found\n", t->u.name);
+		duprintf("check_entry: `%s' not found\n", t->u.user.name);
 		goto cleanup_matches;
 	}
 	if (target->me)

