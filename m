Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbVL1GZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVL1GZQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 01:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVL1GZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 01:25:16 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:14386 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751151AbVL1GZN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 01:25:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ia4aYzbGY3p5yAsT0Wg7q4YpREtCDO1Bw0T+DdPFxwv/hb57iPVvYhxygf6ImnojuDVDJIzm+7n6cT0Bl//Ofmd8mj6+3QOLLiyTsb+rT4mFjHlDpZ5g7OewzeL+FKw868BmMVz2siB9y7X/WlPmdwxHvhbuxMcP4xSG5E8SKn4=
Message-ID: <ddce9dad0512272225l5fccba3boe2c0fb7d05f626c8@mail.gmail.com>
Date: Wed, 28 Dec 2005 11:55:12 +0530
From: Srikanth Srinivasan <ssrikanth1@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Error patching linux-2.6.9 with kdb-v4.4-2.6.9-i386-1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am relatively new to the linux kernel. I have a problem patching the
linux kernel with the kdb kernel debugger.... Here are the steps i
followed. Am not sure if i have missed anything... Kindly help me
out...

1) Untarred the linux-2.6.9 to my home directory
[srikanth@zeus linux]$ pwd
/home/srikanth/work/src/linux

2) Copied kdb-v4.4-2.6.9-i386-1 to /home/srikanth/work/src/linux

3) [srikanth@zeus linux]$ patch -p1 < kdb-v4.4-2.6.9-i386-1
patching file arch/i386/Kconfig.debug
patching file arch/i386/Makefile
patching file arch/i386/kdb/ChangeLog
patching file arch/i386/kdb/Makefile
patching file arch/i386/kdb/i386-dis.c
patching file arch/i386/kdb/kdb_cmds
patching file arch/i386/kdb/kdba_bp.c
patching file arch/i386/kdb/kdba_bt.c
patching file arch/i386/kdb/kdba_id.c
patching file arch/i386/kdb/kdba_io.c
patching file arch/i386/kdb/kdbasupport.c
patching file arch/i386/kdb/pc_keyb.h
patching file arch/i386/kernel/entry.S
patching file arch/i386/kernel/i8259.c
patching file arch/i386/kernel/io_apic.c
patching file arch/i386/kernel/reboot.c
patching file arch/i386/kernel/smp.c
patching file arch/i386/kernel/smpboot.c
patching file arch/i386/kernel/traps.c
patching file arch/i386/kernel/vmlinux.lds.S
patching file include/asm-i386/ansidecl.h
patching file include/asm-i386/bfd.h
patching file include/asm-i386/kdb.h
patching file include/asm-i386/kdbprivate.h
patching file include/asm-i386/kmap_types.h
patching file include/asm-i386/mach-default/irq_vectors.h
patching file include/asm-i386/ptrace.h
patching file kdb/modules/kdbm_x86.c

4) Ran menuconfig and chose  Built-in Kernel Debugger support from
Kernel hacking.
I alos chose KDB modules to be built.in

5) Then when i ran make bzImage i got the error as linux/kdb.h not found
[srikanth@zeus linux]$ make bzImage
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  SYMLINK include/asm -> include/asm-i386
  SPLIT   include/linux/autoconf.h -> include/config/*
  HOSTCC  scripts/genksyms/genksyms.o
  SHIPPED scripts/genksyms/lex.c
  SHIPPED scripts/genksyms/parse.h
  SHIPPED scripts/genksyms/keywords.c
  HOSTCC  scripts/genksyms/lex.o
  SHIPPED scripts/genksyms/parse.c
  HOSTCC  scripts/genksyms/parse.o
  HOSTLD  scripts/genksyms/genksyms
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/pnmtologo
  HOSTCC  scripts/conmakehash
  CC      arch/i386/kernel/asm-offsets.s
  CHK     include/asm-i386/asm_offsets.h
  UPD     include/asm-i386/asm_offsets.h
  CC      init/main.o
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  CC      init/do_mounts.o
  CC      init/do_mounts_rd.o
  CC      init/do_mounts_initrd.o
  CC      init/do_mounts_md.o
  LD      init/mounts.o
  CC      init/initramfs.o
  LD      init/built-in.o
  HOSTCC  usr/gen_init_cpio
  CPIO    usr/initramfs_data.cpio
  GZIP    usr/initramfs_data.cpio.gz
  AS      usr/initramfs_data.o
  LD      usr/built-in.o
  CC      arch/i386/kernel/process.o
  CC      arch/i386/kernel/semaphore.o
  CC      arch/i386/kernel/signal.o
  AS      arch/i386/kernel/entry.o
  CC      arch/i386/kernel/traps.o
arch/i386/kernel/traps.c:41:23: linux/kdb.h: No such file or directory
arch/i386/kernel/traps.c: In function `die':
arch/i386/kernel/traps.c:369: error: `kdb_diemsg' undeclared (first
use in this function)
arch/i386/kernel/traps.c:369: error: (Each undeclared identifier is
reported only once
arch/i386/kernel/traps.c:369: error: for each function it appears in.)
arch/i386/kernel/traps.c:370: warning: implicit declaration of function `kdb'
arch/i386/kernel/traps.c:370: error: `KDB_REASON_OOPS' undeclared
(first use in this function)
arch/i386/kernel/traps.c: In function `unknown_nmi_error':
arch/i386/kernel/traps.c:579: error: `KDB_REASON_NMI' undeclared
(first use in this function)
arch/i386/kernel/traps.c: In function `die_nmi':
arch/i386/kernel/traps.c:611: error: `KDB_REASON_NMI' undeclared
(first use in this function)
arch/i386/kernel/traps.c: In function `do_debug':
arch/i386/kernel/traps.c:740: error: `KDB_REASON_DEBUG' undeclared
(first use in this function)
arch/i386/kernel/traps.c: At top level:
arch/i386/kernel/traps.c:816: error: conflicting types for 'do_int3'
arch/i386/kernel/traps.c:697: error: previous definition of 'do_int3' was here
arch/i386/kernel/traps.c: In function `do_int3':
arch/i386/kernel/traps.c:817: error: `KDB_REASON_BREAK' undeclared
(first use in this function)
arch/i386/kernel/traps.c: In function `trap_init':
arch/i386/kernel/traps.c:1121: warning: implicit declaration of
function `kdb_enablehwfault'
make[1]: *** [arch/i386/kernel/traps.o] Error 1
make: *** [arch/i386/kernel] Error 2

I run RHEL4 U2 on a uni-processor x86 box
[srikanth@zeus linux]$ uname -a
Linux zeus.in.ibm.com 2.6.9-22.EL #1 Mon Sep 19 18:20:28 EDT 2005 i686
i686 i386 GNU/Linux

Regards, Srikanth
