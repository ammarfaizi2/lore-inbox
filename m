Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317962AbSFSRwH>; Wed, 19 Jun 2002 13:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317961AbSFSRwG>; Wed, 19 Jun 2002 13:52:06 -0400
Received: from speech.linux-speakup.org ([129.100.109.30]:31965 "EHLO
	speech.braille.uwo.ca") by vger.kernel.org with ESMTP
	id <S317959AbSFSRwE>; Wed, 19 Jun 2002 13:52:04 -0400
To: linux-kernel@vger.kernel.org
Subject: another sched.c error with athlon
From: Kirk Reiser <kirk@braille.uwo.ca>
Date: 19 Jun 2002 13:52:01 -0400
In-Reply-To: <20020619124252.V4360-100000@abbey.hauschen>
Message-ID: <x7hejzyx4u.fsf@speech.braille.uwo.ca>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another error I'm getting from sched.c and don't seem to be
able to find where it should be #define'd.

  gcc -Wp,-MD,./.sched.o.d -D__KERNEL__
  -I/usr/src/linux-2.5.23/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=i686
-malign-functions=4  -nostdinc -iwithprefix include
-fno-omit-frame-pointer -DKBUILD_BASENAME=sched   -c -o sched.o
sched.c
sched.c: In function `sys_sched_setaffinity':
sched.c:1332: `cpu_online_map' undeclared (first use in this function)
sched.c:1332: (Each undeclared identifier is reported only once
sched.c:1332: for each function it appears in.)
sched.c: In function `sys_sched_getaffinity':
sched.c:1391: `cpu_online_map' undeclared (first use in this function)
make[1]: *** [sched.o] Error 1


The only reference I can find is in smp.h but don't see it actually
declared there either only used.  I'm not using smp and have
CONFIG_smp set to no.

  Kirk

-- 

Kirk Reiser				The Computer Braille Facility
e-mail: kirk@braille.uwo.ca		University of Western Ontario
phone: (519) 661-3061
