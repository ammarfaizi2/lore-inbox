Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933606AbWK2E5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933606AbWK2E5L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 23:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933600AbWK2E5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 23:57:11 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:47886 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S933397AbWK2E5K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 23:57:10 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: davem@davemloft.net (David Miller)
Subject: Re: Broken commit: [NETFILTER]: ipt_REJECT: remove largely duplicate route_reverse function
Cc: herbert@gondor.apana.org.au, kaber@trash.net, khc@pm.waw.pl,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org
Organization: Core
In-Reply-To: <20061128.204440.39160464.davem@davemloft.net>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev,apana.lists.os.linux.netfilter.devel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1GpHVB-0005CB-00@gondolin.me.apana.org.au>
Date: Wed, 29 Nov 2006 15:56:57 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> wrote:
> 
> Longer term this is really messy, we should handle this some
> other way.

Definitely.  I'm not sure whether 48 is enough even for recursive
tunnels.  This should really just be a hint.  It's OK to spend a
bit of time reallocating skb's if it's too small, but it's not OK
to die.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
