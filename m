Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289016AbSANUPp>; Mon, 14 Jan 2002 15:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288959AbSANUO2>; Mon, 14 Jan 2002 15:14:28 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:25083 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S288974AbSANUOA>; Mon, 14 Jan 2002 15:14:00 -0500
Message-ID: <3C433BB3.4EB01846@mvista.com>
Date: Mon, 14 Jan 2002 12:12:35 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <Pine.LNX.3.96.1020113202508.17441L-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> 
> On Wed, 9 Jan 2002, Kent Borg wrote:
> 
> > How does all this fit into doing a tick-less kernel?
> >
> > There is something appealing about doing stuff only when there is
> > stuff to do, like: respond to input, handle some device that becomes
> > ready, or let another process run for a while.  Didn't IBM do some
> > nice work on this for Linux?  (*Was* it nice work?)  I was under the
> > impression that the current kernel isn't that far from being tickless.
> >
> > A tickless kernel would be wonderful for battery powered devices that
> > could literally shut off when there be nothing to do, and it seems it
> > would (trivially?) help performance on high end power hogs too.
> >
> > Why do we have regular HZ ticks?  (Other than I think I remember Linus
> > saying that he likes them.)
>
I put a patch on sourceforge as part of the high-res-timers
investigation the implemented a tick less kernel with instrumentation. 
It turns out to be overload prone, mostly do to the need to start and
stop a "slice" timer on each schedule() call.  I, for one, think this
issue is dead and rightly so.  The patch is still there for those who
want to try it.  See signature for URL.

 
> Feel free to quantify the savings over the current setup with max power
> saving enabled in the kernel. I just don't see how "wonderful" it would
> be, given that an idle system currently uses very little battery if you
> setup the options to save power.
> 
> --
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.
> 

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
