Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262858AbSJLJUQ>; Sat, 12 Oct 2002 05:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262850AbSJLJUQ>; Sat, 12 Oct 2002 05:20:16 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:7399 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262842AbSJLJUP>; Sat, 12 Oct 2002 05:20:15 -0400
Message-Id: <4.3.2.7.2.20021012112501.00b4c640@mail.dns-host.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sat, 12 Oct 2002 11:25:57 +0200
To: linux-kernel@vger.kernel.org
From: Margit Schubert-While <margit@margit.com>
Subject: Build fail 2.5.42
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o 
init/do_mounts.o
         ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o 
--start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o 
arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o 
fs/built-in.o  ipc/built-in.o  security/built-in.o  lib/lib.a 
arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o 
arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
net/built-in.o: In function `p8022_request':
net/built-in.o(.text+0xd8e9): undefined reference to 
`llc_build_and_send_ui_pkt'
net/built-in.o: In function `register_8022_client':
net/built-in.o(.text+0xd932): undefined reference to `llc_sap_open'
net/built-in.o: In function `unregister_8022_client':
net/built-in.o(.text+0xd95e): undefined reference to `llc_sap_close'
net/built-in.o: In function `snap_request':
net/built-in.o(.text+0xdaa0): undefined reference to 
`llc_build_and_send_ui_pkt'
net/built-in.o: In function `snap_init':
net/built-in.o(.text.init+0x59b): undefined reference to `llc_sap_open'
make: *** [vmlinux] Error 1

