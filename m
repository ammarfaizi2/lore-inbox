Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132080AbQKJWdp>; Fri, 10 Nov 2000 17:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132079AbQKJWdg>; Fri, 10 Nov 2000 17:33:36 -0500
Received: from front7.grolier.fr ([194.158.96.57]:48800 "EHLO
	front7.grolier.fr") by vger.kernel.org with ESMTP
	id <S132005AbQKJWco> convert rfc822-to-8bit; Fri, 10 Nov 2000 17:32:44 -0500
Date: Fri, 10 Nov 2000 22:26:11 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Richard Henderson <rth@twiddle.net>, axp-list@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: PCI-PCI bridges mess in 2.4.x
In-Reply-To: <20001111002922.A1348@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.10.10011102214170.1918-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Nov 2000, Ivan Kokshaysky wrote:

> On Fri, Nov 10, 2000 at 07:35:41PM +0100, Gerard Roudier wrote:
> > I only have spec 1.0 on paper. I should have checked 1.1. Anyway, it may
> > still exist bridges that have been designed prior to spec. 1.1.
> 
> Yes, DEC 2105x bridges, for example.
> 
> The only update listed in revision history is "Update to include
> target initial latency requirements", so this (base > limit) stuff
> must be in rev. 1.0 as well. Please check chapters 3.2.5.[6,8,9].

The revision history should be a lot pessimistic about the amount of
additions. Btw, rev. 1.0 April 5, 1994 is 63 pages, and rev 1.1 is about
147 pages, as you know.

> > > I/O is slightly different because it's optional for the bridge -
> > > but if it's implemented same rules apply.
> > 
> > Will also check the spec. on this point. :)
> 
> Also, according the spec, we need some paranoia checks ;-)
> 1. check if the bridge has an I/O window not implemented

Read-only, returning zero on read. Already present in spec. 1.0.

> 2. if the bridge has regular BARs, allocate them properly
>    on the primary bus.

Limit < Base (new in 1.1, unless I missed the point. Btw, I actually
              donnot want to read again P2P spec. 1.0 :-) )

  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
