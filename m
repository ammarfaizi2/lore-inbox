Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbSLQNJa>; Tue, 17 Dec 2002 08:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbSLQNJa>; Tue, 17 Dec 2002 08:09:30 -0500
Received: from mailnw.centurytel.net ([209.206.160.237]:25992 "EHLO
	mailnw.centurytel.net") by vger.kernel.org with ESMTP
	id <S265037AbSLQNJ3>; Tue, 17 Dec 2002 08:09:29 -0500
Message-ID: <3DFF94A6.2060301@centurytel.net>
Date: Tue, 17 Dec 2002 14:18:30 -0700
From: eric lin <fsshl@centurytel.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021210 Debian/1.2.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: make install , or make modules error in 2.5.52
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear linux Kernel programmers:

   I untar 2.5.52 and in its directory, make-kpkg (in debian platform)
it end with error

mv -f .tmp_version .version
/usr/bin/make -f scripts/Makefile.build obj=init
   Generating include/linux/compile.h (updated)
   gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic 
-fomit-frame-pointer -nostdinc -iwithprefix include 
-DKBUILD_BASENAME=version -DKBUILD_MODNAME=version   -c -o 
init/version.o init/version.c
    ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o 
init/do_mounts.o init/initramfs.o
         ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o 
--start-group  usr/built-in.o  arch/i386/kernel/built-in.o 
arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o 
kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o 
security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a 
drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o 
net/built-in.o --end-group  -o vmlinux
drivers/built-in.o(.text+0x16e3f): In function `kd_nosound':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x16e58): In function `kd_nosound':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x16ee8): In function `kd_mksound':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x17a8a): In function `kbd_bh':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x17a98): In function `kbd_bh':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x17aa9): more undefined references to 
`input_event' follow
drivers/built-in.o(.text+0x17ec3): In function `kbd_connect':
: undefined reference to `input_open_device'
drivers/built-in.o(.text+0x17edf): In function `kbd_disconnect':
: undefined reference to `input_close_device'
drivers/built-in.o(.init.text+0x1891): In function `kbd_init':
: undefined reference to `input_register_handler'
make[1]: *** [vmlinux] Error 1
make[1]: Leaving directory `/home/fsshl/linux-2.5.52'
make: *** [stamp-build] Error 2


Please nitfy and drop me a note if someone or someway to fix it

-- 
Sincere Eric
www.linuxspice.com
linux pc for sale

