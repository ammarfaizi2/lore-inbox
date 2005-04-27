Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVD0KlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVD0KlB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 06:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVD0KlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 06:41:00 -0400
Received: from blackhole.kfki.hu ([148.6.0.114]:65197 "EHLO blackhole.kfki.hu")
	by vger.kernel.org with ESMTP id S261378AbVD0Kkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 06:40:55 -0400
Date: Wed, 27 Apr 2005 12:41:01 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Patrick McHardy <kaber@trash.net>, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, Yair@arx.com,
       linux-kernel@vger.kernel.org
Subject: Re: Re-routing packets via netfilter (ip_rt_bug)
In-Reply-To: <20050427103056.GB22099@gondor.apana.org.au>
Message-ID: <Pine.LNX.4.58.0504271237350.4795@blackhole.kfki.hu>
References: <E1DQ1Ct-00055s-00@gondolin.me.apana.org.au> <426D0CB9.4060500@trash.net>
 <20050425213400.GB29288@gondor.apana.org.au> <426D8672.1030001@trash.net>
 <20050426003925.GA13650@gondor.apana.org.au> <426E3F67.8090006@trash.net>
 <20050426232857.GA18358@gondor.apana.org.au> <426EE350.1070902@trash.net>
 <20050427010730.GA18919@gondor.apana.org.au> <426F68C5.4010109@trash.net>
 <20050427103056.GB22099@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2005, Herbert Xu wrote:

> On Wed, Apr 27, 2005 at 12:26:13PM +0200, Patrick McHardy wrote:
> >
> > Forwarded packets can't have any NAT manips in LOCAL_OUT, so it
> > should work. I'm not sure about it though because it would be
> > the only place where packets just appear in FORWARD, usually
> > all packets enters through PRE_ROUTING or LOCAL_OUT.
>
> It's also the only place where we generate a packet with a non-local
> source address :)

Besides the REJECT target, TARPIT in patch-o-matic-ng also generates
packets with non-local source addresses. We cannot assume that REJECT is
the only one which can create such packets.

Best regards,
Jozsef
-
E-mail  : kadlec@blackhole.kfki.hu, kadlec@sunserv.kfki.hu
PGP key : http://www.kfki.hu/~kadlec/pgp_public_key.txt
Address : KFKI Research Institute for Particle and Nuclear Physics
          H-1525 Budapest 114, POB. 49, Hungary
