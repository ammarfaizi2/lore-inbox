Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317204AbSFKR12>; Tue, 11 Jun 2002 13:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317207AbSFKR11>; Tue, 11 Jun 2002 13:27:27 -0400
Received: from ccs.covici.com ([209.249.181.196]:50071 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S317204AbSFKR10>;
	Tue, 11 Jun 2002 13:27:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15622.13053.861871.941924@ccs.covici.com>
Date: Tue, 11 Jun 2002 13:27:25 -0400
From: John covici <covici@ccs.covici.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.21 fork.c fails to compile
X-Mailer: VM 7.05 under Emacs 21.2.50.1
Reply-To: covici@ccs.covici.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I get the following errors when trying to compile the kernel
2.5.21:

Any assistance would be appreciated.

  gcc -Wp,-MD,.fork.o.d -D__KERNEL__ -I/usr/src/linux-2.5.21/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -nostdinc -iwithprefix include    -DKBUILD_BASENAME=fork   -c -o fork.o fork.c
In file included from fork.c:22:
/usr/src/linux-2.5.21/include/linux/namespace.h:9: field `sem' has incomplete type
/usr/src/linux-2.5.21/include/linux/namespace.h: In function `put_namespace':
/usr/src/linux-2.5.21/include/linux/namespace.h:17: warning: implicit declaration of function `down_write'
/usr/src/linux-2.5.21/include/linux/namespace.h:18: `dcache_lock' undeclared (first use in this function)
/usr/src/linux-2.5.21/include/linux/namespace.h:18: (Each undeclared identifier is reported only once
/usr/src/linux-2.5.21/include/linux/namespace.h:18: for each function it appears in.)
/usr/src/linux-2.5.21/include/linux/namespace.h:21: warning: implicit declaration of function `up_write'
/usr/src/linux-2.5.21/include/linux/namespace.h: In function `exit_namespace':
/usr/src/linux-2.5.21/include/linux/namespace.h:28: dereferencing pointer to incomplete type
/usr/src/linux-2.5.21/include/linux/namespace.h:30: warning: implicit declaration of function `task_lock'
/usr/src/linux-2.5.21/include/linux/namespace.h:31: dereferencing pointer to incomplete type
/usr/src/linux-2.5.21/include/linux/namespace.h:32: warning: implicit declaration of function `task_unlock'
In file included from /usr/src/linux-2.5.21/include/linux/fs.h:19,
                 from fork.c:26:
/usr/src/linux-2.5.21/include/linux/dcache.h: At top level:
/usr/src/linux-2.5.21/include/linux/dcache.h:136: `dcache_lock' used prior to declaration
In file included from /usr/src/linux-2.5.21/include/asm/semaphore.h:42,
                 from /usr/src/linux-2.5.21/include/linux/fs.h:207,
                 from fork.c:26:
/usr/src/linux-2.5.21/include/linux/rwsem.h:52: warning: `down_write' was declared implicitly `extern' and later `static'
/usr/src/linux-2.5.21/include/linux/namespace.h:17: warning: previous declaration of `down_write'
/usr/src/linux-2.5.21/include/linux/rwsem.h:52: warning: type mismatch with previous implicit declaration
/usr/src/linux-2.5.21/include/linux/namespace.h:17: warning: previous implicit declaration of `down_write'
/usr/src/linux-2.5.21/include/linux/rwsem.h:52: warning: `down_write' was previously implicitly declared to return `int'
/usr/src/linux-2.5.21/include/linux/rwsem.h:72: warning: `up_write' was declared implicitly `extern' and later `static'
/usr/src/linux-2.5.21/include/linux/namespace.h:21: warning: previous declaration of `up_write'
/usr/src/linux-2.5.21/include/linux/rwsem.h:72: warning: type mismatch with previous implicit declaration
/usr/src/linux-2.5.21/include/linux/namespace.h:21: warning: previous implicit declaration of `up_write'
/usr/src/linux-2.5.21/include/linux/rwsem.h:72: warning: `up_write' was previously implicitly declared to return `int'
In file included from /usr/src/linux-2.5.21/include/linux/mm.h:4,
                 from /usr/src/linux-2.5.21/include/asm/pgalloc.h:8,
                 from fork.c:29:
/usr/src/linux-2.5.21/include/linux/sched.h:760: warning: `task_lock' was declared implicitly `extern' and later `static'
/usr/src/linux-2.5.21/include/linux/namespace.h:30: warning: previous declaration of `task_lock'
/usr/src/linux-2.5.21/include/linux/sched.h:760: warning: type mismatch with previous implicit declaration
/usr/src/linux-2.5.21/include/linux/namespace.h:30: warning: previous implicit declaration of `task_lock'
/usr/src/linux-2.5.21/include/linux/sched.h:760: warning: `task_lock' was previously implicitly declared to return `int'
/usr/src/linux-2.5.21/include/linux/sched.h:765: warning: `task_unlock' was declared implicitly `extern' and later `static'
/usr/src/linux-2.5.21/include/linux/namespace.h:32: warning: previous declaration of `task_unlock'
/usr/src/linux-2.5.21/include/linux/sched.h:765: warning: type mismatch with previous implicit declaration
/usr/src/linux-2.5.21/include/linux/namespace.h:32: warning: previous implicit declaration of `task_unlock'
/usr/src/linux-2.5.21/include/linux/sched.h:765: warning: `task_unlock' was previously implicitly declared to return `int'
fork.c: In function `do_fork':
/usr/src/linux-2.5.21/include/linux/namespace.h:32: conflicting types for `task_unlock'
/usr/src/linux-2.5.21/include/linux/sched.h:765: previous declaration of `task_unlock'
/usr/src/linux-2.5.21/include/linux/namespace.h:30: conflicting types for `task_lock'
/usr/src/linux-2.5.21/include/linux/sched.h:760: previous declaration of `task_lock'
/usr/src/linux-2.5.21/include/linux/namespace.h:17: conflicting types for `down_write'
/usr/src/linux-2.5.21/include/linux/rwsem.h:52: previous declaration of `down_write'
/usr/src/linux-2.5.21/include/linux/namespace.h:21: conflicting types for `up_write'
/usr/src/linux-2.5.21/include/linux/rwsem.h:72: previous declaration of `up_write'
make[2]: *** [fork.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.21/kernel'
make[1]: *** [kernel] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.21'
make: *** [make_with_config] Error 2

-- 
         John Covici
         covici@ccs.covici.com
