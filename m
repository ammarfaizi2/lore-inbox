Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310524AbSCPTT2>; Sat, 16 Mar 2002 14:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310528AbSCPTTN>; Sat, 16 Mar 2002 14:19:13 -0500
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:51399 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S310516AbSCPTS7>;
	Sat, 16 Mar 2002 14:18:59 -0500
Date: Sat, 16 Mar 2002 14:18:29 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.5.7-pre2 -- kernel.o(.data+0x300): undefined reference
Message-ID: <20020316141829.A30617@nevyn.them.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0203160515240.5891-100000@weyl.math.psu.edu> <E16mI91-0006mI-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16mI91-0006mI-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 05:39:03PM +0000, Alan Cox wrote:
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

As of at least 2.11.2 (fairly certain) and 2.12 (definite) this should
work on every architecture...

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
