Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268174AbTAKXQh>; Sat, 11 Jan 2003 18:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268175AbTAKXQh>; Sat, 11 Jan 2003 18:16:37 -0500
Received: from mta1.srv.hcvlny.cv.net ([167.206.5.4]:29478 "EHLO
	mta1.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S268174AbTAKXQf>; Sat, 11 Jan 2003 18:16:35 -0500
Date: Sat, 11 Jan 2003 18:23:23 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: Nvidia and its choice to read the GPL "differently"
In-reply-to: <20030111222619.GG9153@nbkurt.casa-etp.nl>
To: Kurt Garloff <kurt@garloff.de>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Reply-to: robw@optonline.net
Message-id: <1042327403.1033.71.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
References: <7BFCE5F1EF28D64198522688F5449D5A03C0F4@xchangeserver2.storigen.com>
 <1042250324.1278.18.camel@RobsPC.RobertWilkens.com>
 <20030111020738.GC9373@work.bitmover.com>
 <1042251202.1259.28.camel@RobsPC.RobertWilkens.com>
 <20030111021741.GF9373@work.bitmover.com>
 <1042252717.1259.51.camel@RobsPC.RobertWilkens.com>
 <20030111214437.GD9153@nbkurt.casa-etp.nl>
 <1042322012.1034.6.camel@RobsPC.RobertWilkens.com>
 <20030111222619.GG9153@nbkurt.casa-etp.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-11 at 17:26, Kurt Garloff wrote:
> It is presumptuous. Very much so.

I'll accept that on face value, and take your comments five comments as
good pieces of information which I'll comment only briefly on.

> 1. A patch does not necessarily indicate something is wrong with the
>    original code. It may only show that people have ideas on how to
>    do things better, more efficiently, more nicely or to support
>    new features or hardware.

"Idea on how to do things better" implies "well, gee, it wasn't done so
great to begin with" :-) which was kinda my point.  

By the way, if I sounded too serious, i'm having fun, otherwise I
wouldn't be wasting my time here.

> 2. If a patch fixes a bug, you should be aware that the complexity
>    of an operating system is slightly higher than you think.
>    We're talking about a general purpose operating system that works
>    in real life and solves problems there. Not a toy system or a
>    specialized one.

The complexity may be somewhat less than you think.  If you break the OS
down into components, then take a look at any one of those compnents,
you can look at, study, and understand, and probably explain exactly
what any one of those components do at the code level (possibly even if
they are drivers for devices you are unfamiliar with).  Build up your
understanding of all of those little components, then you realize that
it's not as complex as you think.  The whole is just the sum of its
parts, and the parts are not that complex.

> 3. The amount of supported subsystems and hardware of the Linux kernel
>    is enormous. The hardware you deal with very often already is complex
>    and/or buggy. And needs things you never even thought about when
>    doing userspace programs before. Like protection from concurrent 
>    accesses to hardware.

I've thought about concurrent access to hardware from multiple
processors, and didn't like it -- but that's where "Simple" (not
complex) concepts like spinlocks come in (call 'em mutexes or semaphores
or whatever your buzzword of choice is).  You wait for the resource to
become available then you access it.

As per buggy hardware, the software should _not_ have to support it. 
The software should report that the hardware has a bug and stop. 
Otherwise, you wind up writing really bad code for other hardware at the
same time that you're trying to work with one particular piece of bad
hardware.

> 4. In kernel land, you have less tools available than a normal programmer
>    has. Things you assume just to be there and to work in userland programs
>    are unavailable and have to be done by yourself. Like I/O. Memory
>    allocation and management. 

You have the same tools, but they have different names.  For example,
instead of "printf" you have "printk", sure it's implemented in the
kernel itself, but it's there.  As per memory management, if you wanted
the kernel to do it for you, why the hell would you need to write a
kernel.

> 5. The impact of a bug in kernel is much higher than in a normal program.

Yeah, kernel processes have access to all memory, while user programs
run in protected mode.  Among other things.  With responsibility comes
power they say, or was it the other way around :-)

> It is naïve to believe that the fact that many bugs are found indicates 
> poor quality of a code. 

It is equally naive to discard the possibility.  On the other hand, we
don't see the list of bugs that are fixed on a daily basis internally at
companies like microsoft.  

> Just compare the stability of Linux to other operating systems. 

There aren't any comparable systems for stability.

> Go and start to work on a free software project of comparable size.
> If you think you can do it, create Robix. If your enthusiast enough,
> and technically good enough, you will find people who find it exciting
> and will help you.

The enthusiastic enough part will be the tough part...  Why do something
which is already done?  If I can do it better, who am I trying to do it
for and why?  As they say "Code it first, then talk", well, I'm not
coding at this stage, so I guess I have no right to talk then.

-Rob

