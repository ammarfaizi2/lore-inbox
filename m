Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbTDHPXl (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 11:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbTDHPXl (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 11:23:41 -0400
Received: from wsip68-15-133-54.hr.hr.cox.net ([68.15.133.54]:35758 "HELO
	sc-inetworks.net") by vger.kernel.org with SMTP id S261844AbTDHPXi (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 11:23:38 -0400
Date: Tue, 8 Apr 2003 12:34:17 -0400
From: Jared Young <headgeek@li.nu-x.net>
To: linux-kernel@vger.kernel.org
Subject: Help!!! Pthread Sh*T
Message-Id: <20030408123417.5485ba9e.headgeek@li.nu-x.net>
Organization: Li.nu-x.net
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I installed pthread libaries recently, anyhow, I keep getting errors what I cannot work around with gcc and make in general. I cannot even compile a new gcc to allow for the new pthread extenstion. I uninstalled pthread libs in hopes to restore prior state but umm yah. After reinstalling::

Current Kernel:2.4.20
Current GCC:2.95.3
Current Pthread:1.4.1

This was the error I got when building commoncpp-2-1.0.9, but this error is similar in everything else I try to build.

::Configure options::::
./configure  --prefix=/usr --sysconfdir=/etc --with-pthread --with-ftp


In this section I noticed this:

checking for pthread.h... (cached) yes
checking for sys/atomic.h... (cached) no
checking for thread.h... (cached) no
checking for nanosleep in -lyes... (cached) no
checking for nanosleep in -lposix4... (cached) no
checking for nanosleep in -lrt... (cached) yes
checking if more special flags are required for pthreads... no
checking for pthread_np.h... (cached) no
checking for semaphore.h... (cached) yes
checking for sched.h... (cached) yes
checking for sys/sched.h... (cached) no
checking for sched_getscheduler... (cached) yes
checking for recursive mutex type support... (cached) none
checking for pthread_mutexattr_settype in -lyes... (cached) no
checking for pthread_mutexattr_settype_np in -lyes... (cached) no
checking for pthread_mutexattr_setkind_np in -lyes... (cached) no
checking for pthread_rwlock_init in -lyes... (cached) no
checking for pread in -lc... (cached) yes
checking for pthread_suspend in -lyes... (cached) no
checking for pthread_attr_setstacksize in -lyes... (cached) no
checking for pthread_yield in -lyes... (cached) no
checking for sched_yield in -lyes... (cached) no
checking for pthread_cancel in -lyes... (cached) no
checking for pthread_setcanceltype in -lyes... (cached) no
checking for pthread_delay_np in -lyes... (cached) no



::ERROR::::

make[1]: Entering directory `/usr/src/commoncpp2-1.0.9/src'
/bin/sh ../libtool --mode=compile c++ -DHAVE_CONFIG_H -I. -I. -I../include     -I../src -DCCXX_EXPORT_LIBRARY  -g -O2 -D_GNU_SOURCE  -I/usr/include/libxml2 -I../include -c thread.cpp
rm -f .libs/thread.lo
c++ -DHAVE_CONFIG_H -I. -I. -I../include -I../src -DCCXX_EXPORT_LIBRARY -g -O2 -D_GNU_SOURCE -I/usr/include/libxml2 -I../include -c thread.cpp  -fPIC -DPIC -o .libs/thread.lo
In file included from ../include/cc++/config.h:482,
                 from thread.cpp:41:
/usr/include/pthread.h:53: warning: `_BITS_PTHREADTYPES_H' redefined
/usr/include/bits/pthreadtypes.h:20: warning: this is the location of the previous definition
/usr/include/pthread.h:55: warning: `_BITS_SIGTHREAD_H' redefined
/usr/include/bits/sigthread.h:21: warning: this is the location of the previous definition
In file included from ../include/cc++/config.h:482,
                 from thread.cpp:41:
/usr/include/pthread.h:275: conflicting types for `typedef struct pthread_st * pthread_t'
/usr/include/bits/pthreadtypes.h:140: previous declaration as `typedef long unsigned int pthread_t'
/usr/include/pthread.h:276: conflicting types for `typedef struct pthread_attr_st * pthread_attr_t'
/usr/include/bits/pthreadtypes.h:52: previous declaration as `typedef struct __pthread_attr_s pthread_attr_t'
/usr/include/pthread.h:277: conflicting types for `typedef int pthread_key_t'
/usr/include/bits/pthreadtypes.h:70: previous declaration as `typedef unsigned int pthread_key_t'
/usr/include/pthread.h:279: conflicting types for `typedef int pthread_mutexattr_t'
/usr/include/bits/pthreadtypes.h:90: previous declaration as `typedef struct pthread_mutexattr_t pthread_mutexattr_t'
/usr/include/pthread.h:280: conflicting types for `typedef struct pthread_mutex_st * pthread_mutex_t'
/usr/include/bits/pthreadtypes.h:83: previous declaration as `typedef struct pthread_mutex_t pthread_mutex_t'
/usr/include/pthread.h:281: conflicting types for `typedef int pthread_condattr_t'
/usr/include/bits/pthreadtypes.h:67: previous declaration as `typedef struct pthread_condattr_t pthread_condattr_t'
/usr/include/pthread.h:282: conflicting types for `typedef struct pthread_cond_st * pthread_cond_t'
/usr/include/bits/pthreadtypes.h:60: previous declaration as `typedef struct pthread_cond_t pthread_cond_t'
/usr/include/pthread.h:283: conflicting types for `typedef int pthread_rwlockattr_t'
/usr/include/bits/pthreadtypes.h:116: previous declaration as `typedef struct pthread_rwlockattr_t pthread_rwlockattr_t'
/usr/include/pthread.h:284: conflicting types for `typedef struct pthread_rwlock_st * pthread_rwlock_t'
/usr/include/bits/pthreadtypes.h:108: previous declaration as `typedef struct _pthread_rwlock_t pthread_rwlock_t'
/usr/include/pthread.h:347: declaration of C function `int pthread_kill(pthread_st *, int)' conflicts with
/usr/include/bits/sigthread.h:36: previous declaration `int pthread_kill(long unsigned int, int)' here
thread.cpp:96: multiple storage classes in declaration of `sigcancel'
thread.cpp:917: `thread_cancel_t' was not declared in this scope
thread.cpp:917: parse error before `)'
thread.cpp:918: prototype for `void ost::Thread::setCancel(...)' does not match any in class `ost::Thread'
../include/cc++/thread.h:1190: candidate is: void ost::Thread::setCancel(ost::Thread::Cancel)
thread.cpp: In method `void ost::Thread::setCancel(...)':
thread.cpp:924: `mode' undeclared (first use this function)
thread.cpp:924: (Each undeclared identifier is reported only once
thread.cpp:924: for each function it appears in.)
make[1]: *** [thread.lo] Error 1
make[1]: Leaving directory `/usr/src/commoncpp2-1.0.9/src'
make: *** [all-recursive] Error 1

-- 
????????????????????????????????????????????????????????????????????
????????????????????????????????????????????????????????????????????
????? Jared A, Young      602 Crown Point Drive  (757)246-8755 ?????
????? SC-Inetworks, Inc.  Newport News, Virginia    23602-7009 ?????
????? ???????????????????????????????????????????????????????? ?????
????? Headgeek@li.nu-x.net           Administration & Security ?????
????????????????????????????????????????????????????????????????????
????????????????????????????????????????????????????????????????????
 ????????    LFS Advocation http://linuxfromscratch.org    ????????
????????????????????????????????????????????????????????????????????

