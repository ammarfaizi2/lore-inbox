Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbUC1Wi0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 17:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbUC1Wi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 17:38:26 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:24332 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262454AbUC1WiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 17:38:21 -0500
Date: Mon, 29 Mar 2004 00:38:05 +0200
From: Willy TARREAU <willy@w.ods.org>
To: "David S. Miller" <davem@redhat.com>
Cc: petero2@telia.com, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: [PATCH-2.4.26] ip6tables cleanup
Message-ID: <20040328223805.GA27147@pcw.home.local>
References: <20040328042608.GA17969@logos.cnet> <20040328115439.GA24421@pcw.home.local> <m2d66wsrg2.fsf@p4.localdomain> <20040328200932.GA19852@pcw.home.local> <20040328123318.63c54ee8.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328123318.63c54ee8.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

I sent last one too quickly, it needs this one to compile :

diff -urN linux-2.4.26-rc1/include/net/ipv6.h linux-2.4.26-rc1-ipv6/include/net/ipv6.h
--- linux-2.4.26-rc1/include/net/ipv6.h	Mon Mar 29 00:18:38 2004
+++ linux-2.4.26-rc1-ipv6/include/net/ipv6.h	Mon Mar 29 00:36:39 2004
@@ -321,8 +321,8 @@
 						    struct ipv6_txoptions *opt,
 						    u8 *proto);
 
-extern int			ipv6_skip_exthdr(struct sk_buff *, int start,
-					         u8 *nexthdrp, int len);
+extern int			ipv6_skip_exthdr(const struct sk_buff *,
+					int start, u8 *nexthdrp, int len);
 
 extern int 			ipv6_ext_hdr(u8 nexthdr);
 

Sorry for the noise,
Willy

