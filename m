Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317666AbSGJXLU>; Wed, 10 Jul 2002 19:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317668AbSGJXLT>; Wed, 10 Jul 2002 19:11:19 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:17093 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S317666AbSGJXLR>;
	Wed, 10 Jul 2002 19:11:17 -0400
Date: Thu, 11 Jul 2002 01:13:35 +0200
From: David Weinehall <tao@acc.umu.se>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Patch for Menuconfig script
Message-ID: <20020710231335.GG29001@khan.acc.umu.se>
References: <20020708151412.GB695@opus.bloom.county> <21071.1026168807@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21071.1026168807@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2002 at 08:53:27AM +1000, Keith Owens wrote:
> On Mon, 8 Jul 2002 08:14:12 -0700, 
> Tom Rini <trini@kernel.crashing.org> wrote:
> >On Sun, Jul 07, 2002 at 11:22:10PM +0100, Riley Williams wrote:
> >> > This is just a patch to the Menuconfig script (can be easily adapted
> >> > to the other ones) that allows you to configure the kernel without
> >> > the requirement of bash (I tested it with ksh, in POSIX-only mode).  
> >> > Feel free to flame me :P
> >> 
> >> Does it also work in the case where the current shell is csh or tcsh
> >> (for example)?
> >
> >Er.. why wouldn't it?
> >$ head -1 scripts/Menuconfig 
> >#! /bin/sh
> 
> The #! line is irrelevant.  The script is invoked via
> 
>   $(CONFIG_SHELL) scripts/Menuconfig arch/$(ARCH)/config.in
> 
> Large chunks of kbuild assume that CONFIG_SHELL is bash.  Don't bother
> trying to cleanup all the code that assumes bash, just
>   make CONFIG_SHELL=/path/to/bash ...

As long as the new, bash-ignorant code is as good as the old one, and
works equally well with bash and hopefully better with other shells,
I see no harm, and a lot of benefit, in accepting the patch.

Yes, a lot of code assumes bash is there, but unlike the case of gcc,
there are good alternatives. Let us enable people who use
ksh/tcsh/rc/whatever as their main shell to remove the bash they keep
installed simply to be able to build their kernels.

For those who wonders: I use bash, nothing else. Still I think it is
silly to argue against this kind of patches because a lot of other
parts of the build-system/config-systems till depends on bash.

Getting rid of the bash:isms everywhere is far from impossible; look at
Debian, they are mostly there.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
