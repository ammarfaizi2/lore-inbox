Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288980AbSBMVwk>; Wed, 13 Feb 2002 16:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288969AbSBMVwa>; Wed, 13 Feb 2002 16:52:30 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:50951 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S288980AbSBMVwM>; Wed, 13 Feb 2002 16:52:12 -0500
Date: Wed, 13 Feb 2002 16:51:07 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ? 
In-Reply-To: <Pine.LNX.3.95.1020213111701.17207A-101000@chaos.analogic.com>
Message-ID: <Pine.LNX.3.96.1020213163646.12448B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Richard B. Johnson wrote:

> The advantage, of course is that if you are executing the kernel,
> it can give you all the information necessary to recreate a
> new one from the sources because its .config is embeded into
> itself. Once you have the ".config" file, you just do `make oldconfig`
> and you are home free.

But it does no such thing! You not only need the config file, you need the
source. So you now need to add to the kernel the entire source tree from
which it was built, or perhaps just a diff file from a kernel.org source,
which you will suitably compress, of course.

And without all that information you can't be sure of being able to build
a working kernel, only of knowing what options you selected, but not what
they (exactly) meant. Don't forget to save the C compiler and any
libraries and system include files inn the kernel as well, can't be half
safe.

This feature just isn't all that useful, I use an install script which
does copy the config file, compresses it into a zip with a file comment of
the MD5 of the kernel image, and adds the Makefile as well. I build
kernels almost every week, I support a whole raft of machines, and after I
got this whole nice script running I have used about twice a year.

I don't want anything added to my boot kernel image which isn't absolutely
needed to get the machine up, not documentation, not digitized cartoons,
not comments, etc. This is not an issue if you boot from a fat multi-GB
hard drive, it is if you boot from ROM, Compact flash pretending to be a
tiny IDE disk, need to be able to recovery boot from floppy, etc.

The feature would be nice, but "I can't manage to keep my kernel and
modules together" is not reason to oppose putting config in a module, or a
text file, or anywhere better organized people WOULD be able to find it.
If you want an option to put all that stuff you don't need into the boot
image, go to it, just don't make it useless to other people.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

