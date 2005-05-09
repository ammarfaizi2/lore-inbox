Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263029AbVEIDFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263029AbVEIDFN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 23:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263030AbVEIDFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 23:05:13 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:25102 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263029AbVEIDFI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 23:05:08 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: pizza@shaftnet.org (Stuffed Crust)
Subject: Re: [PATCH] fix long-standing bug in 2.6/2.4 skb_copy/skb_copy_expand
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Organization: Core
In-Reply-To: <20050508143259.GA30676@shaftnet.org>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DUyZO-0004Fp-00@gondolin.me.apana.org.au>
Date: Mon, 09 May 2005 13:04:34 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuffed Crust <pizza@shaftnet.org> wrote:
> 
> This is, fortunately, generally true.  But if the alloc_skb function 
> allocates extra head room (ie calls skb_reserve() on the skb before it 
> passes it to the callee, this doesn't quite work.  Instead, it should be 
> rewritten as:

As far as I know the alloc_skb funciton in the kernel tree doesn't do
that so your patch is not necessary unless we decide to change the way
alloc_skb works.  If that's what you want then please provide a patch
to alloc_skb and a rationale as to why we should do that.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
