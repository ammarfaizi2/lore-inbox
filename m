Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317894AbSFSOqB>; Wed, 19 Jun 2002 10:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317895AbSFSOqA>; Wed, 19 Jun 2002 10:46:00 -0400
Received: from vivi.uptime.at ([62.116.87.11]:28052 "EHLO vivi.uptime.at")
	by vger.kernel.org with ESMTP id <S317894AbSFSOp6>;
	Wed, 19 Jun 2002 10:45:58 -0400
Reply-To: <o.pitzeier@uptime.at>
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: <linux-kernel@vger.kernel.org>
Subject: New Build problem in sched.c in 2.5.23 on an Alpha
Date: Wed, 19 Jun 2002 16:45:17 +0200
Organization: =?us-ascii?Q?UPtime_Systemlosungen?=
Message-ID: <000501c2179f$f0c4bf60$010b10ac@sbp.uptime.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-reply-to: <Pine.NEB.4.44.0206191022030.10290-100000@mimas.fachschaften.tu-muenchen.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got another problem in sched.c

In file included from sched.c:26:
make[1]: Entering directory `/usr/src/linux-2.5.23/kernel'
  gcc -Wp,-MD,./.sched.o.d -D__KERNEL__ -I/usr/src/linux-2.5.23/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -fomit-frame-pointer -pipe -mno-fp-regs -ffixed-8 -mcpu=ev5
-Wa,-mev6 -nostdinc -iwithprefix include    -fno-omit-frame-pointer
-DKBUILD_BASENAME=sched   -c -o sched.o sched.c
In file included from sched.c:26:
/usr/src/linux-2.5.23/include/asm/mmu_context.h: In function
`init_new_context':
/usr/src/linux-2.5.23/include/asm/mmu_context.h:230: `smp_num_cpus'
undeclared (first use in this function)
/usr/src/linux-2.5.23/include/asm/mmu_context.h:230: (Each undeclared
identifier is reported only once
/usr/src/linux-2.5.23/include/asm/mmu_context.h:230: for each function
it appears in.)
/usr/src/linux-2.5.23/include/asm/mmu_context.h:231: warning: implicit
declaration of function `cpu_logical_map'
sched.c: In function `try_to_wake_up':
sched.c:362: warning: label `repeat_lock_task' defined but not used
sched.c: In function `schedule':
sched.c:822: warning: implicit declaration of function
`prepare_arch_schedule'
sched.c:879: warning: implicit declaration of function
`prepare_arch_switch'
sched.c:883: warning: implicit declaration of function
`finish_arch_switch'
sched.c:886: warning: implicit declaration of function
`finish_arch_schedule'
make[1]: *** [sched.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.23/kernel'
make: *** [kernel] Error 2

Any ideas?

Greetz,
 Oliver


