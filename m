Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312573AbSDXTTV>; Wed, 24 Apr 2002 15:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312574AbSDXTTU>; Wed, 24 Apr 2002 15:19:20 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:61707 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S312573AbSDXTTT>; Wed, 24 Apr 2002 15:19:19 -0400
Date: Wed, 24 Apr 2002 15:16:20 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while reading damadged files
In-Reply-To: <Pine.LNX.3.95.1020424081802.20796A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.3.96.1020424150911.3065D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2002, Richard B. Johnson wrote:

> On Tue, 23 Apr 2002, Bill Davidsen wrote:

> > Several things come to mind:
> > 1 - don't dedicate the entire machine to retrying the error such that
> >     everything else runs slowly if at all.
> 
> But it doesn't! As previously stated, if you have a device on a common
> 'channel' (like IDE), that everybody else is trying to use, then
> everybody else ends up waiting. However, if your errored devices don't
> take over a common I/O channel, everybody else gets the CPU while the
> errors are being retried.
> 
> For instance, I have SCSI for my disks, and I use IDE for a R/W CD
> because it's cheap. I can "try forever" reading dorked CDs and the
> only process affected at all is the one trying to read the CD. I
> can do full-speed compiles while the CD is being retried.

That's very nice for a system where cost is no object, but ATAPI/IDE is
where the bulk of Linux system are running. Putting the CD on another
cable is realistic (the system I hung does that) but putting the CD on IDE
and the disk on SCSI is not cost effective compared to fixing the hang in
software.
 
> It's all about configuration. The kernel drivers sleep while waiting
> for interrupts that will determine the success or failure of the
> disk operation. The 'sleep' means that the CPU gets given to somebody
> who could use it.

It would also be nice if the other IDE channels were given to "somebody
who could use it," but that would appear in some cases not to happen.

> > I took a bottle cap to one of the morning's AOL CDs and then tried to read
> > it. It's really not just annoying, it's pretty much useless. If you were
> > staging software off a CD on a running server, your clients would NOT be
> > happy!
> > 
> 
> Put your CDs on a different controller and you can do anything you
> want without affecting other tasks.

  As above, another type of bus is not cost effective, another IDE cable
doesn't solve the problem, no matter what theory says. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

