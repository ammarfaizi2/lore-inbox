Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280766AbRKKBma>; Sat, 10 Nov 2001 20:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280769AbRKKBmU>; Sat, 10 Nov 2001 20:42:20 -0500
Received: from suphys.physics.usyd.edu.au ([129.78.129.1]:31616 "EHLO
	suphys.physics.usyd.edu.au") by vger.kernel.org with ESMTP
	id <S280766AbRKKBmF>; Sat, 10 Nov 2001 20:42:05 -0500
Date: Sun, 11 Nov 2001 12:42:00 +1100 (EST)
From: Tim Connors <tcon@Physics.usyd.edu.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Laptop harddisk spindown?
In-Reply-To: <200111080502.fA852im17980@vegae.deep.net>
Message-ID: <Pine.SOL.3.96.1011111123736.18524B-100000@suphys.physics.usyd.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2001, Samium Gromoff wrote:

> "  Dominik Kubla wrote:"
> > 
> > On Thu, Nov 08, 2001 at 01:51:05AM +0300, Samium Gromoff wrote:
> > >      I`m sorry folks, i dont quite recall whether i poked lkml with that,
> > >   but here it is:
> > > 	2.4.13, reiserfs
> > > 	i have a disk access _every_ 5 sec, unregarding the system load, 
> > >     24x7x365, so i suppose while it doesnt hurts me, it hurts folks with power
> > >     bound boxes...
> > >         I must add that i `m experiencing this on -ac tree too, adn this is true
> > >     as far as my memory goes... (in the kernel-version context i mean)
> > > 
> > > cheers, Samium Gromoff
> > 
> > That's a FAQ: you have cron running...
>    hehe...
>    i`ve actually compiled cron only a week ago, so its not an issue ;)
>    (i havent had cron before on my homemmade linux)
> 
>    i mean i`m not this lame, and i told *no_system_load*... :-)

Not to mention that 5 second obviously implies it can't be cron (given
that it runs once a minute), and points to bdflush, since that is the
flushing interval.

Now, on my home box, If I run /bin/sync, the disk seeks, whether there is
data to write or not. Before you point to me that I need to mount noatime
- already done :) I think it also did this when bdflush told it to sync,
but after installing noflushd (and hacking the b0rked init scripts),
all was fine. At least, until I installed ext3 :(




-- 
TimC -- http://www.physics.usyd.edu.au/~tcon/

Some witty text here,
can be any number of lines
long

