Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131447AbRCKQlQ>; Sun, 11 Mar 2001 11:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131448AbRCKQlG>; Sun, 11 Mar 2001 11:41:06 -0500
Received: from cmailg7.svr.pol.co.uk ([195.92.195.177]:1289 "EHLO
	cmailg7.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S131447AbRCKQlB>; Sun, 11 Mar 2001 11:41:01 -0500
Date: Sun, 11 Mar 2001 16:35:50 +0000 (GMT)
From: Chris Andrews <chris@netsw.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.1 on RHL 6.2
Message-ID: <Pine.LNX.4.21.0103111625500.1297-100000@rhododendron.symes.netsw.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >Make sure you have the following symlinks in your /usr/include 
> >directory, assuming you're on an x86 machine: 
> > 
> >asm -> /usr/src/linux/include/asm-i386/ 
> >linux -> /usr/src/linux/include/linux/ 
>
> Note! You only have to have those symlinks on broken systems such 
> as Redhat. 
>
> Sane systems such as Debian have a copy of the kernel header files 
> that the C library was compiled against in /usr/include/{linux,asm} 
> instead of symlinks to the kernel source. Do not play the symlink 
> trick on those systems. 
>
> Before this turns into a flamewar: this has been discussed 20 or 
> so times before, and both Linus and the glibc developers agree 
> that you a distribution should do the latter. The headers you use 
> to compile userland binaries should be the same as the C library 
> was compiled against. 

I've been following this advice for some time, but doing so tripped me up.
My system is RH 6.2, but with kernel 2.4 (and latest modutils etc). I
kept my kernel headers at 2.2.14, i.e. those supplied with the 6.2
kernel-headers RPM.

This breaks XFree 86 4, however, which checks the kernel version you are
*running* and then expects the headers for that kernel to be available. To
build X I had to move the symlink to point at some 2.4 headers so X could
find (IIRC) input.h, and others. 

So what's at fault here? X for looking at the current kernel, me for not
telling X not to do that, or me again for not recompiling glibc and using
the new headers 'legally'?

Chris.

