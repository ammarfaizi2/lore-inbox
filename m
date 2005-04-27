Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVD0Lgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVD0Lgk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 07:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVD0Lgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 07:36:40 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:18 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261419AbVD0Lgi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 07:36:38 -0400
Date: Wed, 27 Apr 2005 21:35:42 +1000
To: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Cc: Patrick McHardy <kaber@trash.net>, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, Yair@arx.com,
       linux-kernel@vger.kernel.org
Subject: Re: Re-routing packets via netfilter (ip_rt_bug)
Message-ID: <20050427113542.GB22433@gondor.apana.org.au>
References: <20050425213400.GB29288@gondor.apana.org.au> <426D8672.1030001@trash.net> <20050426003925.GA13650@gondor.apana.org.au> <426E3F67.8090006@trash.net> <20050426232857.GA18358@gondor.apana.org.au> <426EE350.1070902@trash.net> <20050427010730.GA18919@gondor.apana.org.au> <426F68C5.4010109@trash.net> <20050427103056.GB22099@gondor.apana.org.au> <Pine.LNX.4.58.0504271237350.4795@blackhole.kfki.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504271237350.4795@blackhole.kfki.hu>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 12:41:01PM +0200, Jozsef Kadlecsik wrote:
> > >
> > > Forwarded packets can't have any NAT manips in LOCAL_OUT, so it
> > > should work. I'm not sure about it though because it would be
> > > the only place where packets just appear in FORWARD, usually
> > > all packets enters through PRE_ROUTING or LOCAL_OUT.
> >
> > It's also the only place where we generate a packet with a non-local
> > source address :)
> 
> Besides the REJECT target, TARPIT in patch-o-matic-ng also generates
> packets with non-local source addresses. We cannot assume that REJECT is
> the only one which can create such packets.

Any reason why it can't be fed through the FORWARD chain as opposed
to LOCAL_OUT? In general, is there anything that's generating packets
with foreign addresses that can't be fed through FORWARD?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
