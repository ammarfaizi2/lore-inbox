Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263224AbUJ2Ams@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263224AbUJ2Ams (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263278AbUJ2Al0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:41:26 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38406 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263216AbUJ2AVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:21:44 -0400
Date: Fri, 29 Oct 2004 02:21:13 +0200
From: Adrian Bunk <bunk@stusta.de>
To: coreteam@netfilter.org, Marc Boucher <marc@mbsi.ca>
Cc: netfilter-devel@lists.netfilter.org, davem@davemloft.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] netfilter/ipt_tcpmss.c: remove an unused function
Message-ID: <20041029002113.GP29142@stusta.de>
References: <20041028230202.GV3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028230202.GV3207@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ this time without the problems due to a digital signature... ]

The patch below removes an unused function from 
net/ipv4/netfilter/ipt_tcpmss.c


diffstat output:
 net/ipv4/netfilter/ipt_tcpmss.c |   12 ------------
 1 files changed, 12 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/net/ipv4/netfilter/ipt_tcpmss.c.old	2004-10-28 23:51:17.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/net/ipv4/netfilter/ipt_tcpmss.c	2004-10-28 23:51:28.000000000 +0200
@@ -87,18 +87,6 @@
 			       info->invert, hotdrop);
 }
 
-static inline int find_syn_match(const struct ipt_entry_match *m)
-{
-	const struct ipt_tcp *tcpinfo = (const struct ipt_tcp *)m->data;
-
-	if (strcmp(m->u.kernel.match->name, "tcp") == 0
-	    && (tcpinfo->flg_cmp & TH_SYN)
-	    && !(tcpinfo->invflags & IPT_TCP_INV_FLAGS))
-		return 1;
-
-	return 0;
-}
-
 static int
 checkentry(const char *tablename,
            const struct ipt_ip *ip,
