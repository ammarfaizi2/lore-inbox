Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267698AbTAMBKw>; Sun, 12 Jan 2003 20:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267701AbTAMBKw>; Sun, 12 Jan 2003 20:10:52 -0500
Received: from services.cam.org ([198.73.180.252]:30168 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S267698AbTAMBKv> convert rfc822-to-8bit;
	Sun, 12 Jan 2003 20:10:51 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: link error bk-currect (isapnp_card_protocol undefined)
Date: Sun, 12 Jan 2003 20:20:00 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Message-Id: <200301122020.00102.tomlins@cam.org>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Building from bk-current (2.95-4) I get: 

  gcc -E -Wp,-MD,arch/i386/.vmlinux.lds.s.d_ -D__ASSEMBLY__ -D__KERNEL__ -Iinclude -Iinclude/asm-i386/mach-default  -nostdinc -iwithprefix include   -P -C -Ui386   -o arch/i386/vmlinux.lds.s arch/i386/vmlinux.lds.S
echo '  Generating build number'
  Generating build number
. ./scripts/mkversion > .tmp_version
mv -f .tmp_version .version
make -f scripts/Makefile.build obj=init
  Generating include/linux/compile.h (updated)
  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=version -DKBUILD_MODNAME=version   -c -o init/version.o init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/do_mounts.o init/initramfs.o
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
drivers/built-in.o(.init.text+0x1b19): In function `isapnp_init':
: undefined reference to `isapnp_card_protocol'
drivers/built-in.o(.init.text+0x1b8c): In function `isapnp_init':
: undefined reference to `isapnp_card_protocol'
make: *** [.tmp_vmlinux1] Error 1

Ed Tomlinson

