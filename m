Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130143AbQKJTml>; Fri, 10 Nov 2000 14:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131480AbQKJTmb>; Fri, 10 Nov 2000 14:42:31 -0500
Received: from front4.grolier.fr ([194.158.96.54]:44691 "EHLO
	front4.grolier.fr") by vger.kernel.org with ESMTP
	id <S130143AbQKJTmU> convert rfc822-to-8bit; Fri, 10 Nov 2000 14:42:20 -0500
Date: Fri, 10 Nov 2000 19:35:41 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Richard Henderson <rth@twiddle.net>, axp-list@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: PCI-PCI bridges mess in 2.4.x
In-Reply-To: <20001110021723.A4142@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.10.10011101929190.1448-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Nov 2000, Ivan Kokshaysky wrote:

> On Thu, Nov 09, 2000 at 09:37:41PM +0100, Gerard Roudier wrote:
> > Hmmm...
> > The PCI spec. says that Limit registers define the top addresses
> > _inclusive_.
> 
> Correct.
> 
> > The spec. does not seem to imagine that a Limit register lower than the
> > corresponding Base register will ever exist anywhere, in my opinion. :-)
> 
> Not correct.
> Here's a quote from `PCI-to-PCI Bridge Architecture Specification rev 1.1':
>    The Memory Limit register _must_ be programmed to a smaller value
>    than the Memory Base if there are no memory-mapped I/O addresses on the
>    secondary side of the bridge.

I only have spec 1.0 on paper. I should have checked 1.1. Anyway, it may
still exist bridges that have been designed prior to spec. 1.1.

> I/O is slightly different because it's optional for the bridge -
> but if it's implemented same rules apply.

Will also check the spec. on this point. :)

> > This let me think that trying to be clever here is probably a very bad
> > idea. What is so catastrophic of having 1 to 4 bytes of addresses and no
> > more being possibly in a forwardable range?
> > 
> Huh. 1 to 4 bytes? 4K for I/O and 1M for memory.
> And it's not trying to be clever (anymore :-) - just strictly following
> the Specs.

I just missed the units, but absolute values weren't so wrong. :-)

> I understand your point very well, btw. I asked similar questions to myself
> until I've had the docs.

Ok. Thanks for the reply.

  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
