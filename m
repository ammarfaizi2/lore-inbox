Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbTEEEGT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 00:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbTEEEGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 00:06:19 -0400
Received: from h234n2fls24o900.telia.com ([217.208.132.234]:9959 "EHLO
	oden.fish.net") by vger.kernel.org with ESMTP id S261888AbTEEEGS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 00:06:18 -0400
Date: Mon, 5 May 2003 06:19:51 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.69
Message-Id: <20030505061951.5eee334d.lista1@telia.com>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Quick compile crash on a PII400, gcc version 2.95.3 20010315 (release). Have compiled previous 2.5.xx since about 65 cleanly.

[...]

AME=sysenter -c -o arch/i386/kernel/sysenter.o arch/i386/kernel/sysenter.c
  gcc -Wp,-MD,arch/i386/kernel/.vsyscall-int80.o.d -D__ASSEMBLY__ -D__KERNEL__ -Iinclude -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include  -traditional  -c -o arch/i386/kernel/vsyscall-int80.o arch/i386/kernel/vsyscall-int80.S
gcc -nostdlib -shared -s -Wl,-soname=linux-vsyscall.so.1 \
      -o arch/i386/kernel/vsyscall-int80.so -Wl,-T,arch/i386/kernel/vsyscall.lds arch/i386/kernel/vsyscall-int80.o
  gcc -Wp,-MD,arch/i386/kernel/.vsyscall-sysenter.o.d -D__ASSEMBLY__ -D__KERNEL__ -Iinclude -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include  -traditional  -c -o arch/i386/kernel/vsyscall-sysenter.o arch/i386/kernel/vsyscall-sysenter.S
gcc -nostdlib -shared -s -Wl,-soname=linux-vsyscall.so.1 \
      -o arch/i386/kernel/vsyscall-sysenter.so -Wl,-T,arch/i386/kernel/vsyscall.lds arch/i386/kernel/vsyscall-sysenter.o
  gcc -Wp,-MD,arch/i386/kernel/.vsyscall.o.d -D__ASSEMBLY__ -D__KERNEL__ -Iinclude -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include  -traditional  -c -o arch/i386/kernel/vsyscall.o arch/i386/kernel/vsyscall.S
/tmp/ccKug4Ma.s: Assembler messages:
/tmp/ccKug4Ma.s:1102: Error: Unknown pseudo-op:  `.incbin'
/tmp/ccKug4Ma.s:1107: Error: Unknown pseudo-op:  `.incbin'
make[1]: *** [arch/i386/kernel/vsyscall.o] Error 1
make: *** [arch/i386/kernel] Error 2

Regards,
Mats Johannesson
