Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbTAQVkQ>; Fri, 17 Jan 2003 16:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbTAQVkQ>; Fri, 17 Jan 2003 16:40:16 -0500
Received: from air-2.osdl.org ([65.172.181.6]:38274 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261594AbTAQVkO>;
	Fri, 17 Jan 2003 16:40:14 -0500
Date: Fri, 17 Jan 2003 13:48:58 -0800
From: Bob Miller <rem@osdl.org>
To: coreteam@netfilter.org
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [Trivial 2.5.58] Remove compile warning from net/ipv4/netfilter/ip_nat_helper.c
Message-ID: <20030117214858.GC22540@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Delete an un-used stack variable.

diff -Nru a/net/ipv4/netfilter/ip_nat_helper.c b/net/ipv4/netfilter/ip_nat_helper.c
--- a/net/ipv4/netfilter/ip_nat_helper.c	Thu Jan 16 14:06:04 2003
+++ b/net/ipv4/netfilter/ip_nat_helper.c	Thu Jan 16 14:06:04 2003
@@ -84,7 +84,6 @@
 	iph = (*skb)->nh.iph;
 	if (iph->protocol == IPPROTO_TCP) {
 		struct tcphdr *tcph = (void *)iph + iph->ihl*4;
-		void *data = (void *)tcph + tcph->doff*4;
 
 		DEBUGP("ip_nat_resize_packet: Seq_offset before: ");
 		DUMP_OFFSET(this_way);
-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
