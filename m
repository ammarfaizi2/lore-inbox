Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <153906-13684>; Wed, 6 Jan 1999 20:44:46 -0500
Received: by vger.rutgers.edu id <153976-13684>; Wed, 6 Jan 1999 08:24:31 -0500
Received: from earth.terran.org ([208.152.24.33]:2176 "EHLO earth.terran.org" ident: "bryan") by vger.rutgers.edu with ESMTP id <155114-13684>; Tue, 5 Jan 1999 22:19:47 -0500
Date: Tue, 5 Jan 1999 21:25:25 -0800 (PST)
From: "B. James Phillippe" <bryan@terran.org>
To: Kurt Garloff <K.Garloff@ping.de>
cc: Linux kernel list <linux-kernel@vger.rutgers.edu>
Subject: Re: [PATCH] HZ change for ix86
In-Reply-To: <19990105094830.A17862@kg1.ping.de>
Message-ID: <Pine.LNX.4.04.9901052119090.19960-100000@earth.terran.org>
Organization: terran.org/darkforest.org
X-Subliminal-Message: Use Linux
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Tue, 5 Jan 1999, Kurt Garloff wrote:

> Hey guys,
> 
> lately, I've seen a couple of questions about changing HZ in the kernel for
> ix86. Your scheduler will run more often and your system might feel snappier
> when increasing HZ, that's why we want it. Overhead for doing so got
> relativlely low with recent CPUs, so me might really want it.
...
> I created a patch which changes the values of HZ to 400 and fixed all places
> I could spot which report the jiffies value to userspace. I think I caught
> all of them. Note that 400 is a nice value, because we have to divide the
> values by 4 then, which the gcc optimizes to shift operations, which can be
> done in one or two cycles each and even parallelized on modern CPUs. Integer
> divisions are slow on the ix86 (~20 cycles) and the sys_times() needs four of

I don't know anything about it (and my box is an Alpha for which HZ is
1024), but, one ignorant proposal: would it perhaps be worthwhile to have
the HZ value higher for faster (x86) systems based on the target picked in
make config?  Say, your 400 for Pentium+ and 100 for 486 or lower..?

cheers,
-bp
--
B. James Phillippe	. bryan@terran.org
Linux Engineer/Admin	. http://www.terran.org/~bryan
Member since 1.1.59	. finger:bryan@earth.terran.org


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
