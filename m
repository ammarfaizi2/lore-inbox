Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbVINP4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbVINP4X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 11:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbVINP4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 11:56:22 -0400
Received: from dvhart.com ([64.146.134.43]:27011 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1030208AbVINP4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 11:56:21 -0400
Message-ID: <43284816.8010501@dvhart.com>
Date: Wed, 14 Sep 2005 08:56:06 -0700
From: Darren Hart <darren@dvhart.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       George Anzinger <george@mvista.com>
Subject: Re: 2.6.13-rt6, ktimer subsystem
References: <20050913100040.GA13103@elte.hu>
In-Reply-To: <20050913100040.GA13103@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
 > i have released the 2.6.13-rt6 tree, which can be downloaded from the
 > usual place:
 >
 >   http://redhat.com/~mingo/realtime-preempt/

I haven't been able to get 2.6.13-rt6 to compile on a 16 way x440 (SUMMIT) with 
gcc-2.95.  Is there a known minimum compiler version?  The same config builds 
fine on a P3 8 way with gcc-3.3.5.

Make output:

   CHK     include/linux/version.h
   SYMLINK include/asm -> include/asm-i386
   SPLIT   include/linux/autoconf.h -> include/config/*
   UPD     include/linux/version.h
   HOSTCC  scripts/kallsyms
   HOSTCC  scripts/conmakehash
   HOSTCC  scripts/testlpp
scripts/testlpp.c: In function `cleanup':
scripts/testlpp.c:90: warning: use of `l' length character with `f' type character
scripts/testlpp.c:92: warning: use of `l' length character with `f' type character
scripts/testlpp.c:94: warning: use of `l' length character with `f' type character
scripts/testlpp.c: In function `main':
scripts/testlpp.c:142: warning: use of `l' length character with `f' type character
   CC      arch/i386/kernel/asm-offsets.s
In file included from include/linux/time.h:7,
                  from include/linux/timex.h:58,
                  from include/linux/sched.h:11,
                  from arch/i386/kernel/asm-offsets.c:7:
include/linux/seqlock.h: In function `__write_seqlock':
include/linux/seqlock.h:75: warning: implicit declaration of function 
`__builtin_types_compatible_p'
include/linux/seqlock.h:75: parse error before `typeof'
include/linux/seqlock.h: In function `__write_sequnlock':
include/linux/seqlock.h:84: parse error before `typeof'
include/linux/seqlock.h: In function `__write_tryseqlock':
include/linux/seqlock.h:89: parse error before `typeof'
include/linux/seqlock.h: In function `__read_seqretry':
include/linux/seqlock.h:126: parse error before `typeof'
include/linux/seqlock.h:127: parse error before `typeof'
include/linux/seqlock.h: In function `__write_seqlock_raw':
include/linux/seqlock.h:134: parse error before `typeof'
include/linux/seqlock.h: In function `__write_sequnlock_raw':
include/linux/seqlock.h:143: parse error before `typeof'
include/linux/seqlock.h: In function `__write_tryseqlock_raw':
include/linux/seqlock.h:148: parse error before `typeof'
In file included from include/asm/semaphore.h:40,
                  from include/linux/sched.h:20,
                  from arch/i386/kernel/asm-offsets.c:7:
include/linux/wait.h: In function `init_waitqueue_head':
include/linux/wait.h:84: parse error before `typeof'
In file included from include/linux/ktimer.h:207,
                  from include/linux/sched.h:254,
                  from arch/i386/kernel/asm-offsets.c:7:

Thanks,

-- 
Darren Hart
IBM Linux Technology Center
Linux Kernel Team
Phone: 503 578 3185
   T/L: 775 3185

