Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263899AbSKIBMC>; Fri, 8 Nov 2002 20:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263956AbSKIBMC>; Fri, 8 Nov 2002 20:12:02 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:61597 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP
	id <S263899AbSKIBMB>; Fri, 8 Nov 2002 20:12:01 -0500
Message-ID: <054801c2878d$dc425b70$0200a8c0@cirilium.com>
From: "Mark Hamblin" <MarkHamblin@cox.net>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <3DCC5DA4.2010707@gmx.net>
Subject: [QUESTION] Can't make 2.5.46 due to errors with llc_sap_open, etc
Date: Fri, 8 Nov 2002 18:17:34 -0700
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

I have the 2.5.46 make working up to the errors below.  I am doing this so I
can test with the new epoll features.  To get this far, all I had to do was
apply a patch I found in the 2.5.45-ac1 tree (to address some errors in
net/ipv4/ipmr.c).  Do I need to disable LLC?  Or enable something so LLC
gets included in the make?  Is there a more stable release that includes the
epoll support?  I am running RedHat 7.3.  Any help is greatly appreciated.

- Mark

        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s
arch/i386/kernel/head.o arch/i386/kernel/init_task.o
 init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o
arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o
kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o
security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a
drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o
net/built-in.o --end-group  -o .tmp_vmlinux1
net/built-in.o: In function `p8022_request':
net/built-in.o(.text+0xe56b): undefined reference to
`llc_build_and_send_ui_pkt'
net/built-in.o: In function `register_8022_client':
net/built-in.o(.text+0xe5bd): undefined reference to `llc_sap_open'
net/built-in.o: In function `unregister_8022_client':
net/built-in.o(.text+0xe5ea): undefined reference to `llc_sap_close'
net/built-in.o: In function `snap_request':
net/built-in.o(.text+0xe736): undefined reference to
`llc_build_and_send_ui_pkt'
net/built-in.o: In function `snap_init':
net/built-in.o(.init.text+0x55b): undefined reference to `llc_sap_open'
make: *** [.tmp_vmlinux1] Error 1


