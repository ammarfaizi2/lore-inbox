Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSGYNGT>; Thu, 25 Jul 2002 09:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313508AbSGYNGR>; Thu, 25 Jul 2002 09:06:17 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36363 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313537AbSGYNGC>; Thu, 25 Jul 2002 09:06:02 -0400
Date: Thu, 25 Jul 2002 09:03:33 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dual Athlon MP 1900+ on MSI K7D Master-L
In-Reply-To: <200207182114.30806.kelledin+LKML@skarpsey.dyndns.org>
Message-ID: <Pine.LNX.3.96.1020725085414.11202E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002, Kelledin wrote:
> Alan may have a different answer for you, but in my experience, 
> you can just specify the -j<whatever> flag when you run make 
> (and also set the MAKE variable to "make -j<whatever>".  The 
> speed benefit really kicks in when making bzImage or modules.
> 
> In general, I find it best to set the number of jobs to the 
> number of CPUs _plus 1_--i.e. for single CPU, use make -j2, and 
> for dual CPUs, use make -j3.  Going for that "plus 1" makes most 
> builds just a smidgen faster.  For me, on my dual PPro box, the 
> process would be something like:
> 
> make menuconfig
> make -j3 MAKE="make -j3" dep clean bzImage modules

These do different things...

If you put -j3 on the command line as an option to the primary make, it
can (will) run that many processes and do things out of order. If you use
MAKE='make -j3' it only takes effect after a new make process is started.
So you can put all the things on one command line and they will be run to
completion sequentially. I find this helpful to avoid mixing bzImage and
modules, one may get an error and the other will keep on going, scrolling
the error off the screen.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

