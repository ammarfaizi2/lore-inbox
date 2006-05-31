Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWEaBSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWEaBSz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 21:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWEaBSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 21:18:54 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:32128 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751237AbWEaBSy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 21:18:54 -0400
Date: Tue, 30 May 2006 18:21:14 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Re: Linux 2.6.16.19
Message-ID: <20060531012114.GN18769@moss.sous-sol.org>
References: <20060531012035.GM18769@moss.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060531012035.GM18769@moss.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 2567664..bf2e152 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 16
-EXTRAVERSION = .18
+EXTRAVERSION = .19
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/net/ipv4/netfilter/ip_conntrack_core.c b/net/ipv4/netfilter/ip_conntrack_core.c
index 84c66db..43f6b45 100644
--- a/net/ipv4/netfilter/ip_conntrack_core.c
+++ b/net/ipv4/netfilter/ip_conntrack_core.c
@@ -1318,6 +1318,7 @@ getorigdst(struct sock *sk, int optval, 
 			.tuple.dst.u.tcp.port;
 		sin.sin_addr.s_addr = ct->tuplehash[IP_CT_DIR_ORIGINAL]
 			.tuple.dst.ip;
+		memset(sin.sin_zero, 0, sizeof(sin.sin_zero));
 
 		DEBUGP("SO_ORIGINAL_DST: %u.%u.%u.%u %u\n",
 		       NIPQUAD(sin.sin_addr.s_addr), ntohs(sin.sin_port));
diff --git a/net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c b/net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c
index 6c8624a..62a0f52 100644
--- a/net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c
+++ b/net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c
@@ -354,6 +354,7 @@ getorigdst(struct sock *sk, int optval, 
 			.tuple.dst.u.tcp.port;
 		sin.sin_addr.s_addr = ct->tuplehash[IP_CT_DIR_ORIGINAL]
 			.tuple.dst.u3.ip;
+		memset(sin.sin_zero, 0, sizeof(sin.sin_zero));
 
 		DEBUGP("SO_ORIGINAL_DST: %u.%u.%u.%u %u\n",
 		       NIPQUAD(sin.sin_addr.s_addr), ntohs(sin.sin_port));
