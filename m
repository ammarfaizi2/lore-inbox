Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <155522-2781>; Fri, 8 Jan 1999 02:56:27 -0500
Received: from ps.cus.umist.ac.uk ([192.84.78.160]:9295 "EHLO ps.cus.umist.ac.uk" ident: "rhw") by vger.rutgers.edu with ESMTP id <161080-13684>; Thu, 7 Jan 1999 10:13:43 -0500
Date: Thu, 7 Jan 1999 17:38:08 +0000 (GMT)
From: Riley Williams <rhw@bigfoot.com>
To: "B. James Phillippe" <bryan@terran.org>
cc: Kurt Garloff <K.Garloff@ping.de>, Linux Kernel <linux-kernel@vger.rutgers.edu>
Subject: Re: [PATCH] HZ change for ix86
In-Reply-To: <Pine.LNX.4.04.9901052119090.19960-100000@earth.terran.org>
Message-ID: <Pine.LNX.3.96.990107173432.6687D-100000@ps.cus.umist.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

Hi James.

 >> I created a patch which changes the values of HZ to 400 and fixed
 >> all places I could spot which report the jiffies value to
 >> userspace. I think I caught all of them. Note that 400 is a nice
 >> value, because we have to divide the values by 4 then, which the
 >> gcc optimizes to shift operations, which can be done in one or two
 >> cycles each and even parallelized on modern CPUs. Integer
 >> divisions are slow on the ix86 (~20 cycles) and the sys_times() 
 >> needs four of them.

 > I don't know anything about it (and my box is an Alpha for which HZ
 > is 1024), but, one ignorant proposal: would it perhaps be
 > worthwhile to have the HZ value higher for faster (x86) systems
 > based on the target picked in make config?

 > Say, your 400 for Pentium+ and 100 for 486 or lower..?

If we were going to do this, I'd suggest 400 for Pentium+, 200 for 486
and 100 for 386 class systems as being more reasonable, and still
maintaining the shift-optimisation mentioned above...

Best wishes from Riley.

---
 * ftp://ps.cus.umist.ac.uk/pub/rhw/Linux
 * http://ps.cus.umist.ac.uk/~rhw/kernel.versions.html


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
