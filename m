Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265636AbRF1LzY>; Thu, 28 Jun 2001 07:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265641AbRF1LzP>; Thu, 28 Jun 2001 07:55:15 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:52223 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S265636AbRF1LzH>; Thu, 28 Jun 2001 07:55:07 -0400
Message-ID: <3B3B1B12.D735FD7D@TeraPort.de>
Date: Thu, 28 Jun 2001 13:54:59 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac19 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@idb.hist.no>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <3B399EF8.9BA76FA2@TeraPort.de> <3B3B14AB.DF020611@idb.hist.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> 
> Martin Knoblauch wrote:
> 
> >
> >  maybe more specific: If the hit-rate is low and the cache is already
> > 70+% of the systems memory, the chances maybe slim that more cache is
> > going to improve the hit-rate.
> >
> Oh, but this is posible.  You can get into situations where
> the (file cache) working set needs 80% or so of memory
> to get a near-perfect hitrate, and where
> using 70% of memory will trash madly due to the file access

 thats why I said "maybe" :-) Sure, another 5% of cache may improve
things, but they also may kill the interactive performance. Thats why
there should be probably more than one VM strategy to accomodate Servers
and Workstations/Lpatops.

> pattern.  And this won't be a problem either, if
> the working set of "other" (non-file)
> stuff is below 20% of memory.  The total size of
> non-file stuff may be above 20% though, so something goes
> into swap.
> 

 And that is the problem. To much seems to go into swap. At least for
interactive work. Unfortunatelly, with 128MB of memory I cannot entirely
turn of swap. I will see how things are going once I have 256 or 512 MB
(hopefully soon :-)

> I definitely want the machine to work under such circumstances,
> so an arbitrary limit of 70% won't work.
>

 Do not take the 70% as an arbitrary limit. I never said that. The 70%
is just my situation. The problems may arise at 60% cache or at 97.38%
cache.
 
> Preventing swap-trashing at all cost doesn't help if the

 Never said at all cost.

> machine loose to io-trashing instead.  Performance will be
> just as much down, although perhaps more satisfying because
> people aren't that surprised if explicit file operations
> take a long time.  They hate it when moving the mouse
> or something cause a disk access even if their
> apps runs faster. :-(
> 

 Absolutely true. And if the main purpose of the machine is interactive
work (we do want to be Linux a success on the desktop, don't we?), it
should not be hampered by by an IO improvement that may be only of
secondary importance to the user (that the final "customer" for all the
work that is done to the kernel :-). On big servers a litle paging now
and then may be absolutely OK, as long as the IO is going strong.

 I am observing the the discussions of VM behaviour in 2.4.x for some
time. They are mostly very entertaining and revealing. But they also
show that one solution does not seem to benefit all possible scenarios.
Therfore either more than one VM strategy is necessary, or better means
of tuning the cache behaviour, or both. Definitely better ways of
measuring the VM efficiency seem to be needed.

 While implementing VM strategies is probably out of question for a lot
of the people that complain, I hope that at least my complaints are kind
of useful.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
