Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265171AbTBTK6v>; Thu, 20 Feb 2003 05:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbTBTK6v>; Thu, 20 Feb 2003 05:58:51 -0500
Received: from 212-204-016-024.dsl1.versanet.de ([212.204.16.24]:34949 "EHLO
	kermit.spenneberg.de") by vger.kernel.org with ESMTP
	id <S265171AbTBTK6u>; Thu, 20 Feb 2003 05:58:50 -0500
Subject: IPsec in 2.5.62 broken?
From: Ralf Spenneberg <ralf@spenneberg.de>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Feb 2003 12:08:43 +0100
Message-Id: <1045739323.2172.63.camel@kermit.spenneberg.de>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am just trying to compile 2.5.62 with IPsec built in. It chokes when
linking:
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s
arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o
--start-group  usr/built-in.o
 arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o 
arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/built-in.o 
fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o 
lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o 
arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
net/built-in.o: In function `pfkey_msg2xfrm_state':
net/built-in.o(.text+0x63ae0): undefined reference to `xfrm6_get_type'
make: *** [.tmp_vmlinux1] Fehler 1

Anybody able to help me. Unfortunately I am not that good in kernel
programming.

I am using gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)

CONFIG Options:
CONFIG_NET_KEY=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_XFRM_USER=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_DES=y

Cheers,

Ralf

