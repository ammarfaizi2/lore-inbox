Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135377AbRDMEBG>; Fri, 13 Apr 2001 00:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135394AbRDMEA6>; Fri, 13 Apr 2001 00:00:58 -0400
Received: from anarchy.io.com ([199.170.88.101]:3697 "EHLO anarchy.io.com")
	by vger.kernel.org with ESMTP id <S135377AbRDMEAr>;
	Fri, 13 Apr 2001 00:00:47 -0400
Date: Thu, 12 Apr 2001 23:00:41 -0500 (CDT)
From: Bret Indrelee <bret@io.com>
To: george anzinger <george@mvista.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: No 100 HZ timer!
In-Reply-To: <3AD62A18.8AC75605@mvista.com>
Message-ID: <Pine.LNX.4.21.0104122258060.7396-100000@fnord.io.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2001, george anzinger wrote:
> Bret Indrelee wrote:
> > 
> > On Thu, 12 Apr 2001, george anzinger wrote:
> > > Bret Indrelee wrote:
> > > > Keep all timers in a sorted double-linked list. Do the insert
> > > > intelligently, adding it from the back or front of the list depending on
> > > > where it is in relation to existing entries.
> > >
> > > I think this is too slow, especially for a busy system, but there are
> > > solutions...
> > 
> > It is better than the current solution.
> 
> Uh, where are we talking about.  The current time list insert is real
> close to O(1) and never more than O(5).

I don't like the cost of the cascades every (as I recall) 256
interrupts. This is more work than is done in the rest of the interrupt
processing, happens during the tick interrupt, and results in a rebuild of
much of the table.

-Bret

------------------------------------------------------------------------------
Bret Indrelee |  Sometimes, to be deep, we must act shallow!
bret@io.com   |  -Riff in The Quatrix

