Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWHPMKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWHPMKO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 08:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWHPMKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 08:10:14 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:45074 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751137AbWHPMKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 08:10:11 -0400
Date: Wed, 16 Aug 2006 14:10:08 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] s390: #undef in unistd.h
Message-ID: <20060816121008.GH24551@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] #undef in unistd.h

Avoid using #undef in unistd.h.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

diff -urpN linux-2.6/include/asm-s390/unistd.h linux-2.6-patched/include/asm-s390/unistd.h
--- linux-2.6/include/asm-s390/unistd.h	2006-08-16 13:36:16.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/unistd.h	2006-08-16 13:52:32.000000000 +0200
@@ -25,17 +25,12 @@
 #define __NR_unlink              10
 #define __NR_execve              11
 #define __NR_chdir               12
-#define __NR_time                13
 #define __NR_mknod               14
 #define __NR_chmod               15
-#define __NR_lchown              16
 #define __NR_lseek               19
 #define __NR_getpid              20
 #define __NR_mount               21
 #define __NR_umount              22
-#define __NR_setuid              23
-#define __NR_getuid              24
-#define __NR_stime               25
 #define __NR_ptrace              26
 #define __NR_alarm               27
 #define __NR_pause               29
@@ -51,11 +46,7 @@
 #define __NR_pipe                42
 #define __NR_times               43
 #define __NR_brk                 45
-#define __NR_setgid              46
-#define __NR_getgid              47
 #define __NR_signal              48
-#define __NR_geteuid             49
-#define __NR_getegid             50
 #define __NR_acct                51
 #define __NR_umount2             52
 #define __NR_ioctl               54
@@ -69,18 +60,13 @@
 #define __NR_getpgrp             65
 #define __NR_setsid              66
 #define __NR_sigaction           67
-#define __NR_setreuid            70
-#define __NR_setregid            71
 #define __NR_sigsuspend          72
 #define __NR_sigpending          73
 #define __NR_sethostname         74
 #define __NR_setrlimit           75
-#define __NR_getrlimit           76
 #define __NR_getrusage           77
 #define __NR_gettimeofday        78
 #define __NR_settimeofday        79
-#define __NR_getgroups           80
-#define __NR_setgroups           81
 #define __NR_symlink             83
 #define __NR_readlink            85
 #define __NR_uselib              86
@@ -92,12 +78,10 @@
 #define __NR_truncate            92
 #define __NR_ftruncate           93
 #define __NR_fchmod              94
-#define __NR_fchown              95
 #define __NR_getpriority         96
 #define __NR_setpriority         97
 #define __NR_statfs              99
 #define __NR_fstatfs            100
-#define __NR_ioperm             101
 #define __NR_socketcall         102
 #define __NR_syslog             103
 #define __NR_setitimer          104
@@ -131,11 +115,7 @@
 #define __NR_sysfs              135
 #define __NR_personality        136
 #define __NR_afs_syscall        137 /* Syscall for Andrew File System */
-#define __NR_setfsuid           138
-#define __NR_setfsgid           139
-#define __NR__llseek            140
 #define __NR_getdents           141
-#define __NR__newselect         142
 #define __NR_flock              143
 #define __NR_msync              144
 #define __NR_readv              145
@@ -157,13 +137,9 @@
 #define __NR_sched_rr_get_interval      161
 #define __NR_nanosleep          162
 #define __NR_mremap             163
-#define __NR_setresuid          164
-#define __NR_getresuid          165
 #define __NR_query_module       167
 #define __NR_poll               168
 #define __NR_nfsservctl         169
-#define __NR_setresgid          170
-#define __NR_getresgid          171
 #define __NR_prctl              172
 #define __NR_rt_sigreturn       173
 #define __NR_rt_sigaction       174
@@ -174,7 +150,6 @@
 #define __NR_rt_sigsuspend      179
 #define __NR_pread64            180
 #define __NR_pwrite64           181
-#define __NR_chown              182
 #define __NR_getcwd             183
 #define __NR_capget             184
 #define __NR_capset             185
@@ -183,39 +158,11 @@
 #define __NR_getpmsg		188
 #define __NR_putpmsg		189
 #define __NR_vfork		190
-#define __NR_ugetrlimit		191	/* SuS compliant getrlimit */
-#define __NR_mmap2		192
-#define __NR_truncate64		193
-#define __NR_ftruncate64	194
-#define __NR_stat64		195
-#define __NR_lstat64		196
-#define __NR_fstat64		197
-#define __NR_lchown32		198
-#define __NR_getuid32		199
-#define __NR_getgid32		200
-#define __NR_geteuid32		201
-#define __NR_getegid32		202
-#define __NR_setreuid32		203
-#define __NR_setregid32		204
-#define __NR_getgroups32	205
-#define __NR_setgroups32	206
-#define __NR_fchown32		207
-#define __NR_setresuid32	208
-#define __NR_getresuid32	209
-#define __NR_setresgid32	210
-#define __NR_getresgid32	211
-#define __NR_chown32		212
-#define __NR_setuid32		213
-#define __NR_setgid32		214
-#define __NR_setfsuid32		215
-#define __NR_setfsgid32		216
 #define __NR_pivot_root         217
 #define __NR_mincore            218
 #define __NR_madvise            219
 #define __NR_getdents64		220
-#define __NR_fcntl64		221
 #define __NR_readahead		222
-#define __NR_sendfile64		223
 #define __NR_setxattr		224
 #define __NR_lsetxattr		225
 #define __NR_fsetxattr		226
@@ -256,7 +203,6 @@
 #define __NR_clock_getres	(__NR_timer_create+7)
 #define __NR_clock_nanosleep	(__NR_timer_create+8)
 /* Number 263 is reserved for vserver */
-#define __NR_fadvise64_64	264
 #define __NR_statfs64		265
 #define __NR_fstatfs64		266
 #define __NR_remap_file_pages	267
@@ -285,7 +231,6 @@
 #define __NR_mknodat		290
 #define __NR_fchownat		291
 #define __NR_futimesat		292
-#define __NR_fstatat64		293
 #define __NR_unlinkat		294
 #define __NR_renameat		295
 #define __NR_linkat		296
@@ -310,62 +255,65 @@
  * have a different name although they do the same (e.g. __NR_chown32
  * is __NR_chown on 64 bit).
  */
-#ifdef __s390x__
-#undef  __NR_time
-#undef  __NR_lchown
-#undef  __NR_setuid
-#undef  __NR_getuid
-#undef  __NR_stime
-#undef  __NR_setgid
-#undef  __NR_getgid
-#undef  __NR_geteuid
-#undef  __NR_getegid
-#undef  __NR_setreuid
-#undef  __NR_setregid
-#undef  __NR_getrlimit
-#undef  __NR_getgroups
-#undef  __NR_setgroups
-#undef  __NR_fchown
-#undef  __NR_ioperm
-#undef  __NR_setfsuid
-#undef  __NR_setfsgid
-#undef  __NR__llseek
-#undef  __NR__newselect
-#undef  __NR_setresuid
-#undef  __NR_getresuid
-#undef  __NR_setresgid
-#undef  __NR_getresgid
-#undef  __NR_chown
-#undef  __NR_ugetrlimit
-#undef  __NR_mmap2
-#undef  __NR_truncate64
-#undef  __NR_ftruncate64
-#undef  __NR_stat64
-#undef  __NR_lstat64
-#undef  __NR_fstat64
-#undef  __NR_lchown32
-#undef  __NR_getuid32
-#undef  __NR_getgid32
-#undef  __NR_geteuid32
-#undef  __NR_getegid32
-#undef  __NR_setreuid32
-#undef  __NR_setregid32
-#undef  __NR_getgroups32
-#undef  __NR_setgroups32
-#undef  __NR_fchown32
-#undef  __NR_setresuid32
-#undef  __NR_getresuid32
-#undef  __NR_setresgid32
-#undef  __NR_getresgid32
-#undef  __NR_chown32
-#undef  __NR_setuid32
-#undef  __NR_setgid32
-#undef  __NR_setfsuid32
-#undef  __NR_setfsgid32
-#undef  __NR_fcntl64
-#undef  __NR_sendfile64
-#undef  __NR_fadvise64_64
-#undef  __NR_fstatat64
+#ifndef __s390x__
+
+#define __NR_time                13
+#define __NR_lchown              16
+#define __NR_setuid              23
+#define __NR_getuid              24
+#define __NR_stime               25
+#define __NR_setgid              46
+#define __NR_getgid              47
+#define __NR_geteuid             49
+#define __NR_getegid             50
+#define __NR_setreuid            70
+#define __NR_setregid            71
+#define __NR_getrlimit           76
+#define __NR_getgroups           80
+#define __NR_setgroups           81
+#define __NR_fchown              95
+#define __NR_ioperm             101
+#define __NR_setfsuid           138
+#define __NR_setfsgid           139
+#define __NR__llseek            140
+#define __NR__newselect         142
+#define __NR_setresuid          164
+#define __NR_getresuid          165
+#define __NR_setresgid          170
+#define __NR_getresgid          171
+#define __NR_chown              182
+#define __NR_ugetrlimit		191	/* SuS compliant getrlimit */
+#define __NR_mmap2		192
+#define __NR_truncate64		193
+#define __NR_ftruncate64	194
+#define __NR_stat64		195
+#define __NR_lstat64		196
+#define __NR_fstat64		197
+#define __NR_lchown32		198
+#define __NR_getuid32		199
+#define __NR_getgid32		200
+#define __NR_geteuid32		201
+#define __NR_getegid32		202
+#define __NR_setreuid32		203
+#define __NR_setregid32		204
+#define __NR_getgroups32	205
+#define __NR_setgroups32	206
+#define __NR_fchown32		207
+#define __NR_setresuid32	208
+#define __NR_getresuid32	209
+#define __NR_setresgid32	210
+#define __NR_getresgid32	211
+#define __NR_chown32		212
+#define __NR_setuid32		213
+#define __NR_setgid32		214
+#define __NR_setfsuid32		215
+#define __NR_setfsgid32		216
+#define __NR_fcntl64		221
+#define __NR_sendfile64		223
+#define __NR_fadvise64_64	264
+#define __NR_fstatat64		293
+
+#else
 
 #define __NR_select		142
 #define __NR_getrlimit		191	/* SuS compliant getrlimit */
