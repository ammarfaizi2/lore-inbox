Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268141AbTCFOIM>; Thu, 6 Mar 2003 09:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268143AbTCFOIM>; Thu, 6 Mar 2003 09:08:12 -0500
Received: from norma.kjist.ac.kr ([203.237.41.18]:41103 "EHLO
	norma.kjist.ac.kr") by vger.kernel.org with ESMTP
	id <S268141AbTCFOIK>; Thu, 6 Mar 2003 09:08:10 -0500
Date: Thu, 6 Mar 2003 23:32:48 +0900 (KST)
From: Maintaniner on duty <hugh@norma.kjist.ac.kr>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.21-pre4aa3 compile error in time.c
Message-ID: <Pine.LNX.4.33.0303062326340.8113-100000@norma.kjist.ac.kr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On UP2000 with two 21264's, SuSE-7.3, I got the following
compile error:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.21-pre4aa3/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-finline-limit=2000 -fomit-frame-pointer -pipe -mno-fp-regs -ffixed-8
-mcpu=ev67 -Wa,-mev6   -nostdinc -iwithprefix include
-DKBUILD_BASENAME=time  -c -o time.o time.c
time.c:51: parse error before `xtime_lock'
time.c:51: warning: type defaults to `int' in declaration of `xtime_lock'
time.c:51: warning: data definition has no type or storage class
time.c: In function `timer_interrupt':
time.c:104: warning: implicit declaration of function `fr_write_lock'
time.c:136: warning: implicit declaration of function `fr_write_unlock'
time.c: In function `do_gettimeofday':
time.c:399: warning: implicit declaration of function `fr_read_begin'
time.c:407: warning: implicit declaration of function `fr_read_end'
time.c: In function `do_settimeofday':
time.c:449: warning: implicit declaration of function `fr_write_lock_irq'
time.c:480: warning: implicit declaration of function
`fr_write_unlock_irq'
make[1]: *** [time.o] Error 1
make[1]: Leaving directory
`/usr/src/linux-2.4.21-pre4aa3/arch/alpha/kernel'
make: *** [_dir_arch/alpha/kernel] Error 2



Regards,

G. H. S.



