Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbVLLRm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbVLLRm1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 12:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbVLLRm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 12:42:27 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:58798 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751028AbVLLRm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 12:42:26 -0500
Subject: 2.6.15-rc5-rt1 will not compile (was Re: 2.6.14-rt15: cannot build
	with !PREEMPT_RT)
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <1134174330.18432.46.camel@mindpipe>
References: <1133031912.5904.12.camel@mindpipe>
	 <1133034406.32542.308.camel@tglx.tec.linutronix.de>
	 <20051127123052.GA22807@elte.hu> <1133141224.4909.1.camel@mindpipe>
	 <20051128114852.GA3391@elte.hu> <1133189789.5228.7.camel@mindpipe>
	 <20051128160052.GA29540@elte.hu> <1133217651.4678.2.camel@mindpipe>
	 <1133230103.5640.0.camel@mindpipe> <20051129072922.GA21696@elte.hu>
	 <20051129093231.GA5028@elte.hu>  <1134090316.11053.3.camel@mindpipe>
	 <1134174330.18432.46.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 12:44:29 -0500
Message-Id: <1134409469.15074.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 19:25 -0500, Lee Revell wrote:
> > We are unable to build a similar .config (PREEMPT_DESKTOP with soft and
> > hardirq preemption disabled) on x86-64:
> 
> Here is the build output, .config attached.

Similar problem with 2.6.15-rc5-rt1:

$ make
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  SYMLINK include/asm -> include/asm-x86_64
  SPLIT   include/linux/autoconf.h -> include/config/*
  CC      arch/x86_64/kernel/asm-offsets.s
In file included from include/asm/semaphore.h:48,
                 from include/linux/sched.h:20,
                 from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/rwsem.h:43:66: error: asm/rwsem.h: No such file or
directory
In file included from include/asm/semaphore.h:48,
                 from include/linux/sched.h:20,
                 from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/rwsem.h: In function 'compat_down_read':
include/linux/rwsem.h:61: warning: implicit declaration of function
'__down_read'
include/linux/rwsem.h: In function 'compat_down_read_trylock':
include/linux/rwsem.h:72: warning: implicit declaration of function
'__down_read_trylock'
include/linux/rwsem.h: In function 'compat_down_write':
include/linux/rwsem.h:84: warning: implicit declaration of function
'__down_write'
include/linux/rwsem.h: In function 'compat_down_write_trylock':
include/linux/rwsem.h:95: warning: implicit declaration of function
'__down_write_trylock'
include/linux/rwsem.h: In function 'compat_up_read':
include/linux/rwsem.h:106: warning: implicit declaration of function
'__up_read'
include/linux/rwsem.h: In function 'compat_up_write':
include/linux/rwsem.h:116: warning: implicit declaration of function
'__up_write'
include/linux/rwsem.h: In function 'compat_downgrade_write':
include/linux/rwsem.h:126: warning: implicit declaration of function
'__downgrade_write'
include/linux/rwsem.h: In function 'init_rwsem':
include/linux/rwsem.h:136: warning: implicit declaration of function
'compat_init_rwsem'
In file included from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/sched.h: At top level:
include/linux/sched.h:485: error: field 'mmap_sem' has incomplete type
make[1]: *** [arch/x86_64/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2

