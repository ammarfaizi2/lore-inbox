Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318202AbSIOTWl>; Sun, 15 Sep 2002 15:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318208AbSIOTWl>; Sun, 15 Sep 2002 15:22:41 -0400
Received: from packet.digeo.com ([12.110.80.53]:3475 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318202AbSIOTWk>;
	Sun, 15 Sep 2002 15:22:40 -0400
Message-ID: <3D84E2DB.6B189E7A@digeo.com>
Date: Sun, 15 Sep 2002 12:43:23 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Daniel Phillips <phillips@arcor.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
References: <E17qRfU-0001qz-00@starship> <Pine.LNX.4.44.0209151103170.10830-100000@home.transmeta.com> <20020915190435.GA19821@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Sep 2002 19:27:28.0498 (UTC) FILETIME=[EDB6CD20:01C25CED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz wrote:
> 
> ...
> As it was, there is no 2.5 / i386 port of KGDB as far as I know;

I have kgdb for every kernel back to 2.4.0-something.  Have a
fish around in http://www.zip.com.au/~akpm/linux/patches/

> ...
> I've always thought it would be useful.  Sure, everyone debugs
> differently; but a number of people seem to agree with me that KGDB is
> convenient.
> 

I suspect the example which you give is not a very typical one.  Generally
people use kgdb for poking around looking at kernel state.  I almost never
single-step.  I set breakpoints so that I can inspect state within a
particular context, and for coverage testing ("is this path being executed").

Also as a replacement for printk/rebuild/reboot.

Also for inspecting ad-hoc instrumentation: just add `some_global_int++;'
and then take a look at its value - much quicker than exposing it via /proc.

It's also very good to have kgdb on hand when you happen to hit a
really rare bug - I hit a weirdo request queue corruption thing the
other day, an hour into a `dbench 1024' run.  Was able to get a
decent amount of information.  Heaven knows how long it would take
to make that bug trigger a second time...
