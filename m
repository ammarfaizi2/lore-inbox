Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130149AbRAIULd>; Tue, 9 Jan 2001 15:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129835AbRAIULP>; Tue, 9 Jan 2001 15:11:15 -0500
Received: from magla.iskon.hr ([213.191.128.32]:5124 "EHLO magla.iskon.hr")
	by vger.kernel.org with ESMTP id <S131488AbRAIULJ>;
	Tue, 9 Jan 2001 15:11:09 -0500
To: Simon Kirby <sim@stormix.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <dnbstgewoj.fsf@magla.iskon.hr>
	<Pine.LNX.4.10.10101091041150.2070-100000@penguin.transmeta.com>
	<20010109145352.A23691@stormix.com>
Reply-To: zlatko@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko@iskon.hr>
Date: 09 Jan 2001 21:10:54 +0100
In-Reply-To: Simon Kirby's message of "Tue, 9 Jan 2001 14:53:52 -0500"
Message-ID: <dnwvc4ij01.fsf@magla.iskon.hr>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Notus)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Kirby <sim@stormix.com> writes:

> On Tue, Jan 09, 2001 at 10:47:57AM -0800, Linus Torvalds wrote:
> 
> > And this _is_ a downside, there's no question about it. There's the worry
> > about the potential loss of locality, but there's also the fact that you
> > effectively need a bigger swap partition with 2.4.x - never mind that
> > large portions of the allocations may never be used. You still need the
> > disk space for good VM behaviour.
> > 
> > There are always trade-offs, I think the 2.4.x tradeoff is a good one.
> 
> Hmm, perhaps you could clarify...
> 
> For boxes that rarely ever use swap with 2.2, will they now need more
> swap space on 2.4 to perform well, or just boxes which don't have enough
> RAM to handle everything nicely?
>

Just boxes that were already short on memory (swapped a lot) will need
more swap, empirically up to 4 times as much. If you already had
enough memory than things will stay almost the same for you.

But anyway, after some testing I've done recently I would now not
recommend anybody to have less than 2 x RAM size swap partition.

> I've always been tending to make swap partitions smaller lately, as it
> helps in the case where we have to wait for a runaway process to eat up
> all of the swap space before it gets killed.  Making the swap size
> smaller speeds up the time it takes for this to happen, albeit something
> which isn't supposed to happen anyway.
> 

Well, if you continue with that practice now you will be even more
successful in killing such processes, I would say. :)
-- 
Zlatko
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
