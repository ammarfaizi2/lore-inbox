Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317537AbSGJQha>; Wed, 10 Jul 2002 12:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317538AbSGJQh3>; Wed, 10 Jul 2002 12:37:29 -0400
Received: from [195.223.140.120] ([195.223.140.120]:14706 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317537AbSGJQh2>; Wed, 10 Jul 2002 12:37:28 -0400
Date: Wed, 10 Jul 2002 18:41:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Thomas Tonino <ttonino@users.sourceforge.net>
Cc: Jens Axboe <axboe@suse.de>, Thomas Tonino <ttonino@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Terrible VM in 2.4.11+?
Message-ID: <20020710164131.GC2513@dualathlon.random>
References: <20020709001137.A1745@mail.muni.cz> <1026167822.16937.5.camel@UberGeek> <20020709005025.B1745@mail.muni.cz> <20020708225816.GA1948@werewolf.able.es> <3D2BF3CC.3040409@users.sf.net> <20020710084904.GH3185@suse.de> <3D2C3C24.8090402@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D2C3C24.8090402@users.sf.net>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 03:52:36PM +0200, Thomas Tonino wrote:
> Jens Axboe wrote:
> 
> >That's probably not just a mm issue, if you use stock 2.4.18 with 4GB
> >ram you will spend oodles of time bounce buffering i/o. 2.4.19-pre9-aa2
> >includes the block-highmem stuff, which enables direct-to-highmem i/o,
> >if you enabled the CONFIG_HIGHIO option.
> 
> Indeed, highio seemed a feature I wanted, so I enabled it. But in the 
> 'stuck' state on the 2 GB 2.4.18 machine, the load is 75 while there is 
> no disk activity according to iostat, but shells perform slowly anyway 

I doubt the issue is highio here, the 75 load is probably because of 75
tasks deadlocked in D state, it's probably one of the many fixes in my
tree that avoided the deadlock for you.

If you provide a SYSRQ+T I would be more confortable though, so I can
tell you which of the fixes in my tree you need applied to mainline and
more important so I'm sure the problem is really just fixed in my tree.
I've no pending bugreport at the moment for -aa (the last emails for
rc1aa1 were all about acpi that didn't compile for smp, and I dropped it
in rc1aa2 until I get my poor broken laptop replaced).

thanks,

Andrea
