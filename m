Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbTEVH2y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 03:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbTEVH2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 03:28:53 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:59405 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S262538AbTEVH2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 03:28:52 -0400
Date: Thu, 22 May 2003 09:41:40 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: bk15 build fails with modular apm (undefined reference to MODULE_OWNER)
Message-ID: <20030522074140.GA27488@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20030522064746.GA5202@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030522064746.GA5202@middle.of.nowhere>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jurriaan <thunder7@xs4all.nl>
Date: Thu, May 22, 2003 at 08:47:46AM +0200
>   gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=
> version -DKBUILD_MODNAME=version -c -o init/version.o init/version.c
>    ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/mounts.o init/initramfs.o
>         ld -m elf_i386  -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o --start-gro
> up  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/bu
> ilt-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o
> sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
> arch/i386/kernel/built-in.o(.init.text+0x5744): In function `apm_init':
> : undefined reference to `SET_MODULE_OWNER'
> make: *** [.tmp_vmlinux1] Error 1
> :
> 
> Is SET_MODULE_OWNER needed or not?
> Browsing the source it seems it is defined as a nop in some places
> (include/linux/netdevice.h) which is where it is mostly used...
> 
Sorry for not being clear the first time:

this is _not_ with apm modular, but with CONFIG_APM=y.

Jurriaan
-- 
In the middle of a good time
Truth gave me her icy kiss
Look around, you must be joking
	Oysterband - All that way for this
Debian (Unstable) GNU/Linux 2.5.69-bk11 4104 bogomips load av: 0.26 0.21 0.22
