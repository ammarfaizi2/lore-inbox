Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275981AbRI1Itu>; Fri, 28 Sep 2001 04:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275982AbRI1Itk>; Fri, 28 Sep 2001 04:49:40 -0400
Received: from dionis.mirotel.net ([194.125.225.7]:62859 "EHLO
	dionis.mirotel.net") by vger.kernel.org with ESMTP
	id <S275981AbRI1ItZ>; Fri, 28 Sep 2001 04:49:25 -0400
Date: Fri, 28 Sep 2001 12:00:33 +0300 (EEST)
From: Zakhar Kirpichenko <zakhar@mirotel.net>
To: <linux-kernel@vger.kernel.org>
Subject: linux-2.4.9-ac15 and -ac16 compile error
In-Reply-To: <20010928102617.7de2ec3a.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33.0109281153060.25965-100000@dionis.mirotel.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello there.

	I've got a problem compiling linux-2.4.9-ac15 and -ac16. When I'm
trying to compile APM support as module, I get this during depmod section
of 'make modules_install' (and when start 'depmod' manually):

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.9-z6; fi
depmod: *** Unresolved symbols in
/lib/modules/2.4.9-z6/kernel/arch/i386/kernel/apm.o
depmod: 	__sysrq_unlock_table
depmod: 	__sysrq_get_key_op
depmod: 	__sysrq_put_key_op
depmod: 	__sysrq_lock_table

	Also I've got a problem compiling APM into the kernel:

ld -m elf_i386 -T /usr/src/linux-2.4.9-ac16/arch/i386/vmlinux.lds -e stext

[bla-bla-bla]

/usr/src/linux-2.4.9-z6/arch/i386/lib/lib.a \
	--end-group \
	-o vmlinux
arch/i386/kernel/kernel.o: In function `apm':
arch/i386/kernel/kernel.o(.text+0xbf8a): undefined reference to `__sysrq_lock_table'
arch/i386/kernel/kernel.o(.text+0xbf91): undefined reference to `__sysrq_get_key_op'
arch/i386/kernel/kernel.o(.text+0xbfa4): undefined reference to `__sysrq_put_key_op'
arch/i386/kernel/kernel.o(.text+0xbfac): undefined reference to `__sysrq_unlock_table'
make: *** [vmlinux] Error 1

	It was okay before -ac15.

	gcc version report is: gcc version 2.95.3 20010315 (release).

	Any ideas?

-- 
Zakhar Kirpichenko,
ZAK-UANIC


