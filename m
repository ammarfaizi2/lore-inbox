Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310482AbSCPRkX>; Sat, 16 Mar 2002 12:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310488AbSCPRkO>; Sat, 16 Mar 2002 12:40:14 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:28557 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S310482AbSCPRkB>;
	Sat, 16 Mar 2002 12:40:01 -0500
Date: Sat, 16 Mar 2002 12:39:56 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.5.7-pre2 -- kernel.o(.data+0x300): undefined
 reference
In-Reply-To: <E16mI91-0006mI-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0203161236200.5891-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Mar 2002, Alan Cox wrote:

> > +/* "Conditional" syscalls */
> > +
> > +asmlinkage long sys_nfsservctl(void) __attribute__ ((weak, alias ("sys_ni_syscall")));
> > +asmlinkage long sys_quotactl(void) __attribute__ ((weak, alias ("sys_ni_syscall")));
> > +
> 
> This is what Linus threw out before - when David wanted to use it to remove
> all the intermodule crap.
> 
> It doesn't work with some architecture binutils

Erm...  In this case we are within statatically linked image.  In which
situations it doesn't work?  AFAICS it's as straightforward use of weak
aliases as it gets...

