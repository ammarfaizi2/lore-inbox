Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268133AbRHAUeK>; Wed, 1 Aug 2001 16:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268145AbRHAUeB>; Wed, 1 Aug 2001 16:34:01 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:60655 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S268094AbRHAUdo>; Wed, 1 Aug 2001 16:33:44 -0400
Message-ID: <3B68678C.5B7BD150@mvista.com>
Date: Wed, 01 Aug 2001 13:33:16 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Chris Friesen <cfriesen@nortelnetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
In-Reply-To: <Pine.LNX.3.95.1010801154207.1042A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> > george anzinger wrote:
> >
> > > The testing I have done seems to indicate a lower overhead on a lightly
> > > loaded system, about the same overhead with some load, and much more
> > > overhead with a heavy load.  To me this seems like the wrong thing to
> >
> 
> Doesn't the "tick-less" system presume that somebody, somewhere, will
> be sleeping sometime during the 1/HZ interval so that the scheduler
> gets control?
> 
> If everybody's doing:
> 
>         for(;;)
>           number_crunch();
> 
> And no I/O is pending, how does the jiffy count get bumped?

Who cares if it gets bumped?  In the tick less system the jiffy counter
is a function.  Thus, if you need it, it will be current, more current
than in the ticked system because it is calculated on the spot and does
not rely on an interrupt to "bump" it.
> 
> I think the "tick-less" system relies upon a side-effect of
> interactive use that can't be relied upon for design criteria.
> 
Look at the code.  You will find it here:
http://sourceforge.net/projects/high-res-timers

George
