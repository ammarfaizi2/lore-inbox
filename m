Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261360AbSJLVxl>; Sat, 12 Oct 2002 17:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261361AbSJLVxl>; Sat, 12 Oct 2002 17:53:41 -0400
Received: from mail.gmx.de ([213.165.64.20]:22708 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261360AbSJLVxj>;
	Sat, 12 Oct 2002 17:53:39 -0400
From: Felix Seeger <felix.seeger@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5.42 compile error in timers/timer_tsc.c
Date: Sat, 12 Oct 2002 23:59:20 +0200
User-Agent: KMail/1.4.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200210122359.20563.felix.seeger@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I get this:

  gcc -Wp,-MD,arch/i386/kernel/timers/.timer.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=timer   -c -o arch/i386/kernel/timers/timer.o 
arch/i386/kernel/timers/timer.c
  gcc -Wp,-MD,arch/i386/kernel/timers/.timer_tsc.o.d -D__KERNEL__ -Iinclude 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=timer_tsc   -c -o arch/i386/kernel/timers/timer_tsc.o 
arch/i386/kernel/timers/timer_tsc.c
arch/i386/kernel/timers/timer_tsc.c: In function `time_cpufreq_notifier':
arch/i386/kernel/timers/timer_tsc.c:181: `CPUFREQ_PRECHANGE' undeclared (first 
use in this function)
arch/i386/kernel/timers/timer_tsc.c:181: (Each undeclared identifier is 
reported only once
arch/i386/kernel/timers/timer_tsc.c:181: for each function it appears in.)
arch/i386/kernel/timers/timer_tsc.c:182: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:182: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:183: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:183: `CPUFREQ_ALL_CPUS' undeclared (first 
use in this function)
arch/i386/kernel/timers/timer_tsc.c:183: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:184: warning: implicit declaration of 
function `cpufreq_scale'
arch/i386/kernel/timers/timer_tsc.c:184: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:184: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:185: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:185: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:188: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:188: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:189: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:189: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:192: `CPUFREQ_POSTCHANGE' undeclared 
(first use in this function)
arch/i386/kernel/timers/timer_tsc.c:193: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:193: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:194: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:194: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:195: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:195: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:196: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:196: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:199: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:199: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:200: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:200: dereferencing pointer to incomplete 
type
arch/i386/kernel/timers/timer_tsc.c:184: warning: unreachable code at 
beginning of switch statement
arch/i386/kernel/timers/timer_tsc.c: At top level:
arch/i386/kernel/timers/timer_tsc.c:207: variable 
`time_cpufreq_notifier_block' has initializer but incomplete type
arch/i386/kernel/timers/timer_tsc.c:208: unknown field `notifier_call' 
specified in initializer
arch/i386/kernel/timers/timer_tsc.c:209: warning: excess elements in struct 
initializer
arch/i386/kernel/timers/timer_tsc.c:209: warning: (near initialization for 
`time_cpufreq_notifier_block')
arch/i386/kernel/timers/timer_tsc.c: In function `init_tsc':
arch/i386/kernel/timers/timer_tsc.c:265: warning: implicit declaration of 
function `cpufreq_register_notifier'
arch/i386/kernel/timers/timer_tsc.c:265: `CPUFREQ_TRANSITION_NOTIFIER' 
undeclared (first use in this function)
make[2]: *** [arch/i386/kernel/timers/timer_tsc.o] Error 1
make[1]: *** [arch/i386/kernel/timers] Error 2
make: *** [arch/i386/kernel] Error 2
hal@vaio:~/download/kernel/linux-2.5.42$

thanks
Felix


