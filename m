Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVCKVY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVCKVY3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 16:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVCKVY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 16:24:28 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:22540 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261529AbVCKVX6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 16:23:58 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: kaber@trash.net (Patrick McHardy)
Subject: Re: Last night Linus bk - netfilter busted?
Cc: davem@davemloft.net, dtor_core@ameritech.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Organization: Core
In-Reply-To: <4232044E.8030001@trash.net>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1D9rZX-0004KE-00@gondolin.me.apana.org.au>
Date: Sat, 12 Mar 2005 08:21:28 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy <kaber@trash.net> wrote:
> 
> You're right, good catch. IPT_RETURN is interpreted internally by
> ip_tables, but since the value changed it isn't recognized by ip_tables
> anymore and returned to nf_iterate() as NF_REPEAT. This patch restores
> the old value.

Please fix netfilter_arp while you're at it since it does exactly
the same thing.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
