Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263119AbSJBOtb>; Wed, 2 Oct 2002 10:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263126AbSJBOta>; Wed, 2 Oct 2002 10:49:30 -0400
Received: from 62-190-200-237.pdu.pipex.net ([62.190.200.237]:2308 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S263119AbSJBOta>; Wed, 2 Oct 2002 10:49:30 -0400
Date: Wed, 2 Oct 2002 16:03:22 +0100
From: jbradford@dial.pipex.com
Message-Id: <200210021503.g92F3M5l004937@darkstar.example.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40 compile fail in snd_emu8000_new
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ARGH!!!  :-)

This is a virgin 2.5.40 tree, except for a small hack to drivers/serial/core.c, compiled, (or not :-) ), with GCC 2.95.3

make[1]: Leaving directory `/usr/src/linux-2.5.40/init'
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o kernel/built-in.o mm/built-in.o fs/built-in.o ipc/built-in.o security/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
sound/built-in.o: In function `snd_emu8000_new':
sound/built-in.o(.text.init+0x1793): undefined reference to `snd_seq_device_new'make: *** [vmlinux] Error 1

John.
