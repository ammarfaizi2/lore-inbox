Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317858AbSHDO7G>; Sun, 4 Aug 2002 10:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317859AbSHDO7G>; Sun, 4 Aug 2002 10:59:06 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:40943 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317858AbSHDO7F>; Sun, 4 Aug 2002 10:59:05 -0400
Date: Sun, 4 Aug 2002 17:02:33 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Keith Owens <kaos@ocs.com.au>
cc: Willy Tarreau <willy@w.ods.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19 make allmodconfig - undefined symbols 
In-Reply-To: <1876.1028467344@ocs3.intra.ocs.com.au>
Message-ID: <Pine.NEB.4.44.0208041659070.1422-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Aug 2002, Keith Owens wrote:

> On Sun, 4 Aug 2002 14:35:13 +0200,
> Willy Tarreau <willy@w.ods.org> wrote:
> >On Sun, Aug 04, 2002 at 08:13:20PM +1000, Keith Owens wrote:
> >> 2.4.19 make allmodconfig.  Besides the perennial drivers/net/wan/comx.o
> >> wanting proc_get_inode, there was only one undefined symbol.  In the
> >> extremely unlikely event that binfmt_elf is a module (how do you load
> >> modules when binfmt_elf is a module?), smp_num_siblings is unresolved.
> >
> >I also get an unresolved reference to __io_virt_debug in misc.o:puts()
> >when building bzImage. If you don't get it, it means that my tree is
> >corrupted.
>
> Neither.  It is a problem with CONFIG_DEBUG_IOVIRT which allmod and
> allyesconfig turn on.  My builds stop at vmlinux and do not build
> bzImage so I did not detect this problem.  The outb_p calls in misc.c
> need fixing for CONFIG_DEBUG_IOVIRT=y, or force CONFIG_DEBUG_IOVIRT=n.
>...

More exactly it's a problem that only occurs with CONFIG_MULTIQUAD
enabled. The thread starting with [1] contains a discussion of this bug
and the patch used to fix it in 2.5.

cu
Adrian

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=102079707313304&w=2


-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

