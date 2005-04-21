Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVDUJbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVDUJbd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 05:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVDUJbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 05:31:33 -0400
Received: from natpreptil.rzone.de ([81.169.145.163]:47030 "EHLO
	natpreptil.rzone.de") by vger.kernel.org with ESMTP id S261236AbVDUJbK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 05:31:10 -0400
Message-ID: <426772F3.1020504@man-made.de>
Date: Thu, 21 Apr 2005 11:31:31 +0200
From: Frank Schruefer <kernel@man-made.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: COMPILE-ERROR: 'make prepare ARCH=um' fails on 2.6.11.7
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

'make prepare ARCH=um' spits out some serious errors.
'make ARCH=um' works though - just takes ways longer ...

Here are the 3 commands to reproduce plus the errornous output:

-------------------------------------------------------------
Stone:/usr/src/linux-2.6.11.7 # uname -a
Linux Stone 2.6.11.7 #3 Wed Apr 20 14:03:23 CEST 2005 i686 athlon i386 GNU/Linux
Stone:/usr/src/linux-2.6.11.7 # make mrproper
   CLEAN   scripts/basic
   CLEAN   scripts/kconfig
   CLEAN   .config include/linux/autoconf.h
Stone:/usr/src/linux-2.6.11.7 # make defconfig ARCH=um > /dev/null
/usr/src/linux-2.6.11.7/arch/um/defconfig:199: trying to assign nonexistent symbol KGDBOE
/usr/src/linux-2.6.11.7/arch/um/defconfig:262: trying to assign nonexistent symbol REISER4_FS
/usr/src/linux-2.6.11.7/arch/um/defconfig:282: trying to assign nonexistent symbol FSCACHE
Stone:/usr/src/linux-2.6.11.7 # make prepare ARCH=um
   HOSTCC  arch/um/sys-i386/util/mk_sc
   HOSTCC  arch/um/kernel/skas/util/mk_ptregs-i386.o
   HOSTLD  arch/um/kernel/skas/util/mk_ptregs
   CHK     arch/um/include/skas_ptregs.h
   CHK     arch/um/include/sysdep-i386/sc.h
   CHK     arch/um/include/uml-config.h
   UPD     arch/um/include/uml-config.h
   HOSTCC  arch/um/util/mk_constants_kern.o
   HOSTCC  arch/um/util/mk_constants_user.o
   HOSTCC  arch/um/util/mk_task_kern.o
In file included from include/linux/list.h:7,
                  from include/linux/wait.h:23,
                  from /usr/include/asm/semaphore.h:41,
                  from include/linux/sched.h:19,
                  from arch/um/util/mk_task_kern.c:1:
include/linux/prefetch.h: In function `prefetch_range':
include/linux/prefetch.h:64: error: `CONFIG_X86_L1_CACHE_SHIFT' undeclared (first use in this function)
include/linux/prefetch.h:64: error: (Each undeclared identifier is reported only once
include/linux/prefetch.h:64: error: for each function it appears in.)
In file included from arch/um/util/mk_task_kern.c:1:
include/linux/sched.h:23:25: asm/cputime.h: No such file or directory
In file included from arch/um/util/mk_task_kern.c:1:
include/linux/sched.h: At top level:
include/linux/sched.h:318: error: parse error before "cputime_t"
include/linux/sched.h:318: warning: no semicolon at end of struct or union
include/linux/sched.h:332: error: parse error before '}' token
include/linux/sched.h:597: error: parse error before "cputime_t"
include/linux/sched.h:597: warning: no semicolon at end of struct or union
include/linux/sched.h:598: warning: type defaults to `int' in declaration of `it_prof_value'
include/linux/sched.h:598: warning: type defaults to `int' in declaration of `it_prof_incr'
include/linux/sched.h:598: warning: data definition has no type or storage class
include/linux/sched.h:600: error: parse error before "utime"
include/linux/sched.h:600: warning: type defaults to `int' in declaration of `utime'
include/linux/sched.h:600: warning: type defaults to `int' in declaration of `stime'
include/linux/sched.h:600: warning: data definition has no type or storage class
include/linux/sched.h:610: error: parse error before ':' token
include/linux/sched.h:688: error: parse error before '}' token
include/linux/sched.h: In function `process_group':
include/linux/sched.h:692: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `pid_alive':
include/linux/sched.h:705: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `dequeue_signal_lock':
include/linux/sched.h:870: error: dereferencing pointer to incomplete type
include/linux/sched.h:872: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `on_sig_stack':
include/linux/sched.h:912: error: dereferencing pointer to incomplete type
include/linux/sched.h:912: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `sas_ss_flags':
include/linux/sched.h:917: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `capable':
include/linux/sched.h:928: error: dereferencing pointer to incomplete type
include/linux/sched.h:929: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `thread_group_empty':
include/linux/sched.h:1026: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `task_lock':
include/linux/sched.h:1044: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `task_unlock':
include/linux/sched.h:1049: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `set_tsk_thread_flag':
include/linux/sched.h:1057: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `clear_tsk_thread_flag':
include/linux/sched.h:1062: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `test_and_set_tsk_thread_flag':
include/linux/sched.h:1067: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `test_and_clear_tsk_thread_flag':
include/linux/sched.h:1072: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `test_tsk_thread_flag':
include/linux/sched.h:1077: error: dereferencing pointer to incomplete type
arch/um/util/mk_task_kern.c: In function `main':
arch/um/util/mk_task_kern.c:13: error: dereferencing pointer to incomplete type
arch/um/util/mk_task_kern.c:14: error: dereferencing pointer to incomplete type
make[1]: *** [arch/um/util/mk_task_kern.o] Error 1
make: *** [arch/um/util] Error 2
Stone:/usr/src/linux-2.6.11.7 #
-------------------------------------------------------------

-- 

Thanks,
    Frank Schruefer
    SITEFORUM Software Europe GmbH
    Germany (Thuringia)

