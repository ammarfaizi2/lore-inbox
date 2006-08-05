Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422821AbWHEKdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422821AbWHEKdY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 06:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422820AbWHEKdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 06:33:24 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:62732 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1422821AbWHEKdX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 06:33:23 -0400
Date: Sat, 5 Aug 2006 20:33:07 +1000
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       Chris Leech <chris.leech@gmail.com>, arnd@arndnet.de, olel@ans.pl,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: problems with e1000 and jumboframes
Message-ID: <20060805103307.GB21184@gondor.apana.org.au>
References: <41b516cb0608031334s6e159e99tb749240f44ae608d@mail.gmail.com> <E1G8sif-0003oY-00@gondolin.me.apana.org.au> <20060804061513.GB413@2ka.mipt.ru> <41b516cb0608040834o1d433f23v2f2ba1a1b05ccbc6@mail.gmail.com> <20060804194209.GA25167@2ka.mipt.ru> <4807377b0608041402p10149bfbrd9e5f3b8849d3f56@mail.gmail.com> <20060805095846.GA17867@2ka.mipt.ru> <20060805100954.GB20939@gondor.apana.org.au> <20060805102435.GA15740@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060805102435.GA15740@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 02:24:36PM +0400, Evgeniy Polyakov wrote:
>
> > If we had a flag to indicate writability we could also have a flag to
> > indicate that the memory comes from kmalloc rather than alloc_page.
> 
> Yes, that would be good, but who will give us a bit in the struct page?
> Can we recreate frag_list elements to be a bitmasks and steal couple
> of them there, so we would not increase fragment's structure size?

I wasn't thinking of a bit in struct page, but rather a bit in skb_frag_t.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
