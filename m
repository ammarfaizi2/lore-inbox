Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129193AbRBPLUO>; Fri, 16 Feb 2001 06:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129243AbRBPLTy>; Fri, 16 Feb 2001 06:19:54 -0500
Received: from zeus.kernel.org ([209.10.41.242]:41187 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129211AbRBPLTr>;
	Fri, 16 Feb 2001 06:19:47 -0500
Date: Fri, 16 Feb 2001 11:15:51 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 8139 full duplex?
In-Reply-To: <200102160940.KAA02620@cave.bitwizard.nl>
Message-ID: <Pine.SOL.4.21.0102161110580.3048-100000@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2001, Rogier Wolff wrote:

> James Sutherland wrote:
> > > That would explain me seeing way too many collisions on that old hub
> > > (which obviously doesn't support full-duplex).
> > 
> > No, it would just prevent your card working. Large numbers of collisions
> > are normal during fast transfers across a hub.
> 
> Why would it completely "not work"? 

It wouldn't be able to detect collisions, I suspect; you might be able to
get data through, though. Not something I've ever wanted to try :-)

> As long as the host doesn't have something to send while a recieve is
> in progress, everything should work. A friend reports that he spent
> lots of time trying to debug a network where "too many" collisions
> were happening. Turns out one card was in full-duplex, while the other
> side wasn't.

On a crossover cable direct between two machines, that would make sense:
you would WANT both cards full duplex, but if one ran half duplex instead,
it would think it was getting a huge number of collisions when it
wasn't...

> I benchmarked my old network at 10-12 seconds for a 100Mb
> transfer. That sounds indeed as if there isn't a whole lot of
> collisions happening. And I can immagine that the acks run into the
> next data-packet all the time, so that performance would indeed be
> very bad if the card was misconfigured. On the other hand I had one
> machine that was taking 180 seconds for the 100Mb transfer.

Ouch! Remember each collision only knocks out a few hundred bytes -
perhaps 1.5K - so even hundreds of collisions per second only knock a few
hundred K/sec off a transfer rate of ten Mbyte/sec or so.

> Anyway, I remember fiddling with the eexpress 100 driver, and there
> the driver was involved in switching the speeds, and doing some
> management of the switchover of full-duplex/half-duplex. I'd expect
> some message from the driver if it saw such a change. 
> 
> But you're saying that the 8139 chip does it internally, and fully  
> automatically? Ok. Good. 

Well, mine do anyway :-)

(Except under the Win2k bug, where I needed to force the link to 100
Mbit/sec full duplex...)


James.

