Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVDBSFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVDBSFe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 13:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVDBSEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 13:04:32 -0500
Received: from lx09-hrz.uni-duisburg.de ([134.91.4.50]:20611 "EHLO
	lx09-hrz.uni-duisburg.de") by vger.kernel.org with ESMTP
	id S261718AbVDBSEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 13:04:16 -0500
Message-ID: <424EDE92.7000609@folkwang-hochschule.de>
Date: Sat, 02 Apr 2005 20:04:02 +0200
From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mingo@redhat.com
CC: nettings@folkwang-hochschule.de
Subject: can't compile 2.6.12-rc1-RT-V0.7.43-06 on amd64
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi ingo, hi everyone!


no luck w/ latest realtime-preempt on amd64:

nettings@kleineronkel:/local/build/linux> make
   CHK     include/linux/version.h
make[1]: `arch/x86_64/kernel/asm-offsets.s' is up to date.
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
include/linux/rt_lock.h:285:1: warning: this is the location of the
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
include/linux/rt_lock.h:288:1: warning: this is the location of the
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
include/linux/fs.h:829: warning: implicit declaration of function
`compat_down'
include/linux/fs.h: In function `unlock_super':
include/linux/fs.h:834: warning: implicit declaration of function
`compat_up'
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2

configuration is here:
http://spunk.dnsalias.org/download/2.6.12-rc1-RT-V0.7.43-0.config


any hints appreciated.


best,

jörn


