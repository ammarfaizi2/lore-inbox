Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSHBNZq>; Fri, 2 Aug 2002 09:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313477AbSHBNZq>; Fri, 2 Aug 2002 09:25:46 -0400
Received: from smtprelay7.dc2.adelphia.net ([64.8.50.39]:49819 "EHLO
	smtprelay7.dc2.adelphia.net") by vger.kernel.org with ESMTP
	id <S313419AbSHBNZp>; Fri, 2 Aug 2002 09:25:45 -0400
Message-ID: <008701c23a28$958ca300$6a01a8c0@wa1hco>
From: "jeff millar" <wa1hco@adelphia.net>
To: <linux-kernel@vger.kernel.org>
References: <15690.6005.624237.902152@napali.hpl.hp.com><20020801.222053.20302294.davem@redhat.com><15690.9727.831144.67179@napali.hpl.hp.com> <20020802.012040.105531210.davem@redhat.com>
Subject: What does this error mean? "local symbols in discarded section .text.exit"
Date: Fri, 2 Aug 2002 09:29:09 -0400
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

I need some help debugging this kernel build problem.

Here's the tail of my kernel build.

  ld -m elf_i386  -r -o init.o main.o version.o do_mounts.o
make[1]: Leaving directory `/usr/src/v2.5.30/init'
  ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o
arch/i386/kernel/init
_task.o init/init.o --start-group arch/i386/kernel/kernel.o
arch/i386/mm/mm.o kernel/kernel.o mm
/mm.o fs/fs.o ipc/ipc.o security/built-in.o
/usr/src/v2.5.30/arch/i386/lib/lib.a lib/lib.a /usr/
src/v2.5.30/arch/i386/lib/lib.a drivers/built-in.o sound/sound.o
arch/i386/pci/pci.o net/network
.o --end-group -o vmlinux
drivers/built-in.o(.data+0x80f4): undefined reference to `local symbols in
discarded section .te
xt.exit'
make: *** [vmlinux] Error 1

