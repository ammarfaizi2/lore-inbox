Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154696-8316>; Thu, 10 Sep 1998 16:27:35 -0400
Received: from dt020n85.san.rr.com ([204.210.9.133]:30897 "EHLO gateway.local" ident: "root") by vger.rutgers.edu with ESMTP id <154824-8316>; Thu, 10 Sep 1998 15:22:40 -0400
Date: Thu, 10 Sep 1998 15:02:50 -0700 (PDT)
From: Ryan Moore <rmoore@rmoore.i.seawood.org>
To: Oliver Xymoron <oxymoron@waste.org>
cc: linux-kernel@vger.rutgers.edu
Subject: Re: GPS Leap Second Scheduled!
In-Reply-To: <Pine.LNX.3.96.980910120009.27760F-100000@waste.org>
Message-ID: <Pine.LNX.4.01.9809101456340.15524-100000@gateway.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Thu, 10 Sep 1998, Oliver Xymoron wrote:
> Finally, telling the kernel to schedule a leap second seems pretty ugly as
> well.

Except that it's already doing it.  At least it is if you're running ntpd
or xntpd.  I've seen the Linux kernel do leap seconds on my machine
before.

In 2.0.35 at least, the code is in /usr/src/linux/kernel/sched.c
In function second_overflow().

The kernel even prints a log message:

printk(KERN_NOTICE "Clock: inserting leap second 23:59:60 UTC\n");

in one case and...

printk(KERN_NOTICE "Clock: deleting leap second 23:59:59 UTC\n");

in another.

--------------------------------
Ryan Moore    rmoore@rmoore.i.seawood.org



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html
