Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313352AbSDESIw>; Fri, 5 Apr 2002 13:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313355AbSDESIm>; Fri, 5 Apr 2002 13:08:42 -0500
Received: from hitchcock.mail.mindspring.net ([207.69.200.23]:27929 "EHLO
	hitchcock.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S313352AbSDESI1>; Fri, 5 Apr 2002 13:08:27 -0500
Date: Fri, 05 Apr 2002 13:08:26 -0500
From: <joeja@mindspring.com>
To: linux-kernel@vger.kernel.org
Reply-To: joeja@mindspring.com
Subject: Re: Re: Re: faster boots?
Message-ID: <Springmail.0994.1018030106.0.22918200@webmail.atl.earthlink.net>
X-Originating-IP: 4.20.162.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone pointed out that I may have to much stuff built into the kernel and that I should try modularizing it.  Only builing in what I need to boot and the rest as modules. 

This may be true.

It is easier IMHO to configure a NetBSD kernel or FreeBSD kernel with just what you need in the system because dmesg is more helpful IHMO on those systems.

dmesg for netbsd prints stuff like

pckbc0: using irq 12 for aux slot

and in its kernel config file there will be a line something like

pckbc* irq* 

or something.  Thus someone wrote a nifty little perl script that can go through dmesg and comment out of the config what is not found by the generic kernel (or the kernel installed at that time).  This helped reduce my netbsd kernel from 3.6M to about 2.1M and speed up the machine some.

FreeBSD is very similar to this.  Only I think it tends to have more modules in the default generic kernel.

Linux on the other hand prints out all this other stuff which makes it harder IMHO to determine weather or not you need driver foo built into the kernel.  Thus I know that when I build a Linux kernel there is stuff that is in it that I don't need but don't know what it is.

Also the bsd's run 'config' against the config file which actually checks to see if the config file that was edited is actually going to build and it also updates some other stuff.  Although that is not 100% accurate, but a big help.

So what is the best way in Linux to figure out what you can remove from the kernel to make it smaller and boot hopefully faster on low end machines?

Joe





