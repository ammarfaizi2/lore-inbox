Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265469AbSJSByv>; Fri, 18 Oct 2002 21:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbSJSByu>; Fri, 18 Oct 2002 21:54:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6093 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265469AbSJSByi>;
	Fri, 18 Oct 2002 21:54:38 -0400
Date: Fri, 18 Oct 2002 18:52:58 -0700 (PDT)
Message-Id: <20021018.185258.27026815.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Sevaral MLD Fixes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021018.125223.130322644.yoshfuji@linux-ipv6.org>
References: <20021018.125223.130322644.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had to add the following to my tree after this patch,
please watch for compiler warnings introducted by your
changes.   Thanks :-)

--- net/ipv6/mcast.c.~1~	Fri Oct 18 18:55:04 2002
+++ net/ipv6/mcast.c	Fri Oct 18 18:55:16 2002
@@ -605,8 +605,6 @@
 
 static void igmp6_leave_group(struct ifmcaddr6 *ma)
 {
-	int addr_type;
-
 	if (IPV6_ADDR_MC_SCOPE(&ma->mca_addr) < IPV6_ADDR_SCOPE_LINKLOCAL ||
 	    ipv6_addr_is_ll_all_nodes(&ma->mca_addr))
 		return;
