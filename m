Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267977AbRHBSoM>; Thu, 2 Aug 2001 14:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268362AbRHBSoC>; Thu, 2 Aug 2001 14:44:02 -0400
Received: from waste.org ([209.173.204.2]:11593 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S267977AbRHBSnw>;
	Thu, 2 Aug 2001 14:43:52 -0400
Date: Thu, 2 Aug 2001 13:41:56 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: george anzinger <george@mvista.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Chris Friesen <cfriesen@nortelnetworks.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: No 100 HZ timer !
In-Reply-To: <3B699207.84058325@mvista.com>
Message-ID: <Pine.LNX.4.30.0108021322560.2340-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001, george anzinger wrote:

> Oliver Xymoron wrote:
> >
> > Does the higher timer granularity cause overall throughput to improve, by
> > any chance?
> >
> Good question.  I have not run any tests for this.  You might want to do
> so.  To do these tests you would want to build the system with the tick
> less timers only and with the instrumentation turned off.  I would like
> to hear the results.
>
> In the mean time, here is a best guess.  First, due to hardware
> limitations, the longest time you can program the timer for is ~50ms.
> This means you are reducing the load by a factor of 5.  Now the load
> (i.e. timer overhead) is ~0.12%, so it would go to ~0.025%.  This means
> that you should have about 0.1% more available for thru put.  Even if we
> take 10 times this to cover the cache disruptions that no longer occur,
> I would guess a thru put improvement of no more than 1%.  Still,
> measurements are better that guesses...

That's not what I'm getting at at all. Simply raising HZ is known to
improve throughput on many workloads, even with more reschedules: the
system is able to more finely adapt to changes in available disk and
memory bandwidth.

BTW, there are some arguments that tickless is worth doing even on old
PIC-only systems:

http://groups.google.com/groups?q=oliver+xymoron+timer&hl=en&group=mlist.linux.kernel&safe=off&rnum=2&selm=linux.kernel.Pine.LNX.4.30.0104111337170.32245-100000%40waste.org

And I found this while I was looking too:

http://groups.google.com/groups?q=oliver+xymoron+timer&hl=en&group=mlist.linux.kernel&safe=off&rnum=3&selm=linux.kernel.Pine.LNX.4.10.10010241534110.2957-100000%40waste.org

..but no one thought it was interesting at the time.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

