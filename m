Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSIPG2A>; Mon, 16 Sep 2002 02:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313060AbSIPG2A>; Mon, 16 Sep 2002 02:28:00 -0400
Received: from pop017pub.verizon.net ([206.46.170.210]:54424 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP
	id <S312590AbSIPG2A>; Mon, 16 Sep 2002 02:28:00 -0400
Message-Id: <200209160644.g8G6iEvo006691@pool-141-150-241-241.delv.east.verizon.net>
Date: Mon, 16 Sep 2002 02:44:12 -0400
From: Skip Ford <skip.ford@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.35 undefined reference to `wait_task_inactive'
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop017.verizon.net from [141.150.241.241] using ID <vze2j9fk@verizon.net> at Mon, 16 Sep 2002 01:32:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A call to wait_task_inactive was added to fs/exec.c but that function is
not defined for UP.

ld -m elf_i386 -T arch/i386/vmlinux.lds.s -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/init.o --start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o security/built-in.o /usr/local/src/linux/arch/i386/lib/lib.a lib/lib.a /usr/local/src/linux/arch/i386/lib/lib.a drivers/built-in.o sound/sound.o arch/i386/pci/pci.o net/network.o --end-group -o vmlinux
fs/fs.o: In function `flush_old_exec':
fs/fs.o(.text+0x8cb7): undefined reference to `wait_task_inactive'
make: *** [vmlinux] Error 1

-- 
Skip
