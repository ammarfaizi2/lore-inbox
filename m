Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292000AbSBTQvP>; Wed, 20 Feb 2002 11:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292003AbSBTQvH>; Wed, 20 Feb 2002 11:51:07 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:25327 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S292000AbSBTQuy>; Wed, 20 Feb 2002 11:50:54 -0500
Message-ID: <3C73D3D8.513837ED@mvista.com>
Date: Wed, 20 Feb 2002 08:50:32 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Ben Greear <greearb@candelatech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: jiffies rollover, uptime etc.
In-Reply-To: <Pine.LNX.3.96.1020220104257.23280J-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> 
> On Tue, 19 Feb 2002, george anzinger wrote:
> 
> > Bill Davidsen wrote:
> > >
> > > On Mon, 18 Feb 2002, Ben Greear wrote:
> 
> > > > Does this problem still exist on 64-bit machines?
> > >
> > > Absolutely. But not as often ;-)
> >
> > Actually you will have a VERY hard time getting it to roll over.  Issues
> > of your life time, not to mention the hardware's life time.  64 bits
> > makes a VERY large number and you are counting in 427 day increments.
> > Remember we have been counting seconds since 1970 in 32 bits and
> > rollover is still, most likely, beyond the capability of any machine
> > running today to get to.  Now consider counting in 427 day increments
> > instead of seconds.
> 
> Um, note the odd characters appended to my sentence ";-)" which means
> "not serious here, look for joke, sarcasm, over or understatement.
> 
Ok, I guess I just got so impressed with the size of a 64-bit value that
I was overwhelmed.  Consider, for example:

	u64 i;
	for (i = 1; i != 0; i++);

Now in theory this will count each possible number, but in practice the
machine will die long before it ever finishes.
	
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
