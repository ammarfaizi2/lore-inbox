Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267175AbSKMMZV>; Wed, 13 Nov 2002 07:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267178AbSKMMZV>; Wed, 13 Nov 2002 07:25:21 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:47116 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S267175AbSKMMZT>; Wed, 13 Nov 2002 07:25:19 -0500
Date: Wed, 13 Nov 2002 07:32:04 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@oddball.prodigy.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.5.47-ac1 fails linking
Message-ID: <Pine.LNX.4.44.0211130726380.16139-101000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1165167311-1037190724=:16139"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1165167311-1037190724=:16139
Content-Type: TEXT/PLAIN; charset=US-ASCII

I get this failure in the link. Config file attached.

  [... snip ...]
make -f scripts/Makefile.build obj=lib/zlib_deflate
make -f scripts/Makefile.build obj=lib/zlib_inflate
make -f scripts/Makefile.build obj=arch/i386/lib
  Generating build number
  Generating include/linux/compile.h (updated)
  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -p -Iarch/i386/mach-generic -Iarch/i386/mach-defaults -nostdinc -iwithprefix include    -DKBUILD_BASENAME=version   -c -o init/version.o init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/do_mounts.o init/initramfs.o
  	ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o  lib/lib.a  arch/i386/lib/lib.a --end-group  -o .tmp_vmlinux1
arch/i386/kernel/built-in.o: In function `identify_cpu':
arch/i386/kernel/built-in.o(.init.text+0x25f4): undefined reference to `mcheck_init'
arch/i386/kernel/built-in.o: In function `gdt_48':
arch/i386/kernel/built-in.o(.data+0x15b5): undefined reference to `boot_gdt_table'
make: *** [.tmp_vmlinux1] Error 1


-- 
bill davidsen <davidsen@tmr.com>


--8323328-1165167311-1037190724=:16139
Content-Type: APPLICATION/x-bzip2; name="config.bz2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0211130732040.16139@oddball.prodigy.com>
Content-Description: 
Content-Disposition: attachment; filename="config.bz2"

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
GQSQZMV9+ktEYlKFBibOCfxdyRThQkK2cvP0
--8323328-1165167311-1037190724=:16139--
