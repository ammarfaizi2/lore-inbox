Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287344AbSAHQyz>; Tue, 8 Jan 2002 11:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287347AbSAHQyq>; Tue, 8 Jan 2002 11:54:46 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:47603 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S287344AbSAHQye>; Tue, 8 Jan 2002 11:54:34 -0500
Message-ID: <3C3B2429.6DFA0EAA@mvista.com>
Date: Tue, 08 Jan 2002 08:54:01 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nathan <wfilardo@fuse.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler, 2.4.17-B0, 2.5.2-pre8-B0.
In-Reply-To: <Pine.LNX.4.33.0201052232170.13672-100000@majere.epithna.com> <1010297456.3226.11.camel@phantasy> <3C38D45B.20105@fuse.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan wrote:
> 
> Out of sheer curiosity (and this might be a stupid question), is there
> any effort to make the following lines of development all work together:
> RML's preempt-kernel and lock-break (and netdev, but that doesn't touch
> the other stuff), Rick's rmap VM, and the O(1) scheduler?  If so, is it
> being applied to 2.4 or 2.5? (Definately seems 2.5-ish, but given that
> all the patches are available for 2.4, I thought I'd ask.)
> 
> This system just got 2.4.18-pre1 with RML's preempt and Rick's rmap10c
> patches.  Seems stable though dbench 10 can take all responsiveness out
> of KDE (though XMMS never skips).  The O(1) scheduler did not apply, nor
> did lock-break, otherwise I would be running with all of the above.
> 
> Are any of these actually mutually exclusive? (that is, am I just
> wasting time and decreasing the s:n ratio on LKML?)

No, not in concept.  Just that they collide in a couple of places and
need a bit of sorting out.  Give us a moment.

George
> 
> Thanks in advance.
> 
> --Nathan
> 
> Robert Love wrote:
> 
> >On Sat, 2002-01-05 at 22:34, listmail@majere.epithna.com wrote:
> >
> >>How close are you and Robert Love on getting this patch and his pre-emt
> >>patches to co-operate...seems like that might bring huge wins.  I know, I
> >>know I could diff, and fix the rejects myself, but this seems to deep in
> >>the kernel for a relative newbie like myself(plus I am more a file system
> >>guy)
> >>
> >
> >Unfortunately it looks like it is going to take a bit more than fixing
> >trivial rejects.  I started working on it today.  I suspect I am going
> >to need a lot better understanding of Ingo's scheduler, so I am learning
> >it.  I am traveling tomorrow but should be able to dive into it on
> >Monday.
> >
> >Ingo and I both agree that the patches together are a Good Thing.
> >
> >I have a fully ported patch at this point but it hard locks on boot.  I
> >believe the problem to be a few bits in sched.c, but there may be some
> >underlying changes that break assumptions elsewhere.
> >
> >We are working on it.  Help is always appreciated, though ;)
> >
> >       Robert Love
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
