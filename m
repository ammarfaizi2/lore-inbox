Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277511AbRJERMp>; Fri, 5 Oct 2001 13:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277510AbRJERMg>; Fri, 5 Oct 2001 13:12:36 -0400
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:7002 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S277509AbRJERMV>; Fri, 5 Oct 2001 13:12:21 -0400
Posted-Date: Fri, 5 Oct 2001 09:50:11 GMT
Date: Fri, 5 Oct 2001 10:50:11 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Adam Keys <adam.keys@engr.smu.edu>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Development Setups
In-Reply-To: <20011005041759.OPDP14306.femail26.sdc1.sfba.home.com@there>
Message-ID: <Pine.LNX.4.21.0110051028080.11429-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam.

> As a budding kernel hacker looking to cut my teeth, I've become
> curious about what types of setups people hack the kernel with.
> I am very interested in descriptions of the computers you hack
> the kernel with and their use patterns.

Here's the collection I use...

 1. 386sx/16 with 8M of RAM running RedHat 6.0 as none of the later
    RedHat's will install on it - they all need >8M of RAM to install.
    This serves as my network print server.

 2. 386sx/25 with 387sx/25 with 8M of RAM running RedHat 6.1 as none
    of the later RedHat's will install on it, as stated above. It is
    noticable that the presence of a 387 maths copro allowed 6.1 to
    install where it wouldn't otherwise.

 3. 486sx/25 with 12M of RAM running RedHat 6.2 as none of the
    RedHat 7.x's will install, all needing >12M of RAM to install.

 4. 486dx2/66 with 16M of RAM running RedHat 6.2 and serving as my
    network dial-up server. It's stable as it currently stands, so
    is unlikely to be upgraded anytime soon.

 5. 486dx4/120 with 32M of RAM running RedHat 6.2 as RedHat 7.x runs
    out of hard disk space - it only has a 350M hard drive in it at
    the moment.

 6. P75 with 32M of RAM running Win95 so I can check that the Linux
    systems I set up for customers will correctly interact with any
    Win9x systems they may have, and also used to run the software
    I need to run that's only available for Win9x.

 7. P166 with 96M of RAM awaiting a new hard drive (the existing one
    self-destructed a week or so ago). Once the new hard drive is
    obtained, I'll be installing RedHat 7.1 on it.

Depending on what else I'm doing at the time, I can use any of the above
to "hack" the kernel, including the Win95 machine if everything else is
busy. I generally use (3) to compile the results on.

> I was thinking of starting with a modern machine for developing and
> compiling on, and then older machine(s) for testing. This way I
> would not risk losing data if I oops or somesuch.

> Alternately, is there a common practice of using lilo to create
> development and testing kernel command lines?

I have a lilo entry that reads as follows:

	image=/usr/src/linux/arch/i386/boot/bzImage
		label=tryme
		alias=develop

I also have a script set up for only root to run that reads...

	#!/bin/bash
	lilo && lilo -D develop && reboot

...which I run to try the kernel out.

> Is this a useful thing to do or is it too much of brain drain to
> switch between hacking and testing mindsets?

That depends on how you set your system up.

> Instead of having separate machines, there is the possibility of
> using the Usermode port. As I understand it this lags behind the -ac
> and linus kernels so it would be hard to test things like the new
> VM's. Usermode would not be suitable for driver development either.
> Again, thoughts on this mode of development?

I've never tried it, and have no plans to do so.

> Which brings me to the final question. Is there any reason to
> choose architecture A over architecture B for any reason besides
> arch-specific development in the kernel or for device drivers?

Not that I'm aware of.

Best wishes from Riley.

