Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288814AbSBMT7Z>; Wed, 13 Feb 2002 14:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288821AbSBMT7P>; Wed, 13 Feb 2002 14:59:15 -0500
Received: from fcaglp.fcaglp.unlp.edu.ar ([163.10.4.1]:55977 "EHLO
	fcaglp.fcaglp.unlp.edu.ar") by vger.kernel.org with ESMTP
	id <S288814AbSBMT7I>; Wed, 13 Feb 2002 14:59:08 -0500
Message-ID: <3C6AC57A.89EDDEC6@fcaglp.fcaglp.unlp.edu.ar>
Date: Wed, 13 Feb 2002 16:58:50 -0300
From: "Eduardo A. Suarez" <esuarez@fcaglp.fcaglp.unlp.edu.ar>
Organization: Observatorio Astronomico de La Plata
X-Mailer: Mozilla 4.7 [en] (X11; I; SunOS 5.8 sun4m)
X-Accept-Language: Spanish/Argentina, es-AR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: O(1)-K3 compile error in sparc32
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am using gcc-2.95.2, binutils 2.11.2 on a Sparc10 SMP with 2.4.18-pre9-SMP.
When I try to compile 2.4.18-pre9 + SMP + O(1)-K3 scheduler I get:

make[2]: Entering directory `/usr/src/linux/kernel'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -m32
-pipe -mno-fpu -fcall-used-g5 -fcall-used-g7 -DKBUILD_BASENAME=sched 
-fno-omit-frame-pointer -c -o sched.o sched.c
sched.c: In function `load_balance':
sched.c:569: warning: implicit declaration of function `sched_find_first_bit'
sched.c:571: warning: implicit declaration of function `find_next_bit'
sched.c: In function `set_cpus_allowed':
sched.c:984: warning: implicit declaration of function `__ffs'
{standard input}: Assembler messages:
{standard input}:3115: Error: Symbol flush_patch_switch already defined.
{standard input}:3223: Error: Symbol patchme_store_new_current already defined.
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory `/usr/src/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux/kernel'
make: *** [_dir_kernel] Error 2

Thanks,
	Eduardo.-
