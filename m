Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277310AbRJEEiG>; Fri, 5 Oct 2001 00:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277311AbRJEEh4>; Fri, 5 Oct 2001 00:37:56 -0400
Received: from paloma13.e0k.nbg-hannover.de ([62.159.219.13]:38082 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S277310AbRJEEhn>; Fri, 5 Oct 2001 00:37:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.4.11-pre4
Date: Fri, 5 Oct 2001 06:38:11 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011005043751Z277310-761+15781@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

the new and very cool Multiquad NUMA stuff break something...

gcc -D__KERNEL__ -I/usr/src/linux-2.4.11-pre4-preempt/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -mcpu=k6 
-mpreferred-stack-boundary=2 -malign-functions=4 -fschedule-insns2 
-fexpensive-optimizations     -c -o mpparse.o mpparse.c
mpparse.c: In function `MP_processor_info':
mpparse.c:195: `clustered_apic_mode' undeclared (first use in this function)
mpparse.c:195: (Each undeclared identifier is reported only once
mpparse.c:195: for each function it appears in.)
mpparse.c: In function `smp_read_mpc':
mpparse.c:386: `clustered_apic_mode' undeclared (first use in this function)
make[1]: *** [mpparse.o] Error 1
make[1]: Leaving directory 
`/usr/src/linux-2.4.11-pre4-preempt/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2
269.520u 29.200s 5:45.26 86.5%  0+0k 0+0io 1007275pf+0w

-Dieter
