Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268053AbRHATuC>; Wed, 1 Aug 2001 15:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268051AbRHATtw>; Wed, 1 Aug 2001 15:49:52 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4736 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268053AbRHATtl>; Wed, 1 Aug 2001 15:49:41 -0400
Date: Wed, 1 Aug 2001 15:49:27 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: george anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
In-Reply-To: <3B6859B2.F1E2C95B@nortelnetworks.com>
Message-ID: <Pine.LNX.3.95.1010801154207.1042A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> george anzinger wrote:
> 
> > The testing I have done seems to indicate a lower overhead on a lightly
> > loaded system, about the same overhead with some load, and much more
> > overhead with a heavy load.  To me this seems like the wrong thing to
> 

Doesn't the "tick-less" system presume that somebody, somewhere, will
be sleeping sometime during the 1/HZ interval so that the scheduler
gets control?

If everybody's doing:

	for(;;)
          number_crunch();

And no I/O is pending, how does the jiffy count get bumped?

I think the "tick-less" system relies upon a side-effect of
interactive use that can't be relied upon for design criteria.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


