Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262939AbUJ1XGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbUJ1XGk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbUJ1XDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:03:21 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38161 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263013AbUJ1XCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:02:37 -0400
Date: Fri, 29 Oct 2004 01:02:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: coreteam@netfilter.org, Marc Boucher <marc@mbsi.ca>
Cc: netfilter-devel@lists.netfilter.org, davem@davemloft.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] netfilter/ipt_tcpmss.c: remove an unused function
Message-ID: <20041028230202.GV3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unused function from 
net/ipv4/netfilter/ipt_tcpmss.c


diffstat output:
 net/ipv4/netfilter/ipt_tcpmss.c |   12 ------------
 1 files changed, 12 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/net/ipv4/netfilter/ipt_tcpmss.c.old	2004-10-28 23:51:17.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/net/ipv4/netfilter/ipt_tcpmss.c	2004-10-28 23:51:28.000000000 +0200
@@ -87,18 +87,6 @@
 			       info->invert, hotdrop);
 }
 
- -static inline int find_syn_match(const struct ipt_entry_match *m)
- -{
- -	const struct ipt_tcp *tcpinfo = (const struct ipt_tcp *)m->data;
- -
- -	if (strcmp(m->u.kernel.match->name, "tcp") == 0
- -	    && (tcpinfo->flg_cmp & TH_SYN)
- -	    && !(tcpinfo->invflags & IPT_TCP_INV_FLAGS))
- -		return 1;
- -
- -	return 0;
- -}
- -
 static int
 checkentry(const char *tablename,
            const struct ipt_ip *ip,

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgXpqmfzqmE8StAARAlfTAJ9tZB577aVYlmz3j91H4DvBkX4KMwCglbcK
xolcBq4HFXSsy8N9BZIJiW8=
=pbup
-----END PGP SIGNATURE-----
