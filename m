Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbUKHGcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbUKHGcn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 01:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbUKHGcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 01:32:43 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:12036 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261749AbUKHGck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 01:32:40 -0500
Date: Mon, 8 Nov 2004 07:30:37 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, ink@jurassic.park.msu.ru
Subject: Re: Linux 2.4.28-rc2
Message-ID: <20041108063037.GC783@alpha.home.local>
References: <20041107173753.GB30130@logos.cnet> <20041108053216.GA19522@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108053216.GA19522@alpha.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, just replying to myself.

I found an old gcc-2.91.66 which compiled it correctly on this machine. So
it might be a compiler/binutils issue.

Regards,
willy

On Mon, Nov 08, 200 at 06:32:17AM +0100, Willy Tarreau wrote:
> Hi Marcelo,
> 
> just started a compile on alpha last night and looked at the results this
> morning. 'make vmlinux' ends with the following errors. It is fairly possible
> that it comes from my gcc/binutils combination (because I found that I compiled
> previous kernels with gcc 3.2.3), in which case I will fix it later, but I'd
> like someone with an alpha to check it on his side before the final release.
> 
> Cheers,
> Willy
> 
> bash-2.03$ gcc -v
> Reading specs from /usr/lib/gcc-lib/alphaev6-unknown-linux-gnu/3.3.4/specs
> Configured with: ../gcc-3.3.4/configure --prefix=/usr --enable-version-specific-runtime-libs --enable-languages=c,c++ --disable-nls --disable-locale --enable-shared --enable-threads --program-suffix=-3.3 --enable-target-optspace --with-gnu-ld --with-gnu-as
> Thread model: posix
> gcc version 3.3.4
> 
> bash-2.03$ ld -v
> GNU ld version 2.11.90.0.15 (with BFD 2.11.90.0.15)
> 
> bash-2.03$ make vmlinux
> ...
> arch/alpha/mm/mm.o: In function `get_pgd_slow':
> arch/alpha/mm/mm.o(.text+0x5c): relocation truncated to fit: GPRELHIGH rodata.cst8
> ipc/ipc.o: In function `sys_semtimedop':
> ipc/ipc.o(.text+0x3854): relocation truncated to fit: GPRELHIGH rodata.cst8
> drivers/char/char.o: In function `kmem_vm_nopage':
> drivers/char/char.o(.text+0xc48): relocation truncated to fit: GPRELHIGH rodata.cst8
> drivers/char/char.o: In function `vt_ioctl':
> drivers/char/char.o(.text+0xdf5c): relocation truncated to fit: GPRELHIGH rodata.cst8
> drivers/char/char.o: In function `rs_wait_until_sent':
> drivers/char/char.o(.text+0x1e4dc): relocation truncated to fit: GPRELHIGH rodata.cst8
> drivers/block/block.o: In function `blk_seg_merge_ok':
> drivers/block/block.o(.text+0x328): relocation truncated to fit: GPRELHIGH rodata.cst8
> drivers/block/block.o: In function `ll_back_merge_fn':
> drivers/block/block.o(.text+0x3d8): relocation truncated to fit: GPRELHIGH rodata.cst8
> drivers/block/block.o: In function `ll_front_merge_fn':
> drivers/block/block.o(.text+0x4a8): relocation truncated to fit: GPRELHIGH rodata.cst8
> drivers/block/block.o: In function `ll_merge_requests_fn':
> drivers/block/block.o(.text+0x578): relocation truncated to fit: GPRELHIGH rodata.cst8
> drivers/block/block.o: In function `fdc_specify':
> drivers/block/block.o(.text+0x56c0): relocation truncated to fit: GPRELHIGH rodata.cst8
> /data/projets/dev/linux/trees/linux-2.4.28-rc2/lib/lib.a(bust_spinlocks.o): In function `bust_spinlocks':
> bust_spinlocks.o(.text+0x60): relocation truncated to fit: GPRELHIGH rodata.str1.1
> make: *** [vmlinux] Error 1
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
