Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262783AbSKROxE>; Mon, 18 Nov 2002 09:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbSKROxE>; Mon, 18 Nov 2002 09:53:04 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:1545 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S262783AbSKROxE>; Mon, 18 Nov 2002 09:53:04 -0500
From: Rene Blokland <reneb@orac.aais.org>
Subject: Re: [PATCH] Re: 2.5.48 Compilation Failure skbuff.c
Date: Mon, 18 Nov 2002 15:40:04 +0100
Organization: Cistron
Message-ID: <slrnathuu3.ua9.reneb@orac.aais.org>
References: <20021118125450.GA14855@outpost.ds9a.nl> <Mutt.LNX.4.44.0211190013030.22010-100000@blackbird.intercode.com.au>
Reply-To: reneb@cistron.nl
X-Trace: ncc1701.cistron.net 1037631603 5451 195.64.94.30 (18 Nov 2002 15:00:03 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Mutt.LNX.4.44.0211190013030.22010-100000@blackbird.intercode.com.au>, James Morris wrote:
> On Mon, 18 Nov 2002, bert hubert wrote:
> 
>> On Mon, Nov 18, 2002 at 01:36:48PM +0100, Rene Blokland wrote:
>> > Hello, 2.5.48 Doesn't compile for me on a AMD k6-3 with gcc-3.2 and glibc-2.3.1

> 
> A fix is below.
It would be great if this solved everything but :


  Generating include/linux/compile.h (updated)
  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=version -DKBUILD_MODNAME=version   -c -o init/version.o init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/do_mounts.o init/initramfs.o
  	ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
init/built-in.o(.init.text+0x660): In function `start_kernel':
: undefined reference to `extable_init'
make: *** [vmlinux] Error 1



-- 
Groeten / Regards, Rene J. Blokland

