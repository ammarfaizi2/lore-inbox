Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312460AbSDNVGm>; Sun, 14 Apr 2002 17:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312464AbSDNVGl>; Sun, 14 Apr 2002 17:06:41 -0400
Received: from vivi.uptime.at ([62.116.87.11]:42936 "EHLO vivi.uptime.at")
	by vger.kernel.org with ESMTP id <S312460AbSDNVGk>;
	Sun, 14 Apr 2002 17:06:40 -0400
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: <axp-kernel-list@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Kernel 2.5.8 on Alpha
Date: Sun, 14 Apr 2002 23:01:13 +0200
Organization: =?us-ascii?Q?UPtime_Systemlosungen?=
Message-ID: <000001c1e3f7$86214880$1201a8c0@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <3CB8B939.54A8E170@acsu.buffalo.edu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to compile kernel 2.5.8 on an Alpha. I just wanted to try it...
This happens:
(Any ideas?)

[root@xxx linux-2.5.8]# make menuconfig
[ ... ]
[root@xxx linux-2.5.8]# make dep
[ ... ]
[root@xxx linux-2.5.8]# make
gcc -D__KERNEL__ -I/usr/src/linux-2.5.8/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev5
-Wa,-mev6   -DKBUILD_BASENAME=main -c -o init/main.o init/main.c
init/main.c: In function `start_kernel':
init/main.c:347: warning: implicit declaration of function
`setup_per_cpu_areas'
. scripts/mkversion > .tmpversion
gcc -D__KERNEL__ -I/usr/src/linux-2.5.8/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev5
-Wa,-mev6  -DUTS_MACHINE='"alpha"' -DKBUILD_BASENAME=version -c -o
init/version.o init/version.c
gcc -D__KERNEL__ -I/usr/src/linux-2.5.8/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev5
-Wa,-mev6   -DKBUILD_BASENAME=do_mounts -c -o init/do_mounts.o
init/do_mounts.c
make CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.5.8/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev5
-Wa,-mev6 " -C  kernel
make[1]: Entering directory `/usr/src/linux-2.5.8/kernel'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.5.8/kernel'
gcc -D__KERNEL__ -I/usr/src/linux-2.5.8/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev5
-Wa,-mev6   -DKBUILD_BASENAME=sched  -fno-omit-frame-pointer -c -o
sched.o sched.c
sched.c: In function `schedule':
sched.c:771: `PREEMPT_ACTIVE' undeclared (first use in this function)
sched.c:771: (Each undeclared identifier is reported only once
sched.c:771: for each function it appears in.)
sched.c: In function `init_idle':
sched.c:1556: structure has no member named `preempt_count'
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.8/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.8/kernel'
make: *** [_dir_kernel] Error 2

-Oliver


