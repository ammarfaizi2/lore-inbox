Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267097AbSK2QO1>; Fri, 29 Nov 2002 11:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267098AbSK2QO1>; Fri, 29 Nov 2002 11:14:27 -0500
Received: from boden.synopsys.com ([204.176.20.19]:35502 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S267097AbSK2QO0>; Fri, 29 Nov 2002 11:14:26 -0500
Date: Fri, 29 Nov 2002 17:21:36 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Netfilter Coreteam <coreteam@netfilter.org>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: circular dependency in netfilter headers (ip_conntrack.h)
Message-ID: <20021129162136.GB26745@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gmake[2]: Circular /export/home/riesen-pc0/riesen/compile/v2.4.20/include/linux/netfilter_ipv4/ip_conntrack_helper.h <- /export/home/riesen-pc0/riesen/compile/v2.4.20/include/linux/netfilter_ipv4/ip_conntrack.h dependency dropped.


I remember someone fixing it, but couldn't find the patch.
FWIW:

--- 2.4.20/include/linux/netfilter_ipv4/ip_conntrack.h	2002-08-13 06:01:49.000000000 +0200
+++ 2.4.20+/include/linux/netfilter_ipv4/ip_conntrack.h	2002-11-29 17:09:16.000000000 +0100
@@ -148,7 +148,8 @@ struct ip_conntrack_expect
 	union ip_conntrack_expect_help help;
 };
 
-#include <linux/netfilter_ipv4/ip_conntrack_helper.h>
+struct ip_conntrack_helper;
+
 struct ip_conntrack
 {
 	/* Usage count in here is 1 for hash table/destruct timer, 1 per skb,
