Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261554AbSKCBvZ>; Sat, 2 Nov 2002 20:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261555AbSKCBvZ>; Sat, 2 Nov 2002 20:51:25 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:26835 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S261554AbSKCBvY>; Sat, 2 Nov 2002 20:51:24 -0500
Message-ID: <3DC4829B.1010509@nortelnetworks.com>
Date: Sat, 02 Nov 2002 20:57:47 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: compilation problems with 2.4.45
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following error on a "make bzImage".




  Generating build number
   Generating include/linux/compile.h (updated)
   gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon -Iarch/i386/mach-generic -nostdinc -iwithprefix include 
  -DKBUILD_BASENAME=version   -c -o init/version.o init/version.c
    ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o 
init/do_mounts.o
         ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o 
--start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o 
arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o 
fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o 
lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o 
arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
fs/built-in.o: In function `ext2_xattr_put_super':
fs/built-in.o(.text+0x431fc): undefined reference to `mb_cache_shrink'
fs/built-in.o: In function `ext2_xattr_cache_insert':
fs/built-in.o(.text+0x43231): undefined reference to `mb_cache_entry_alloc'
fs/built-in.o(.text+0x43259): undefined reference to `mb_cache_entry_insert'
fs/built-in.o(.text+0x43267): undefined reference to `mb_cache_entry_free'
fs/built-in.o(.text+0x43284): undefined reference to 
`mb_cache_entry_release'
fs/built-in.o: In function `ext2_xattr_cache_find':
fs/built-in.o(.text+0x433bf): undefined reference to 
`mb_cache_entry_find_first'
fs/built-in.o(.text+0x4342d): undefined reference to 
`mb_cache_entry_find_next'
fs/built-in.o(.text+0x4345a): undefined reference to 
`mb_cache_entry_release'
fs/built-in.o: In function `ext2_xattr_cache_remove':
fs/built-in.o(.text+0x434c0): undefined reference to `mb_cache_entry_get'
fs/built-in.o: In function `exit_ext2_xattr':
fs/built-in.o(.text+0x4358f): undefined reference to `mb_cache_destroy'
fs/built-in.o: In function `ext2_xattr_cache_remove':
fs/built-in.o(.text+0x434cd): undefined reference to `mb_cache_entry_free'
fs/built-in.o: In function `init_ext2_xattr':
fs/built-in.o(.init.text+0x145d): undefined reference to `mb_cache_create'
make: *** [.tmp_vmlinux1] Error 1

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

