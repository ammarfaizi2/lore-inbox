Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261457AbSJYQC5>; Fri, 25 Oct 2002 12:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261460AbSJYQC5>; Fri, 25 Oct 2002 12:02:57 -0400
Received: from franka.aracnet.com ([216.99.193.44]:44461 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261457AbSJYQC4>; Fri, 25 Oct 2002 12:02:56 -0400
Date: Fri, 25 Oct 2002 09:06:43 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrey Nekrasov <andy@spylog.ru>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.44-ac3 - don't compile.
Message-ID: <2925311195.1035536802@[10.10.2.3]>
In-Reply-To: <20021025131349.GA25980@an.local>
References: <20021025131349.GA25980@an.local>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Odd. I'm sure akpm fixed this in 44, unless -ac3 reverts it.
Can you search back for posts by Andrew Morton, and find the
fix, and try it?

M.

--On Friday, October 25, 2002 5:13 PM +0400 Andrey Nekrasov <andy@spylog.ru> wrote:

> Hello.
> 
> 
>  x86, no SMP.
> 
> 
> ...
> make -f init/Makefile 
>   Generating init/../include/linux/compile.h (updated)
>   gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
> -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic
> -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=version
> -c -o init/version.o init/version.c
>    ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o
> init/do_mounts.o
>         ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o
> arch/i386/kernel/init_task.o  init/built-in.o --start-group
> arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o
> arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o
> ipc/built-in.o  security/built-in.o  lib/lib.a  arch/i386/lib/lib.a
> drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o
> --end-group  -o vmlinux
> arch/i386/kernel/built-in.o: In function `MP_processor_info':
> arch/i386/kernel/built-in.o(.init.text+0x46a3): undefined reference to `Dprintk'
> arch/i386/kernel/built-in.o(.init.text+0x46b6): undefined reference to `Dprintk'
> arch/i386/kernel/built-in.o(.init.text+0x46c9): undefined reference to `Dprintk'
> arch/i386/kernel/built-in.o(.init.text+0x46dc): undefined reference to `Dprintk'
> arch/i386/kernel/built-in.o(.init.text+0x46ef): undefined reference to `Dprintk'
> arch/i386/kernel/built-in.o(.init.text+0x4702): more undefined references to
> `Dprintk' follow
> make: *** [vmlinux] Error 1
> ...
> 
> Why?
> 
> 
> 
> -- 
> bye.
> Andrey Nekrasov, SpyLOG.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


