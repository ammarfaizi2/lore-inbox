Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129507AbQLHAzz>; Thu, 7 Dec 2000 19:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130110AbQLHAzq>; Thu, 7 Dec 2000 19:55:46 -0500
Received: from mailgate.ics.forth.gr ([139.91.1.2]:35063 "EHLO
	ext1.ics.forth.gr") by vger.kernel.org with ESMTP
	id <S129507AbQLHAzk>; Thu, 7 Dec 2000 19:55:40 -0500
Posted-Date: Fri, 8 Dec 2000 02:17:54 +0200 (EET)
Organization: 
Date: Fri, 8 Dec 2000 02:17:54 +0200 (EET)
From: Kotsovinos Vangelis <kotsovin@ics.forth.gr>
To: Christopher Friesen <cfriesen@nortelnetworks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Microsecond accuracy
In-Reply-To: <3A2FC0C6.3F11057B@nortelnetworks.com>
Message-ID: <Pine.GSO.4.10.10012080213140.9184-100000@sappho.ics.forth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Dec 2000, Christopher Friesen wrote:

> Kotsovinos Vangelis wrote:
> > 
> > Is there any way to measure (with microsecond accuracy) the time of a
> > program execution (without using Machine Specific Registers) ?
> > I've already tried getrusage(), times() and clock() but they all have
> > 10 millisecond accuracy, even though they claim to have microsecond
> > acuracy.
> > The only thing that seems to work is to use one of the tools that measure
> > performanc through accessing the machine specific registers. They give you
> > the ability to measure the clock cycles used, but their accuracy is also
> > very low from what I have seen up to now.
> 
> Can you not just use something like gettimeofday()?  Do two consecutive calls to
> find the execution time of the instruction itself, and then do two calls on
> either side of the program execution.  Subtract the instruction execution time
> from the delta, and that should give a pretty good idea of execution time.

Well, it is a pretty complex program that I want to measure, with more
than one modules that run one after another... they sleep and use signals
to wake each other up, they use semaphores etc. What I want to measure is
the time the program is running (not waiting for other processes or
waiting for a signal etc). 
Also, there are other processes running on the
system (for example, my program needs about 50 seconds of real time to
execute and I estimate the time it is "running" to be about 5000-10000
microseconds)...

Thanks anyway,

Vangelis

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
