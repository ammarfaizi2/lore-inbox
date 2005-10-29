Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbVJ2LAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbVJ2LAv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 07:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbVJ2LAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 07:00:51 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30981 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750860AbVJ2LAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 07:00:51 -0400
Date: Sat, 29 Oct 2005 13:00:49 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Per Jessen <per@computer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: building 2.4.31 for a non-smp system
Message-ID: <20051029110049.GH4180@stusta.de>
References: <43633721.9010001@computer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43633721.9010001@computer.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 10:47:29AM +0200, Per Jessen wrote:

> I'm upgrading a box from 2.4.23 to .31, but I'm seeing lots of errors
> along these lines:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.31/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   
> -nostdinc -iwithprefix include -DKBUILD_BASENAME=tty_ioctl
> -DEXPORT_SYMTAB -c tty_ioctl.c
> In file included from /usr/src/linux-2.4.31/include/linux
> modversions.h:177,
>                 from /usr/src/linux-2.4.31/include/linux/module.h:22,
>                 from tty_ioctl.c:21:
> /usr/src/linux-2.4.31/include/linux/modules/ksyms.ver:576:1: warning:
> "del_timer_sync" redefined
>...
> The redefinition of "set_cpus_allowed" and "del_timer_sync" only happen
> when CONFIG_SMP isn't set.  
> I guess I could simply compile with CONFIG_SMP, but surely something's
> not right here?
> 
> Follow-up:
> OK, I've built the kernel with SMP support, and I'm not seeing the above 
> any longer. However, when I tried to load module nfsd, I get:
> 
> /lib/modules/2.4.31/kernel/net/sunrpc/sunrpc.o: unresolved symbol 
> kernel_flag_cacheline
> /lib/modules/2.4.31/kernel/net/sunrpc/sunrpc.o: unresolved symbol 
> atomic_dec_and_lock
> /lib/modules/2.4.31/kernel/net/sunrpc/sunrpc.o: insmod 
> /lib/modules/2.4.31/kernel/net/sunrpc/sunrpc.o failed
> /lib/modules/2.4.31/kernel/net/sunrpc/sunrpc.o: insmod nfsd failed

Please send:
- your .config
- the output of "bash scripts/ver_linux"

> Per Jessen, Zurich

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

