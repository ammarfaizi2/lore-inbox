Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286825AbSAMR6R>; Sun, 13 Jan 2002 12:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286944AbSAMR6I>; Sun, 13 Jan 2002 12:58:08 -0500
Received: from ns.ithnet.com ([217.64.64.10]:26629 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S286825AbSAMR56>;
	Sun, 13 Jan 2002 12:57:58 -0500
Date: Sun, 13 Jan 2002 18:57:32 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, anton@samba.org
Subject: Re: [patch] O(1) scheduler, -H7
Message-Id: <20020113185732.72ea3aa8.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33.0201131933500.6560-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0201131933500.6560-100000@localhost.localdomain>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jan 2002 20:34:39 +0100 (CET)
Ingo Molnar <mingo@elte.hu> wrote:

> 
> the -H7 patch is available:
> 
>     http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-pre11-H7.patch
>     http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-H7.patch

Sorry ingo,

this does not compile under 2.4.17:

make[2]: Entering directory `/usr/src/linux/kernel'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigrap hs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-s tack-boundary=2 -march=i686    -fno-omit-frame-pointer -c -o
sched.o sched.c sched.c:21: asm/sched.h: No such file or directory
sched.c: In function `context_switch':
sched.c:430: warning: implicit declaration of function `enter_lazy_tlb'
sched.c:432: warning: implicit declaration of function `switch_mm'
sched.c: In function `schedule':
sched.c:785: warning: implicit declaration of function
`sched_find_first_zero_bi t'
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory `/usr/src/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux/kernel'
make: *** [_dir_kernel] Error 2

Regards,
Stephan



