Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135333AbRDLVZ7>; Thu, 12 Apr 2001 17:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135334AbRDLVZu>; Thu, 12 Apr 2001 17:25:50 -0400
Received: from dystopia.lab43.org ([209.217.122.210]:54206 "EHLO
	dystopia.lab43.org") by vger.kernel.org with ESMTP
	id <S135333AbRDLVZi>; Thu, 12 Apr 2001 17:25:38 -0400
Date: Thu, 12 Apr 2001 17:23:44 -0400 (EDT)
From: Rod Stewart <stewart@dystopia.lab43.org>
To: Andrew Morton <andrewm@uow.edu.au>
cc: <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: 8139too: defunct threads
In-Reply-To: <3AD61258.4E8567D8@uow.edu.au>
Message-ID: <Pine.LNX.4.33.0104121713490.32117-100000@dystopia.lab43.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2001, Andrew Morton wrote:
> Rod Stewart wrote:
> >
> > On Thu, 12 Apr 2001, Andrew Morton wrote:
> > > Rod Stewart wrote:
> > > >
> > > > Hello,
> > > >
> > > > Using the 8139too driver, 0.9.15c, we have noticed that we get a defunct
> > > > thread for each device we have; if the driver is built into the kernel.
> > > > If the driver is built as a module, no defunct threads appear.
> > >
> > > What is the parent PID for the defunct tasks?  zero?
> >
> > According to ps, 1
>
> Ah.  Of course.  All (or most) kernel initialisation is
> done by PID 1.  Search for "kernel_thread" in init/main.c
>
> So it seems that in your setup, process 1 is not reaping
> children, which is why this hasn't been reported before.
> Is there something unusual about your setup?

One box is standard PIII with RH 7.0, the other is a custom Crusoe TM5400
board.  But from further investigation it appears to be a kernel config
option.  As I've got a 2.4.0 kernel which has very little compiled in and
not showing the problem and another kernel which has many more networking
options built in and showing the problem.  I've seen this problem
since 2.4.0.test11.

I'll send a note once I find the config option which is causing this,
probably tomorrow.

Thanks,
-Rms

