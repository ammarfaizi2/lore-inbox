Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267782AbRHJNCx>; Fri, 10 Aug 2001 09:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267836AbRHJNCn>; Fri, 10 Aug 2001 09:02:43 -0400
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:42741
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S267782AbRHJNCg>; Fri, 10 Aug 2001 09:02:36 -0400
Message-ID: <3B73DB6C.BEE29C03@math.ethz.ch>
Date: Fri, 10 Aug 2001 15:02:36 +0200
From: Giacomo Catenazzi <cate@math.ethz.ch>
Reply-To: cate@dplanet.ch
X-Mailer: Mozilla 4.75C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: Etienne Lorrain <etienne@masroudeau.com>
CC: linux-kernel@vger.kernel.org, Gujin-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] Gujin graphical bootloader 0.4
In-Reply-To: <fa.mdu6dgv.m10d9i@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Etienne Lorrain wrote:
 
>  These two files in memory have also to be at fixed linear
>  addresses in real mode - and if you have a memory manager
>  (himem.sys) loaded, these address may not be free. Usually
>  you will find at the bottom of the himem memory the smartdrv
>  (disk cache) data. It is then impossible to load a file at a random
>  memory address and stay in real mode to do futher processing.
>  In this case, Gujin is just malloc'ing the memory (using himem.sys),
>  loading and decompressing this file (checking its CRC32), and
>  only then disable interrupts, switch to protected mode, copy
>  the file at its intended linear address and jump to the kernel
>  code.
> 

hmm.

You say: BIOS/hardware can be broken, let use DOS do load Linux!

IMHO using DOS (himem.sys and letting DOS to setting our
hardware in ibmbio.com and ibmdos.com) give us more problem
that solution!

We should have complete control to hardware, not letting DOS
to hide/modify the BIOS segment 0040:0000 and some other
hardware setting.
Thus we should (if possible) use only BIOS call (or directly hardware),
but forget DOS. (BTW you know what DOS makes before himem.sys ?
Do we have the sources?)


	giacomo
