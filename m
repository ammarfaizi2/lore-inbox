Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261401AbREZRhY>; Sat, 26 May 2001 13:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbREZRhP>; Sat, 26 May 2001 13:37:15 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:41245 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261401AbREZRg4>; Sat, 26 May 2001 13:36:56 -0400
Date: Sat, 26 May 2001 19:36:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Ingo T. Storm" <it@lapavoni.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 does not link on Ruffian (alpha)
Message-ID: <20010526193649.B1834@athlon.random>
In-Reply-To: <3B0BFE90.CE148B7@kjist.ac.kr> <20010523210923.A730@athlon.random> <022e01c0e5fc$39ac0cf0$2e2ca8c0@buxtown.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <022e01c0e5fc$39ac0cf0$2e2ca8c0@buxtown.de>; from it@lapavoni.de on Sat, May 26, 2001 at 05:20:29PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2001 at 05:20:29PM +0200, Ingo T. Storm wrote:
> sys_dp264.o: In function `tsunami_inb':
> sys_dp264.c(.text+0x440): multiple definition of `tsunami_inb'
> core_tsunami.o(.text+0x500):core_tsunami.c: first defined here
> sys_dp264.o: In function `clipper_map_irq':
> sys_dp264.c(.text+0x480): multiple definition of `tsunami_inw'
> core_tsunami.o(.text+0x540):core_tsunami.c: first defined here
> sys_dp264.o: In function `tsunami_inl':
> sys_dp264.c(.text+0x4c0): multiple definition of `tsunami_inl'
> core_tsunami.o(.text+0x580):core_tsunami.c: first defined here
> sys_dp264.o: In function `tsunami_outb':
> sys_dp264.c(.text+0x460): multiple definition of `tsunami_outb'
> core_tsunami.o(.text+0x520):core_tsunami.c: first defined here
> sys_dp264.o: In function `tsunami_outw':
> sys_dp264.c(.text+0x4a0): multiple definition of `tsunami_outw'
> core_tsunami.o(.text+0x560):core_tsunami.c: first defined here
> sys_dp264.o: In function `dp264_init_pci':
> sys_dp264.c(.text+0x4e0): multiple definition of `tsunami_outl'
> core_tsunami.o(.text+0x5a0):core_tsunami.c: first defined here
> sys_dp264.o: In function `tsunami_readb':
> sys_dp264.c(.text+0x540): multiple definition of `tsunami_readb'
> core_tsunami.o(.text+0x600):core_tsunami.c: first defined here
> sys_dp264.o: In function `tsunami_readw':
> sys_dp264.c(.text+0x560): multiple definition of `tsunami_readw'
> core_tsunami.o(.text+0x620):core_tsunami.c: first defined here
> sys_dp264.o: In function `webbrick_init_arch':
> sys_dp264.c(.text+0x580): multiple definition of `tsunami_readl'
> core_tsunami.o(.text+0x640):core_tsunami.c: first defined here
> sys_dp264.o: In function `tsunami_readq':
> sys_dp264.c(.text+0x5a0): multiple definition of `tsunami_readq'
> core_tsunami.o(.text+0x660):core_tsunami.c: first defined here
> sys_dp264.o: In function `tsunami_writeb':
> sys_dp264.c(.text+0x5c0): multiple definition of `tsunami_writeb'
> core_tsunami.o(.text+0x680):core_tsunami.c: first defined here
> sys_dp264.o: In function `tsunami_writew':
> sys_dp264.c(.text+0x5e0): multiple definition of `tsunami_writew'
> core_tsunami.o(.text+0x6a0):core_tsunami.c: first defined here
> sys_dp264.o: In function `tsunami_writel':
> sys_dp264.c(.text+0x600): multiple definition of `tsunami_writel'
> core_tsunami.o(.text+0x6c0):core_tsunami.c: first defined here
> sys_dp264.o: In function `tsunami_writeq':
> sys_dp264.c(.text+0x620): multiple definition of `tsunami_writeq'
> core_tsunami.o(.text+0x6e0):core_tsunami.c: first defined here
> sys_dp264.o: In function `tsunami_ioremap':
> sys_dp264.c(.text+0x500): multiple definition of `tsunami_ioremap'
> core_tsunami.o(.text+0x5c0):core_tsunami.c: first defined here
> sys_dp264.o: In function `monet_init_pci':
> sys_dp264.c(.text+0x520): multiple definition of `tsunami_is_ioaddr'
> core_tsunami.o(.text+0x5e0):core_tsunami.c: first defined here
> make[1]: *** [kernel.o] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.4.5/arch/alpha/kernel'
> make: *** [_dir_arch/alpha/kernel] Error 2

I got exactly the above when compiling for dp264 so I sent to Linus a
patch to fix those compile problems, now I suspect my fix broke the
generic compile :(, I will check that.

Andrea
