Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVDMBZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVDMBZq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVDLT5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:57:04 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:43167 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262162AbVDLSRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 14:17:48 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc2-V0.7.44-00
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark Constable <markc@renta.net>, Steven Rostedt <rostedt@goodmis.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20050410174723.GC18768@elte.hu>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu>
	 <20050401104724.GA31971@elte.hu> <20050405071911.GA23653@elte.hu>
	 <42596101.3010205@cybsft.com> <20050410172759.GA16654@elte.hu>
	 <1113154793.20980.15.camel@localhost.localdomain>
	 <20050410174723.GC18768@elte.hu>
Content-Type: text/plain
Date: Tue, 12 Apr 2005 14:17:46 -0400
Message-Id: <1113329867.31159.38.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-10 at 19:47 +0200, Ingo Molnar wrote:
> yeah, that's what i did in -45-01.
> 

Ingo,

This build failure was reported with 45-01 by an AMD64 user.  Do you
need the .config?

  HOSTCC  scripts/bin2c
  CC      arch/x86_64/kernel/asm-offsets.s
  CHK     include/asm-x86_64/offset.h
  UPD     include/asm-x86_64/offset.h
  CC      init/main.o
In file included from include/linux/rwsem.h:38,
                 from include/linux/kobject.h:24,
                 from include/linux/module.h:19,
                 from init/main.c:16:
include/asm/rwsem.h:55: error: redefinition of `struct rw_semaphore'
In file included from include/linux/rwsem.h:38,
                 from include/linux/kobject.h:24,
                 from include/linux/module.h:19,
                 from init/main.c:16:
include/asm/rwsem.h:79:1: warning: "__RWSEM_INITIALIZER" redefined
In file included from include/linux/spinlock.h:16,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from include/linux/module.h:10,
                 from init/main.c:16:
include/linux/rt_lock.h:295:1: warning: this is the location of the
previous definition
In file included from include/linux/rwsem.h:38,
                 from include/linux/kobject.h:24,
                 from include/linux/module.h:19,
                 from init/main.c:16:
include/asm/rwsem.h:83:1: warning: "DECLARE_RWSEM" redefined
In file included from include/linux/spinlock.h:16,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from include/linux/module.h:10,
                 from init/main.c:16:
include/linux/rt_lock.h:298:1: warning: this is the location of the
previous definition
include/asm/rwsem.h:86: error: parse error before "do"
In file included from include/linux/kobject.h:24,
                 from include/linux/module.h:19,
                 from init/main.c:16:
include/linux/rwsem.h: In function `compat_down_read':
include/linux/rwsem.h:56: warning: passing arg 1 of `__down_read' from
incompatible pointer type
include/linux/rwsem.h: In function `compat_down_read_trylock':
include/linux/rwsem.h:67: warning: passing arg 1 of
`__down_read_trylock' from incompatible pointer type
include/linux/rwsem.h: In function `compat_down_write':
include/linux/rwsem.h:79: warning: passing arg 1 of `__down_write' from
incompatible pointer type
include/linux/rwsem.h: In function `compat_down_write_trylock':
include/linux/rwsem.h:90: warning: passing arg 1 of
`__down_write_trylock' from incompatible pointer type
include/linux/rwsem.h: In function `compat_up_read':
include/linux/rwsem.h:101: warning: passing arg 1 of `__up_read' from
incompatible pointer type
include/linux/rwsem.h: In function `compat_up_write':
include/linux/rwsem.h:111: warning: passing arg 1 of `__up_write' from
incompatible pointer type
include/linux/rwsem.h: In function `compat_downgrade_write':
include/linux/rwsem.h:121: warning: passing arg 1 of `__downgrade_write'
from incompatible pointer type
In file included from include/linux/proc_fs.h:6,
                 from init/main.c:17:
include/linux/fs.h: In function `lock_super':
include/linux/fs.h:828: warning: implicit declaration of function
`compat_down'
include/linux/fs.h: In function `unlock_super':
include/linux/fs.h:833: warning: implicit declaration of function
`compat_up'
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2

Lee

