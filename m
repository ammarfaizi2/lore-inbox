Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157643AbQGaRSD>; Mon, 31 Jul 2000 13:18:03 -0400
Received: by vger.rutgers.edu id <S157626AbQGaRQ3>; Mon, 31 Jul 2000 13:16:29 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1490 "EHLO chaos.analogic.com") by vger.rutgers.edu with ESMTP id <S157583AbQGaRMb>; Mon, 31 Jul 2000 13:12:31 -0400
Date: Mon, 31 Jul 2000 13:35:48 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: RLIM_INFINITY inconsistency between archs
In-Reply-To: <7iw6kYsXw-B@khms.westfalen.de>
Message-ID: <Pine.LNX.3.95.1000731132321.529A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On 31 Jul 2000, Kai Henningsen wrote:

> pollard@tomcat.admin.navo.hpc.mil (Jesse Pollard)  wrote on 27.07.00 in <200007271531.KAA89926@tomcat.admin.navo.hpc.mil>:
> 
> > Might I suggest creating a "/lib/include" that works something like
> > the /lib/modules where the kernel name is used to generate the directory
> > for the kernel include files?
> >
> > That way the "uname -r" command could be used to set a symbolic link
> > to point to the correct include files at boot time (or install time).
> 
> Correct for what?
> 

I must be able to build kernel modules for a kernel version that I
am not yet running. This is not related in any way to what I get from
`uname -r`. Further, I may be building the kernel for an Alpha on
an Intel machine, using a cross-compiler.

The de-facto standard has been that /usr/src/linux is a sym-link to
the kernel version you wish to build. Why is this expected to be
changed?

Since this is a symbolic link, it can cross device boundaries. This
makes it very versatile.

 /usr/include/linux and /usr/include/asm are symbolic links, referenced
to /usr/src/linux, not a specific version. This makes changing kernel
development versions a simple change of a single symbolic link.

Why would anybody change this? I fear that this is another of those;
"It doesn't have to be better, only different..." things that have
been going around.

Cheers,
Dick Johnson

Penguin: Linux version 2.2.15 on an i686 machine (797.90 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
