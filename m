Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318092AbSGMEvO>; Sat, 13 Jul 2002 00:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318093AbSGMEvN>; Sat, 13 Jul 2002 00:51:13 -0400
Received: from mail14.speakeasy.net ([216.254.0.214]:978 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S318092AbSGMEvM>; Sat, 13 Jul 2002 00:51:12 -0400
Subject: fs/fs.o linking error in 2.5.25-dj2
From: Ed Sweetman <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 13 Jul 2002 00:54:01 -0400
Message-Id: <1026536041.1203.107.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with the 2.5 ide subsystem i get undefined references to
__udivdi3  

  ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/init.o --start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o /usr/src/linux-2.5.25/arch/i386/lib/lib.a lib/lib.a /usr/src/linux-2.5.25/arch/i386/lib/lib.a drivers/built-in.o sound/sound.o arch/i386/pci/pci.o net/network.o --end-group -o vmlinux
fs/fs.o: In function `proc_pid_stat':
fs/fs.o(.text+0x1ff3f): undefined reference to `__udivdi3'
fs/fs.o: In function `kstat_read_proc':
fs/fs.o(.text+0x20fc8): undefined reference to `__udivdi3'
fs/fs.o(.text+0x2105e): undefined reference to `__udivdi3'


I've attached my config along with it.  There is also a missing
semicolon on line 70 of drivers/char/agp/agpgart_be-i8x0.c   

