Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282318AbRKXBNE>; Fri, 23 Nov 2001 20:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282322AbRKXBMy>; Fri, 23 Nov 2001 20:12:54 -0500
Received: from 24-240-35-67.hsacorp.net ([24.240.35.67]:1920 "HELO
	majere.epithna.com") by vger.kernel.org with SMTP
	id <S282318AbRKXBMp>; Fri, 23 Nov 2001 20:12:45 -0500
Date: Fri, 23 Nov 2001 19:13:50 -0500 (EST)
From: <listmail@majere.epithna.com>
To: <linux-kernel@vger.kernel.org>
Subject: Error: compiling with preempt-kernel-rml-2.4.15-1.patch
Message-ID: <Pine.LNX.4.33.0111231906210.3406-100000@majere.epithna.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I applied the preempt-kernel-rml-2.4.15-1.patch file to a clean
just untarred 2.14.15 kernel source, and began to compile got the
following error.
I know the source is good, I compiled a non-patched Kernel from the same
archive earlier, re-extracted after the error, repeated, redownloaded,
reextracted. repeated.

ran
make menuconfig
make dep
make clean
make bzImage



root@majere:/usr/src/linux# make bzImage
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o
scripts/split-include scripts/split-include.c
scripts/split-include include/linux/autoconf.h include/config
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686   -c -o init/main.o
init/main.c
. scripts/mkversion > .tmpversion
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686  -DUTS_MACHINE='"i386"' -c
-o init/version.o init/version.c
make CFLAGS="-D__KERNEL__ -I/usr/src/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 " -C  kernel
make[1]: Entering directory `/usr/src/linux/kernel'
make all_targets
make[2]: Entering directory `/usr/src/linux/kernel'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686    -fno-omit-frame-pointer
-c -o sched.o sched.c
sched.c: In function `__schedule_tail':
sched.c:509: structure has no member named `has_cpu'
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory `/usr/src/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux/kernel'
make: *** [_dir_kernel] Error 2
root@majere:/usr/src/linux#

