Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289952AbSAKNcB>; Fri, 11 Jan 2002 08:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289951AbSAKNbv>; Fri, 11 Jan 2002 08:31:51 -0500
Received: from codeblau.walledcity.de ([212.84.209.34]:32518 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id <S289952AbSAKNbg>;
	Fri, 11 Jan 2002 08:31:36 -0500
Date: Fri, 11 Jan 2002 14:31:50 +0100
From: Felix von Leitner <felix-dietlibc@fefe.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, felix-dietlibc@fefe.de,
        andersen@codepoet.org
Subject: Re: [RFC] klibc requirements, round 2
Message-ID: <20020111133150.GI21447@codeblau.de>
In-Reply-To: <20020110231849.GA28945@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020110231849.GA28945@kroah.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Greg KH (greg@kroah.com):
>   - klibc
>     Portability can be achieved through using the kernel unistd.h file
>     for the syscall logic, and having a very small _start function
>     written.  For an example of this kind of code, see the initramfs
>     patches from Al Viro on his ftp site:
> 	    ftp://ftp.math.psu.edu/pub/viro/
>     This would involve writing/porting a lot of the basic library
>     functions.  They could be copied from the existing libc
>     implementations, but this would be a separate project, requiring
>     maintenance over time, and people willing to do the work.

Portability should be achieved by using unified syscalls, which both the
diet libc and uClibc now use.  That saves space over the unistd.h
approach.

> How about responses from the dietlibc and uClibc people on the odds of
> them being able to port to the remaining platforms?

I think I can speak for both Erik and myself when I say that we don't
hate architectures and because of that don't support them.  If we get a
chance (and maybe a little help from someone who knows those platform),
we will port our libc to that platform.

Sadly, I don't have the deep pockets to buy myself a hardware lab with a
VAX to port my libc to it.  So I (and Erik, too, obviously) would need
at least an account on one of those boxes, with gcc, binutils, strace
and gdb installed.

> In the meantime, I'll go off and play with klibc, and see if I can get
> some portability based off of Al's example code.  If anyone is
> interested, the code can be found at:
> 	http://linuxusb.bkbits.net:8088/klibc

In my eyes that is a waste of time, really.
But it's your time, so don't let that stand in your way ;)

Felix
