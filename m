Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVHRWyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVHRWyk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 18:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbVHRWyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 18:54:39 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25351 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932125AbVHRWyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 18:54:38 -0400
Date: Fri, 19 Aug 2005 00:54:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: 2.6.13-rc6-rt9: compile errors
Message-ID: <20050818225429.GI3822@stusta.de>
References: <20050818060126.GA13152@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050818060126.GA13152@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following compile errors:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `pi_init':
: multiple definition of `pi_init'
kernel/built-in.o:(.bss+0x80f0): first defined here
ld: Warning: size of symbol `pi_init' changed from 4 in kernel/built-in.o to 675 in drivers/built-in.o
ld: Warning: type of symbol `pi_init' changed from 1 to 2 in drivers/built-in.o
fs/built-in.o: In function `jffs2_do_crccheck_inode':
: undefined reference to `there_is_no_init_MUTEX_LOCKED_for_RT_semaphores'
fs/built-in.o: In function `jffs2_i_init_once':
super.c:(.text+0x1d1137): undefined reference to `there_is_no_init_MUTEX_LOCKED_for_RT_semaphores'
drivers/built-in.o: In function `si_restart_short_timer':
ipmi_si_intf.c:(.text+0x21f395): undefined reference to `__bad_spinlock_type'
drivers/built-in.o: In function `smi_timeout':
ipmi_si_intf.c:(.text+0x21f5ca): undefined reference to `__bad_spinlock_type'
ipmi_si_intf.c:(.text+0x21f5fa): undefined reference to `__bad_spinlock_type'
drivers/built-in.o: In function `carm_init_one':
sx8.c:(.text+0x28ebcd): undefined reference to `there_is_no_init_MUTEX_LOCKED_for_RT_semaphores'
drivers/built-in.o: In function `plip_close':
plip.c:(.text+0x2bae71): undefined reference to `there_is_no_init_MUTEX_LOCKED_for_RT_semaphores'
drivers/built-in.o: In function `sixpack_open':
6pack.c:(.text+0x47640c): undefined reference to `there_is_no_init_MUTEX_LOCKED_for_RT_semaphores'
drivers/built-in.o: In function `mc32_probe1':
3c527.c:(.init.text+0x333d9): undefined reference to `there_is_no_init_MUTEX_LOCKED_for_RT_semaphores'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

Note: pi_init is a global function in drivers/block/paride/paride.c .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

