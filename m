Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282112AbRKWK1k>; Fri, 23 Nov 2001 05:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282116AbRKWK1a>; Fri, 23 Nov 2001 05:27:30 -0500
Received: from Expansa.sns.it ([192.167.206.189]:32019 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S282112AbRKWK1V>;
	Fri, 23 Nov 2001 05:27:21 -0500
Date: Fri, 23 Nov 2001 11:27:12 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: <linux-kernel@vger.kernel.org>
cc: <davem@redhat.com>
Subject: 2.4.15 does not compile on sparc64
Message-ID: <Pine.LNX.4.33.0111231115290.26247-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI,
I'm trying to compile linux kernel 2.4.15 on SUN ultra 2
monoprocessor, 1GB RAM>

I get this error message:

sparc64-linux-gcc -D__KERNEL__ -I/usr/src/linux-2.4.15/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -m64 -pipe -mno-fpu -mcpu=ultrasparc
-mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno-sign-compare
-Wa,--undeclared-regs    -c -o ioctl32.o ioctl32.c
ioctl32.c: In function `do_lvm_ioctl':
ioctl32.c:2636: warning: assignment makes pointer from integer without a
cast
ioctl32.c:2670: structure has no member named `inode'
ioctl32.c:2711: warning: assignment from incompatible pointer type
ioctl32.c:2712: structure has no member named `inode'
ioctl32.c:2719: structure has no member named `inode'
ioctl32.c:2732: structure has no member named `inode'
ioctl32.c:2611: warning: `v' might be used uninitialized in this function
make[1]: *** [ioctl32.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.15/arch/sparc64/kernel'
make: *** [_dir_arch/sparc64/kernel] Error 2


this bug was already there in 2.4.15-pre5|6.

willing to test any patch.

Luigi Genoni


