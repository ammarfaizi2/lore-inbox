Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318756AbSG0Nt7>; Sat, 27 Jul 2002 09:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318758AbSG0Nt6>; Sat, 27 Jul 2002 09:49:58 -0400
Received: from smtprelay7.dc2.adelphia.net ([64.8.50.39]:24973 "EHLO
	smtprelay7.dc2.adelphia.net") by vger.kernel.org with ESMTP
	id <S318756AbSG0Nt5>; Sat, 27 Jul 2002 09:49:57 -0400
Message-ID: <00ac01c23574$f1687b30$6a01a8c0@wa1hco>
From: "jeff millar" <wa1hco@adelphia.net>
To: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207241803410.4293-100000@home.transmeta.com> <00a501c2338c$25365170$6a01a8c0@wa1hco> <004401c23463$df58a350$6a01a8c0@wa1hco>
Subject: 2.5.27-28-29 linker error: "undefined reference to local symbols in discarded section .text.exit"
Date: Sat, 27 Jul 2002 09:53:09 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ld fails to build vmlinux for all the recent v2.5 kernels.  ld complains
about

    In function `parport_ieee1284_epp_write_data':
    /usr/src/v2.5.29/include/asm/io.h:400:
    undefined reference to `local symbols in discarded section .text.exit'

The machine is Redhat 7.3 on an Athlon, most of the recent Redhat updates.
It's up to date with .../Documentation/Changes
I've tried make mrproper
I've tried switching between modules and compiled-in, modules get further
=========================================
$tail /usr/src/linux/make.out
make[1]: Leaving directory `/usr/src/v2.5.28/init'
  ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o
arch/i386/kernel/init
_task.o init/init.o --start-group arch/i386/kernel/kernel.o
arch/i386/mm/mm.o kernel/kernel.o mm
/mm.o fs/fs.o ipc/ipc.o security/built-in.o
/usr/src/v2.5.28/arch/i386/lib/lib.a lib/lib.a /usr/
src/v2.5.28/arch/i386/lib/lib.a drivers/built-in.o sound/sound.o
arch/i386/pci/pci.o net/network
.o --end-group -o vmlinux
drivers/built-in.o(.data+0x5174): undefined reference to `local symbols in
discarded section .te
xt.exit'
make: *** [vmlinux] Error 1

