Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280953AbRKLTky>; Mon, 12 Nov 2001 14:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280950AbRKLTkp>; Mon, 12 Nov 2001 14:40:45 -0500
Received: from 24-148-58-49.na.21stcentury.net ([24.148.58.49]:53619 "EHLO
	danapple.com") by vger.kernel.org with ESMTP id <S280944AbRKLTkd>;
	Mon, 12 Nov 2001 14:40:33 -0500
Message-Id: <200111121939.fACJdX309798@danapple.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.15-pre4 compile problem
From: "Daniel I. Applebaum" <kernel@danapple.com>
Date: Mon, 12 Nov 2001 13:39:33 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While compiling 2.4.15-pre4:
+++++++++++++++
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o setup.o setup.c
setup.c: In function `c_start':
setup.c:2791: subscripted value is neither array nor pointer
setup.c:2792: warning: control reaches end of non-void function
gmake[1]: *** [setup.o] Error 1
gmake[1]: Leaving directory `/usr/src/linux/arch/i386/kernel'
gmake: *** [_dir_arch/i386/kernel] Error 2
+++++++++++++++++

Here's the block of code:
+++++++++++++++++
static void *c_start(struct seq_file *m, loff_t *pos)
{
        return *pos < NR_CPUS ? &cpu_data[*pos] : NULL;
}
+++++++++++++++++

Note that I'm compiling a non-SMP kernel.

Do I have to generate my .config from scatch each time, or can I copy
2.4.14/.config to 2.4.15-pre4/.config and run 'gmake menuconfig'?
(I've been doing the latter.)

Dan.
