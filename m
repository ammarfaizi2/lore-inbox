Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267562AbTAQP5I>; Fri, 17 Jan 2003 10:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267552AbTAQP5I>; Fri, 17 Jan 2003 10:57:08 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:11532 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267566AbTAQP5H>; Fri, 17 Jan 2003 10:57:07 -0500
Date: Fri, 17 Jan 2003 16:05:59 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Gregoire Favre <greg@ulima.unil.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: atyfb don't build under 2.5.59
In-Reply-To: <20030117092936.GA21797@ulima.unil.ch>
Message-ID: <Pine.LNX.4.44.0301171605140.24931-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ug. Typo in make file. Could you change in drivers/video/Makefile one of 
the cfbimgblt.o after aty/ into cfbcopyarea.o. I will fix in my CVS.

> Hello,
> 
> I got:
> 
> make -f scripts/Makefile.build obj=init
>   Generating include/linux/compile.h (updated)
>   gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium3 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=version -DKBUILD_MODNAME=version   -c -o init/version.o init/version.c
>    ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/do_mounts.o init/initramfs.o init/vermagic.o
>   	ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
> drivers/built-in.o(.text+0x798da): In function `atyfb_copyarea':
> : undefined reference to `cfb_copyarea'
> make: *** [.tmp_vmlinux1] Error 1
> 
> 	Grégoire
> ________________________________________________________________
> http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

