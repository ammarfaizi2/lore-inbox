Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266438AbSKZRzB>; Tue, 26 Nov 2002 12:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266453AbSKZRzB>; Tue, 26 Nov 2002 12:55:01 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:2432 "EHLO
	bilbo.tmr.com") by vger.kernel.org with ESMTP id <S266438AbSKZRzA>;
	Tue, 26 Nov 2002 12:55:00 -0500
Date: Sat, 23 Nov 2002 14:31:26 -0500 (EST)
From: davidsen <root@tmr.com>
To: davidsen@tmr.com
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.47-ac6 PCMCIA network modules
In-Reply-To: <Pine.LNX.4.44.0211231420040.17379-200000@bilbo.tmr.com>
Message-ID: <Pine.LNX.4.44.0211231428070.17680-100000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Nov 2002 I wrote:

> Just FYI, I try built-in or dig up the export.
No, it's more broken than that. I'll try 2.5.49 before trying to fix it...

   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/do_mounts.o init/initramfs.o
  	ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o  lib/lib.a  arch/i386/lib/lib.a --end-group  -o .tmp_vmlinux1
drivers/built-in.o: In function `media_check':
drivers/built-in.o(.text+0x3c536): undefined reference to `save_flags'
drivers/built-in.o(.text+0x3c53b): undefined reference to `cli'
drivers/built-in.o(.text+0x3c594): undefined reference to `restore_flags'
drivers/built-in.o: In function `el3_ioctl':
drivers/built-in.o(.text+0x3cb21): undefined reference to `save_flags'
drivers/built-in.o(.text+0x3cb26): undefined reference to `cli'
drivers/built-in.o(.text+0x3cb73): undefined reference to `restore_flags'
drivers/built-in.o(.text+0x3cb98): undefined reference to `save_flags'
drivers/built-in.o(.text+0x3cb9d): undefined reference to `cli'
drivers/built-in.o(.text+0x3cbeb): undefined reference to `restore_flags'
make: *** [.tmp_vmlinux1] Error 1
-- 
bill davidsen, CTO TMR Associates, Inc <davidsen@tmr.com>
  Having the feature freeze for Linux 2.5 on Hallow'een is appropriate,
since using 2.5 kernels includes a lot of things jumping out of dark
corners to scare you.


