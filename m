Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbWAXBT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbWAXBT7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 20:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWAXBT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 20:19:58 -0500
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:59349 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030273AbWAXBTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 20:19:55 -0500
Date: Mon, 23 Jan 2006 20:16:38 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 9/9] ia32 syscalls: remove old x86_64 syscall table
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Jeff Dike <jdike@addtoit.com>
Message-ID: <200601232019_MC3-1-B683-9F5A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <200601231938_MC3-1-B687-7C42@compuserve.com>
In-Reply-To: <200601231938_MC3-1-B687-7C42@compuserve.com>

Shared ia32 syscall table 9/9:

Remove old x86_64 ia32 syscall table

Signed-Off-By: Chuck Ebbert <76306.1226@compuserve.com>

---

 arch/x86_64/ia32/ia32entry.S |  316 -------------------------------------------
 1 files changed, 316 deletions(-)

--- 2.6.16-rc1-mm2.orig/arch/x86_64/ia32/ia32entry.S
+++ 2.6.16-rc1-mm2/arch/x86_64/ia32/ia32entry.S
@@ -413,322 +413,6 @@ ia32_sys_call_table:
 
 #include "../../i386/kernel/syscall_tbl.S"
 
-#if 0
-	.quad sys_restart_syscall
-	.quad sys_exit
-	.quad stub32_fork
-	.quad sys_read
-	.quad sys_write
-	.quad compat_sys_open		/* 5 */
-	.quad sys_close
-	.quad sys32_waitpid
-	.quad sys_creat
-	.quad sys_link
-	.quad sys_unlink		/* 10 */
-	.quad stub32_execve
-	.quad sys_chdir
-	.quad compat_sys_time
-	.quad sys_mknod
-	.quad sys_chmod		/* 15 */
-	.quad sys_lchown16
-	.quad sys32_ni_syscall			/* old break syscall holder */
-	.quad sys_stat
-	.quad sys32_lseek
-	.quad sys_getpid		/* 20 */
-	.quad compat_sys_mount	/* mount  */
-	.quad sys_oldumount	/* old_umount  */
-	.quad sys_setuid16
-	.quad sys_getuid16
-	.quad compat_sys_stime	/* stime */		/* 25 */
-	.quad sys32_ptrace	/* ptrace */
-	.quad sys_alarm
-	.quad sys_fstat	/* (old)fstat */
-	.quad sys_pause
-	.quad compat_sys_utime	/* 30 */
-	.quad sys32_ni_syscall	/* old stty syscall holder */
-	.quad sys32_ni_syscall	/* old gtty syscall holder */
-	.quad sys_access
-	.quad sys_nice	
-	.quad sys32_ni_syscall	/* 35 */	/* old ftime syscall holder */
-	.quad sys_sync
-	.quad sys32_kill
-	.quad sys_rename
-	.quad sys_mkdir
-	.quad sys_rmdir		/* 40 */
-	.quad sys_dup
-	.quad sys32_pipe
-	.quad compat_sys_times
-	.quad sys32_ni_syscall			/* old prof syscall holder */
-	.quad sys_brk		/* 45 */
-	.quad sys_setgid16
-	.quad sys_getgid16
-	.quad sys_signal
-	.quad sys_geteuid16
-	.quad sys_getegid16	/* 50 */
-	.quad sys_acct
-	.quad sys_umount			/* new_umount */
-	.quad sys32_ni_syscall			/* old lock syscall holder */
-	.quad compat_sys_ioctl
-	.quad compat_sys_fcntl64		/* 55 */
-	.quad sys32_ni_syscall			/* old mpx syscall holder */
-	.quad sys_setpgid
-	.quad sys32_ni_syscall			/* old ulimit syscall holder */
-	.quad sys32_olduname
-	.quad sys_umask		/* 60 */
-	.quad sys_chroot
-	.quad sys32_ustat
-	.quad sys_dup2
-	.quad sys_getppid
-	.quad sys_getpgrp		/* 65 */
-	.quad sys_setsid
-	.quad sys32_sigaction
-	.quad sys_sgetmask
-	.quad sys_ssetmask
-	.quad sys_setreuid16	/* 70 */
-	.quad sys_setregid16
-	.quad stub32_sigsuspend
-	.quad compat_sys_sigpending
-	.quad sys_sethostname
-	.quad compat_sys_setrlimit	/* 75 */
-	.quad compat_sys_old_getrlimit	/* old_getrlimit */
-	.quad compat_sys_getrusage
-	.quad sys32_gettimeofday
-	.quad sys32_settimeofday
-	.quad sys_getgroups16	/* 80 */
-	.quad sys_setgroups16
-	.quad sys32_old_select
-	.quad sys_symlink
-	.quad sys_lstat
-	.quad sys_readlink		/* 85 */
-#ifdef CONFIG_IA32_AOUT
-	.quad sys_uselib
-#else
-	.quad sys32_ni_syscall
-#endif
-	.quad sys_swapon
-	.quad sys_reboot
-	.quad compat_sys_old_readdir
-	.quad sys32_old_mmap		/* 90 */
-	.quad sys_munmap
-	.quad sys_truncate
-	.quad sys_ftruncate
-	.quad sys_fchmod
-	.quad sys_fchown16		/* 95 */
-	.quad sys_getpriority
-	.quad sys_setpriority
-	.quad sys32_ni_syscall			/* old profil syscall holder */
-	.quad compat_sys_statfs
-	.quad compat_sys_fstatfs		/* 100 */
-	.quad sys_ioperm
-	.quad compat_sys_socketcall
-	.quad sys_syslog
-	.quad compat_sys_setitimer
-	.quad compat_sys_getitimer	/* 105 */
-	.quad compat_sys_newstat
-	.quad compat_sys_newlstat
-	.quad compat_sys_newfstat
-	.quad sys32_uname
-	.quad stub32_iopl		/* 110 */
-	.quad sys_vhangup
-	.quad sys32_ni_syscall	/* old "idle" system call */
-	.quad sys32_vm86_warning	/* vm86old */ 
-	.quad compat_sys_wait4
-	.quad sys_swapoff		/* 115 */
-	.quad sys32_sysinfo
-	.quad sys32_ipc
-	.quad sys_fsync
-	.quad stub32_sigreturn
-	.quad stub32_clone		/* 120 */
-	.quad sys_setdomainname
-	.quad sys_uname
-	.quad sys_modify_ldt
-	.quad sys32_adjtimex
-	.quad sys32_mprotect		/* 125 */
-	.quad compat_sys_sigprocmask
-	.quad sys32_ni_syscall		/* create_module */
-	.quad sys_init_module
-	.quad sys_delete_module
-	.quad sys32_ni_syscall		/* 130  get_kernel_syms */
-	.quad sys_quotactl
-	.quad sys_getpgid
-	.quad sys_fchdir
-	.quad sys32_ni_syscall	/* bdflush */
-	.quad sys_sysfs		/* 135 */
-	.quad sys_personality
-	.quad sys32_ni_syscall	/* for afs_syscall */
-	.quad sys_setfsuid16
-	.quad sys_setfsgid16
-	.quad sys_llseek		/* 140 */
-	.quad compat_sys_getdents
-	.quad compat_sys_select
-	.quad sys_flock
-	.quad sys_msync
-	.quad compat_sys_readv		/* 145 */
-	.quad compat_sys_writev
-	.quad sys_getsid
-	.quad sys_fdatasync
-	.quad sys32_sysctl	/* sysctl */
-	.quad sys_mlock		/* 150 */
-	.quad sys_munlock
-	.quad sys_mlockall
-	.quad sys_munlockall
-	.quad sys_sched_setparam
-	.quad sys_sched_getparam   /* 155 */
-	.quad sys_sched_setscheduler
-	.quad sys_sched_getscheduler
-	.quad sys_sched_yield
-	.quad sys_sched_get_priority_max
-	.quad sys_sched_get_priority_min  /* 160 */
-	.quad sys_sched_rr_get_interval
-	.quad compat_sys_nanosleep
-	.quad sys_mremap
-	.quad sys_setresuid16
-	.quad sys_getresuid16	/* 165 */
-	.quad sys32_vm86_warning	/* vm86 */ 
-	.quad sys32_ni_syscall	/* query_module */
-	.quad sys_poll
-	.quad compat_sys_nfsservctl
-	.quad sys_setresgid16	/* 170 */
-	.quad sys_getresgid16
-	.quad sys_prctl
-	.quad stub32_rt_sigreturn
-	.quad sys32_rt_sigaction
-	.quad sys32_rt_sigprocmask	/* 175 */
-	.quad sys32_rt_sigpending
-	.quad compat_sys_rt_sigtimedwait
-	.quad sys32_rt_sigqueueinfo
-	.quad stub32_rt_sigsuspend
-	.quad sys32_pread64		/* 180 */
-	.quad sys32_pwrite64
-	.quad sys_chown16
-	.quad sys_getcwd
-	.quad sys_capget
-	.quad sys_capset
-	.quad stub32_sigaltstack
-	.quad sys32_sendfile
-	.quad sys32_ni_syscall		/* streams1 */
-	.quad sys32_ni_syscall		/* streams2 */
-	.quad stub32_vfork            /* 190 */
-	.quad compat_sys_getrlimit
-	.quad sys32_mmap2
-	.quad sys32_truncate64
-	.quad sys32_ftruncate64
-	.quad sys32_stat64		/* 195 */
-	.quad sys32_lstat64
-	.quad sys32_fstat64
-	.quad sys_lchown
-	.quad sys_getuid
-	.quad sys_getgid		/* 200 */
-	.quad sys_geteuid
-	.quad sys_getegid
-	.quad sys_setreuid
-	.quad sys_setregid
-	.quad sys_getgroups	/* 205 */
-	.quad sys_setgroups
-	.quad sys_fchown
-	.quad sys_setresuid
-	.quad sys_getresuid
-	.quad sys_setresgid	/* 210 */
-	.quad sys_getresgid
-	.quad sys_chown
-	.quad sys_setuid
-	.quad sys_setgid
-	.quad sys_setfsuid		/* 215 */
-	.quad sys_setfsgid
-	.quad sys_pivot_root
-	.quad sys_mincore
-	.quad sys_madvise
-	.quad compat_sys_getdents64	/* 220 getdents64 */
-	.quad compat_sys_fcntl64	
-	.quad sys32_ni_syscall		/* tux */
-	.quad sys32_ni_syscall    	/* security */
-	.quad sys_gettid	
-	.quad sys_readahead	/* 225 */
-	.quad sys_setxattr
-	.quad sys_lsetxattr
-	.quad sys_fsetxattr
-	.quad sys_getxattr
-	.quad sys_lgetxattr	/* 230 */
-	.quad sys_fgetxattr
-	.quad sys_listxattr
-	.quad sys_llistxattr
-	.quad sys_flistxattr
-	.quad sys_removexattr	/* 235 */
-	.quad sys_lremovexattr
-	.quad sys_fremovexattr
-	.quad sys_tkill
-	.quad sys_sendfile64 
-	.quad compat_sys_futex		/* 240 */
-	.quad compat_sys_sched_setaffinity
-	.quad compat_sys_sched_getaffinity
-	.quad sys32_set_thread_area
-	.quad sys32_get_thread_area
-	.quad compat_sys_io_setup	/* 245 */
-	.quad sys_io_destroy
-	.quad compat_sys_io_getevents
-	.quad compat_sys_io_submit
-	.quad sys_io_cancel
-	.quad sys_fadvise64		/* 250 */
-	.quad sys32_ni_syscall 	/* free_huge_pages */
-	.quad sys_exit_group
-	.quad sys32_lookup_dcookie
-	.quad sys_epoll_create
-	.quad sys_epoll_ctl		/* 255 */
-	.quad sys_epoll_wait
-	.quad sys_remap_file_pages
-	.quad sys_set_tid_address
-	.quad compat_sys_timer_create
-	.quad compat_sys_timer_settime	/* 260 */
-	.quad compat_sys_timer_gettime
-	.quad sys_timer_getoverrun
-	.quad sys_timer_delete
-	.quad compat_sys_clock_settime
-	.quad compat_sys_clock_gettime	/* 265 */
-	.quad compat_sys_clock_getres
-	.quad compat_sys_clock_nanosleep
-	.quad compat_sys_statfs64
-	.quad compat_sys_fstatfs64
-	.quad sys_tgkill		/* 270 */
-	.quad compat_sys_utimes
-	.quad sys32_fadvise64_64
-	.quad sys32_ni_syscall	/* sys_vserver */
-	.quad sys_mbind
-	.quad compat_sys_get_mempolicy	/* 275 */
-	.quad sys_set_mempolicy
-	.quad compat_sys_mq_open
-	.quad sys_mq_unlink
-	.quad compat_sys_mq_timedsend
-	.quad compat_sys_mq_timedreceive	/* 280 */
-	.quad compat_sys_mq_notify
-	.quad compat_sys_mq_getsetattr
-	.quad compat_sys_kexec_load	/* reserved for kexec */
-	.quad compat_sys_waitid
-	.quad sys32_ni_syscall		/* 285: sys_altroot */
-	.quad sys_add_key
-	.quad sys_request_key
-	.quad sys_keyctl
-	.quad sys_ioprio_set
-	.quad sys_ioprio_get		/* 290 */
-	.quad sys_inotify_init
-	.quad sys_inotify_add_watch
-	.quad sys_inotify_rm_watch
-	.quad sys_migrate_pages
-	.quad compat_sys_openat		/* 295 */
-	.quad sys_mkdirat
-	.quad sys_mknodat
-	.quad sys_fchownat
-	.quad compat_sys_futimesat
-	.quad compat_sys_newfstatat	/* 300 */
-	.quad sys_unlinkat
-	.quad sys_renameat
-	.quad sys_linkat
-	.quad sys_symlinkat
-	.quad sys_readlinkat		/* 305 */
-	.quad sys_fchmodat
-	.quad sys_faccessat
-	.quad sys_unshare
-#endif
-
 /* RED-PEN: find a way to determine IA32_NR_syscalls automatically */
 
 ia32_syscall_end:		
-- 
Chuck
