Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310530AbSCPSRd>; Sat, 16 Mar 2002 13:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310529AbSCPSRX>; Sat, 16 Mar 2002 13:17:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17414 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310516AbSCPSRU>; Sat, 16 Mar 2002 13:17:20 -0500
Date: Sat, 16 Mar 2002 10:15:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Alexander Viro <viro@math.psu.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.5.7-pre2 -- kernel.o(.data+0x300): undefined
 reference
In-Reply-To: <E16mI91-0006mI-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0203161011150.31850-100000@penguin.transmeta.com>
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

How true is that these days, though? We are at the point where we don't
have to worry about COFF and a.out architectures (as far as the kernel is
concerned, of course - whatever binftm format is loaded in user mode is a
different thing). 

On a related tangent - maybe we should just get rid of SYMBOL_NAME etc 
crap? I don't think we've been able to compile a a.out kernel in about 5 
years or so, and that was the only thing that needed the magic prepended 
underscores etc?

			Linus

