Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265885AbTBCUuc>; Mon, 3 Feb 2003 15:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbTBCUuc>; Mon, 3 Feb 2003 15:50:32 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:33193 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265885AbTBCUu3>; Mon, 3 Feb 2003 15:50:29 -0500
Message-Id: <4.3.2.7.2.20030203213508.00b62350@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 03 Feb 2003 22:00:56 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: 2.4.20(-pre4) traps and 2.4 19
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Informix 9.30UC4 benchmark from ESQLC 2.80CSDK.
	What's causing the "devic.." interrupts ?
	Basis system Suse 8.1, kernel orig, Mantel, 2.4.20pre and 2.4.21pre.

--snip sorted by time --
    145 system_call                                2.5893
     87 device_not_available                       1.8125
     27 restore_fpu                                0.8710
     42 math_state_restore                         0.8077
    183 do_schedule                                0.3172
      4 ret_from_sys_call                          0.2353
     10 in_group_p                                 0.2326
     28 do_softirq                                 0.1879
      2 sys_gettid                                 0.1429
      6 supplemental_group_member                  0.1277
      3 wake_up_process                            0.1154
      4 __find_get_page                            0.0952
      1 reschedule                                 0.0833
      2 ret_from_exception                         0.0800
    173 sys_semtimedop                             0.0695
     32 update_queue                               0.0570
     17 try_to_wake_up                             0.0484
      8 schedule_timeout                           0.0457
      2 bh_action                                  0.0357
      1 __free_pages                               0.0323
-- end snip --

-- snip sorted by frequency --
    839 total                                      0.0006
    170 do_schedule                                0.2946
    166 sys_semtimedop                             0.0667
    127 system_call                                2.2679
     80 device_not_available                       1.6667
     37 math_state_restore                         0.7115
     30 do_page_fault                              0.0213
     28 do_softirq                                 0.1879
     27 update_queue                               0.0481
     25 restore_fpu                                0.8065
     14 try_to_wake_up                             0.0399
     13 sys_ipc                                    0.0183
      9 do_no_page                                 0.0183
      8 schedule_timeout                           0.0457
      8 in_group_p                                 0.1860
      7 do_wp_page                                 0.0135
      6 do_anonymous_page                          0.0206
      5 timer_bh                                   0.0069
--end snip --

/proc/<main oninit process>/maps

08048000-086f8000 r-xp 00000000 08:02 1060509    /opt/informix/bin/oninit
086f8000-08826000 rw-p 006af000 08:02 1060509    /opt/informix/bin/oninit
08826000-08897000 rwxp 00000000 00:00 0
10000000-18d73000 rw-s 00000000 00:05 98305      /SYSV52564801 (deleted)
18d73000-19d73000 rw-s 00000000 00:05 131074     /SYSV52564802 (deleted)
19d73000-19dae000 rw-s 00000000 00:05 163843     /SYSV52564803 (deleted)
2aaab000-2aabd000 r-xp 00000000 08:02 1108443    /lib/ld-2.2.5.so
2aabd000-2aabe000 rw-p 00011000 08:02 1108443    /lib/ld-2.2.5.so
2aabe000-2aac0000 rw-p 00000000 00:00 0
2aad2000-2aad3000 r-xp 00000000 08:02 441462     /opt/informix/lib/iosm09a.so
2aad3000-2aad4000 rw-p 00000000 08:02 441462     /opt/informix/lib/iosm09a.so
2aad4000-2aade000 r-xp 00000000 08:02 
441698     /opt/informix/lib/libifxpthread.so
2aade000-2aae6000 rw-p 00009000 08:02 
441698     /opt/informix/lib/libifxpthread.so
2aae6000-2aae7000 r-xp 00000000 08:02 441464     /opt/informix/lib/ismdd09a.so
2aae7000-2aae8000 rw-p 00000000 08:02 441464     /opt/informix/lib/ismdd09a.so
2aae8000-2ab0a000 r-xp 00000000 08:02 1108477    /lib/libm.so.6
2ab0a000-2ab0b000 rw-p 00021000 08:02 1108477    /lib/libm.so.6
2ab0b000-2ab0d000 r-xp 00000000 08:02 1108476    /lib/libdl.so.2
2ab0d000-2ab0e000 rw-p 00001000 08:02 1108476    /lib/libdl.so.2
2ab0e000-2ab0f000 rw-p 00000000 00:00 0
2ab0f000-2ab17000 r-xp 00000000 08:02 1108475    /lib/libcrypt.so.1
2ab17000-2ab19000 rw-p 00008000 08:02 1108475    /lib/libcrypt.so.1
2ab19000-2ab40000 rw-p 00000000 00:00 0
2ab40000-2ac54000 r-xp 00000000 08:02 1108444    /lib/libc.so.6
2ac54000-2ac5a000 rw-p 00113000 08:02 1108444    /lib/libc.so.6
2ac5a000-2ac5e000 rw-p 00000000 00:00 0
2ac5e000-2ac69000 r-xp 00000000 08:02 1108479    /lib/libnss_compat.so.2
2ac69000-2ac6a000 rw-p 0000a000 08:02 1108479    /lib/libnss_compat.so.2
2ac6a000-2ac7c000 r-xp 00000000 08:02 1108478    /lib/libnsl.so.1
2ac7c000-2ac7d000 rw-p 00011000 08:02 1108478    /lib/libnsl.so.1
2ac7d000-2ac7f000 rw-p 00000000 00:00 0
7ffc8000-80000000 rwxp fffc9000 00:00 0




 From the Informix Doc:

	Just read till *** MSW ***

 From Machine notes:
	System Requirements:
===================

1.  This product was built on RedHat Linux 6.2 and is targeted
     for Linux Kernel 2.2.14-5 or higher and glibc 2.1.3-15 or higher.
GNU License
===========

1.  This product is shipped with a modified version of libpthread.so,
     which can be found under $INFORMIXDIR/lib/libifxpthread.so.
     The "Terms and Conditions" from the GNU license apply to this file only.
     The IBM Informix copyrights apply to all other files in this distribution.
     You can check the GNU copyright under http://www.gnu.org/copyleft/gpl.html
     or in the GNU General Public License file $INFORMIXDIR/etc/GNUlicense.txt.
     The following changes have been applied to the original
     glibc linuxthreads 2.1.3 sources, which can be downloaded from
     sourceware.cygnus.com or one of the mirror sites under
     glibc/releases/glibc-linuxthreads-2.1.3.tar.gz

$ diff -u /glibc2.1.3-src/linuxthreads/internals.h internals.h
--- /glibc2.1.3-src/linuxthreads/internals.h       Thu Jan 20 17:40:19 2000
+++ internals.h Thu May 11 05:17:56 2000
@@ -240,6 +240,15 @@

  extern char *__pthread_initial_thread_bos;

+/* lowest bottom of stack of any other thread ever allocated
+   This is used for checking stack pointer between this value
+   and __pthread_initial_thread_bos to check other threads
+   before checking initial threads stack. This enables switching
+   the stack of the initial thread (in user level multithreading)
+   and make thread_self() working correctly. see also internals.h */
+
+extern char *__pthread_other_threads_lowest_bos;
+
  /* Indicate whether at least one thread has a user-defined stack (if 1),
     or all threads have stacks supplied by LinuxThreads (if 0). */

@@ -337,15 +346,26 @@
    return THREAD_SELF;
  #else
    char *sp = CURRENT_STACK_FRAME;
-  if (sp >= __pthread_initial_thread_bos)
-    return &__pthread_initial_thread;
-  else if (sp >= __pthread_manager_thread_bos
-          && sp < __pthread_manager_thread_tos)
+  if (sp >= __pthread_manager_thread_bos
+      && sp < __pthread_manager_thread_tos)
      return &__pthread_manager_thread;
-  else if (__pthread_nonstandard_stacks)
-    return __pthread_find_self();
-  else
-    return (pthread_descr)(((unsigned long)sp | (STACK_SIZE-1))+1) - 1;
+  else
+  {
+    if(__pthread_nonstandard_stacks)
+    {
+      pthread_descr pd;
+      if( (pd = __pthread_find_self()) != NULL )
+        return pd;
+    }
+    else
+    {
+      if( __pthread_other_threads_lowest_bos != NULL &&
+          sp < __pthread_initial_thread_bos &&
+          sp >= __pthread_other_threads_lowest_bos )
+      return (pthread_descr)(((unsigned long)sp | (STACK_SIZE-1))+1) - 1;
+    }
+  }
+  return &__pthread_initial_thread;
  #endif
  }

$ diff -u /glibc2.1.3-src/linuxthreads/pthread.c pthread.c
--- /glibc2.1.3-src/linuxthreads/pthread.c Thu Jan 20 17:40:19 2000
+++ pthread.c   Wed Apr 19 07:53:55 2000
@@ -136,6 +136,15 @@

  char *__pthread_initial_thread_bos = NULL;

+/* lowest bottom of stack of any other thread ever allocated
+   This is used for checking stack pointer between this value
+   and __pthread_initial_thread_bos to check other threads
+   before checking initial threads stack. This enables switching
+   the stack of the initial thread (in user level multithreading)
+   and make thread_self() working correctly. see also internals.h */
+
+char *__pthread_other_threads_lowest_bos = NULL;
+
  /* File descriptor for sending requests to the thread manager. */
  /* Initially -1, meaning that the thread manager is not running. */

@@ -544,8 +553,12 @@
    /* __pthread_handles[0] is the initial thread, __pthread_handles[1] is
       the manager threads handled specially in thread_self(), so start at 2 */
    h = __pthread_handles + 2;
-  while (! (sp <= (char *) h->h_descr && sp >= h->h_bottom)) h++;
-  return h->h_descr;
+  while (! (sp <= (char *) h->h_descr && sp >= h->h_bottom &&
+            h < (__pthread_handles + PTHREAD_THREADS_MAX) )) h++;
+  if( h < (__pthread_handles + PTHREAD_THREADS_MAX) )
+    return h->h_descr;
+  else
+    return NULL;
  }

  #endif

$ diff -u /glibc2.1.3-src/linuxthreads/manager.c manager.c
--- /glibc2.1.3-src/linuxthreads/manager.c Thu Jan 20 17:40:19 2000
+++ manager.c   Wed Apr 19 07:44:17 2000
@@ -301,6 +301,11 @@
                 -1, 0) == MAP_FAILED)
          /* Bad luck, this segment is already mapped. */
          return -1;
+
+      if( __pthread_other_threads_lowest_bos == NULL ||
+          __pthread_other_threads_lowest_bos > new_thread_bottom )
+      __pthread_other_threads_lowest_bos = new_thread_bottom;
+
        /* We manage to get a stack.  Now see whether we need a guard
           and allocate it if necessary.  Notice that the default
           attributes (stack_size = STACK_SIZE - pagesize) do not need


     You can also obtain these modified linuxthreads source files
     under http://www.informix.com/idn-secure/Linux/randinfo.html

*** MSW ***	

