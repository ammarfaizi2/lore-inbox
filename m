Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268100AbUHaMk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268100AbUHaMk3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 08:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268144AbUHaMk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 08:40:29 -0400
Received: from web50608.mail.yahoo.com ([206.190.38.95]:5978 "HELO
	web50608.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268100AbUHaMjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 08:39:44 -0400
Message-ID: <20040831123944.38866.qmail@web50608.mail.yahoo.com>
Date: Tue, 31 Aug 2004 05:39:44 -0700 (PDT)
From: Jeba Anandhan A <jeba_career@yahoo.com>
Subject: Kernel Module Compilation Error
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,
i am working in Fedora .
Kernel =2.4.22-1.2115.nptl #1 Wed Oct 29 15:42:51 EST
2003 i686 i686 i386 GNU/Linux

my kernel module program is
#include<linux/kernel.h>
#include<linux/module.h>
#include<linux/mm.h>
                                                      
                        extern *current;
int init_module(void){
return 0;
}
void cleanup_module(void){
}
                                                      
                        
~
when i give 
# gcc -c -DMODULE -D__KERNEL__ currenttask.c
the following error is shown.
what should i do?.
how to compile the kernel module with some kernel
header files ?.

In file included from /usr/include/linux/module.h:25,
                 from currenttask.c:2:
/usr/include/asm/atomic.h:40:2: warning: #warning
Using kernel header in userland program. BAD!
In file included from /usr/include/linux/fs.h:26,
                 from
/usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:4,
                 from /usr/include/linux/sched.h:10,
                 from /usr/include/linux/mm.h:4,
                 from currenttask.c:3:
/usr/include/asm/bitops.h:327:2: warning: #warning
This includefile is not available on all
architectures.
/usr/include/asm/bitops.h:328:2: warning: #warning
Using kernel headers in userspace: atomicity not
guaranteed
In file included from /usr/include/linux/rwsem.h:21,
                 from
/usr/include/linux/ext3_fs_i.h:19,
                 from /usr/include/linux/fs.h:304,
                 from
/usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:4,
                 from /usr/include/linux/sched.h:10,
                 from /usr/include/linux/mm.h:4,
                 from currenttask.c:3:
/usr/include/asm/system.h: In function `__cmpxchg':
/usr/include/asm/system.h:126: error: `LOCK_PREFIX'
undeclared (first use in this function)
/usr/include/asm/system.h:126: error: (Each undeclared
identifier is reported only once
/usr/include/asm/system.h:126: error: for each
function it appears in.)
/usr/include/asm/system.h:126: error: syntax error
before string constant
/usr/include/asm/system.h:132: error: syntax error
before string constant
/usr/include/asm/system.h:138: error: syntax error
before string constant
In file included from /usr/include/linux/fs.h:304,
                 from
/usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:4,
                 from /usr/include/linux/sched.h:10,
                 from /usr/include/linux/mm.h:4,
                 from currenttask.c:3:
/usr/include/linux/ext3_fs_i.h: At top level:
/usr/include/linux/ext3_fs_i.h:75: error: field
`truncate_sem' has incomplete type
In file included from /usr/include/linux/fs.h:305,
                 from
/usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:4,
                 from /usr/include/linux/sched.h:10,
                 from /usr/include/linux/mm.h:4,
                 from currenttask.c:3:
/usr/include/linux/hpfs_fs_i.h:19: error: field
`i_sem' has incomplete type
In file included from
/usr/include/linux/affs_fs_i.h:7,
                 from /usr/include/linux/fs.h:312,
                 from
/usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:4,
                 from /usr/include/linux/sched.h:10,
                 from /usr/include/linux/mm.h:4,
                 from currenttask.c:3:
/usr/include/linux/time.h: In function
`timespec_to_jiffies':
/usr/include/linux/time.h:37: error: `_SC_CLK_TCK'
undeclared (first use in this function)
/usr/include/linux/time.h: In function
`jiffies_to_timespec':
/usr/include/linux/time.h:47: error: `_SC_CLK_TCK'
undeclared (first use in this function)
In file included from /usr/include/linux/fs.h:312,
                 from
/usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:4,
                 from /usr/include/linux/sched.h:10,
                 from /usr/include/linux/mm.h:4,
                 from currenttask.c:3:
/usr/include/linux/affs_fs_i.h: At top level:
/usr/include/linux/affs_fs_i.h:27: error: field
`i_link_lock' has incomplete type
/usr/include/linux/affs_fs_i.h:28: error: field
`i_ext_lock' has incomplete type
In file included from /usr/include/linux/fs.h:325,
                 from
/usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:4,
                 from /usr/include/linux/sched.h:10,
                 from /usr/include/linux/mm.h:4,
                 from currenttask.c:3:
/usr/include/linux/ncp_fs_i.h:22: error: field
`open_sem' has incomplete type
In file included from /usr/include/linux/fs.h:328,
                 from
/usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:4,
                 from /usr/include/linux/sched.h:10,
                 from /usr/include/linux/mm.h:4,
                 from currenttask.c:3:
/usr/include/linux/jffs2_fs_i.h:26: error: field `sem'
has incomplete type
In file included from /usr/include/linux/fs.h:380,
                 from
/usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:4,
                 from /usr/include/linux/sched.h:10,
                 from /usr/include/linux/mm.h:4,
                 from currenttask.c:3:
/usr/include/linux/quota.h:284: error: field
`dqio_sem' has incomplete type
/usr/include/linux/quota.h:285: error: field
`dqoff_sem' has incomplete type
In file included from
/usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:4,
                 from /usr/include/linux/sched.h:10,
                 from /usr/include/linux/mm.h:4,
                 from currenttask.c:3:
/usr/include/linux/fs.h:429: error: field `sem' has
incomplete type
/usr/include/linux/fs.h:439: error: field `bd_sem' has
incomplete type
/usr/include/linux/fs.h:468: error: field `i_sem' has
incomplete type
/usr/include/linux/fs.h:469: error: field
`i_alloc_sem' has incomplete type
/usr/include/linux/fs.h:470: error: field `i_zombie'
has incomplete type
In file included from /usr/include/linux/fs.h:720,
                 from
/usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:4,
                 from /usr/include/linux/sched.h:10,
                 from /usr/include/linux/mm.h:4,
                 from currenttask.c:3:
/usr/include/linux/msdos_fs_sb.h:44: error: field
`fat_lock' has incomplete type
In file included from /usr/include/linux/fs.h:724,
                 from
/usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:4,
                 from /usr/include/linux/sched.h:10,
                 from /usr/include/linux/mm.h:4,
                 from currenttask.c:3:
/usr/include/linux/affs_fs_sb.h:28: error: field
`s_bmlock' has incomplete typeIn file included from
/usr/include/linux/fs.h:728,
                 from
/usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:4,
                 from /usr/include/linux/sched.h:10,
                 from /usr/include/linux/mm.h:4,
                 from currenttask.c:3:
/usr/include/linux/smb_fs_sb.h:37: error: field `sem'
has incomplete type
In file included from /usr/include/linux/fs.h:735,
                 from
/usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:4,
                 from /usr/include/linux/sched.h:10,
                 from /usr/include/linux/mm.h:4,
                 from currenttask.c:3:
/usr/include/linux/ncp_fs_sb.h:46: error: field `sem'
has incomplete type
In file included from /usr/include/linux/fs.h:738,
                 from
/usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:4,
                 from /usr/include/linux/sched.h:10,
                 from /usr/include/linux/mm.h:4,
                 from currenttask.c:3:
/usr/include/linux/jffs2_fs_sb.h:30: error: field
`gc_thread_start' has incomplete type
/usr/include/linux/jffs2_fs_sb.h:35: error: field
`alloc_sem' has incomplete type
In file included from
/usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:4,
                 from /usr/include/linux/sched.h:10,
                 from /usr/include/linux/mm.h:4,
                 from currenttask.c:3:
/usr/include/linux/fs.h:759: error: field `s_umount'
has incomplete type
/usr/include/linux/fs.h:760: error: field `s_lock' has
incomplete type
/usr/include/linux/fs.h:804: error: field
`s_vfs_rename_sem' has incomplete type
/usr/include/linux/fs.h:813: error: field
`s_nfsd_free_path_sem' has incomplete type
In file included from /usr/include/linux/sched.h:15,
                 from /usr/include/linux/mm.h:4,
                 from currenttask.c:3:
/usr/include/linux/timex.h:63:5: missing binary
operator before token "("
/usr/include/linux/timex.h:65:7: missing binary
operator before token "("
/usr/include/linux/timex.h:67:7: missing binary
operator before token "("
/usr/include/linux/timex.h:69:7: missing binary
operator before token "("
/usr/include/linux/timex.h:71:7: missing binary
operator before token "("
/usr/include/linux/timex.h:73:7: missing binary
operator before token "("
/usr/include/linux/timex.h:75:7: missing binary
operator before token "("
/usr/include/linux/timex.h:78:3: #error You lose.
In file included from /usr/include/linux/sched.h:26,
                 from /usr/include/linux/mm.h:4,
                 from currenttask.c:3:
/usr/include/linux/tty.h:141: error: field `pty_sem'
has incomplete type
/usr/include/linux/tty.h:307: error: field
`atomic_read' has incomplete type
/usr/include/linux/tty.h:308: error: field
`atomic_write' has incomplete type
In file included from /usr/include/linux/signal.h:4,
                 from /usr/include/linux/sched.h:28,
                 from /usr/include/linux/mm.h:4,
                 from currenttask.c:3:
/usr/include/asm/signal.h:107: error: syntax error
before "sigset_t"
/usr/include/asm/signal.h:110: error: syntax error
before '}' token
In file included from /usr/include/linux/sched.h:28,
                 from /usr/include/linux/mm.h:4,
                 from currenttask.c:3:
/usr/include/linux/signal.h:19: error: syntax error
before "sigset_t"
/usr/include/linux/signal.h:31: error: syntax error
before '*' token
/usr/include/linux/signal.h: In function `sigaddset':
/usr/include/linux/signal.h:33: error: `_sig'
undeclared (first use in this function)
/usr/include/linux/signal.h:34: error: `_NSIG_WORDS'
undeclared (first use in this function)
/usr/include/linux/signal.h:35: error: `set'
undeclared (first use in this function)
/usr/include/linux/signal.h:37: error: `_NSIG_BPW'
undeclared (first use in this function)
/usr/include/linux/signal.h: At top level:
/usr/include/linux/signal.h:40: error: syntax error
before '*' token
/usr/include/linux/signal.h: In function `sigdelset':
/usr/include/linux/signal.h:42: error: `_sig'
undeclared (first use in this function)
/usr/include/linux/signal.h:43: error: `_NSIG_WORDS'
undeclared (first use in this function)
/usr/include/linux/signal.h:44: error: `set'
undeclared (first use in this function)
/usr/include/linux/signal.h:46: error: `_NSIG_BPW'
undeclared (first use in this function)
/usr/include/linux/signal.h: At top level:
/usr/include/linux/signal.h:49: error: syntax error
before '*' token
/usr/include/linux/signal.h: In function
`sigismember':
/usr/include/linux/signal.h:51: error: `_sig'
undeclared (first use in this function)
/usr/include/linux/signal.h:52: error: `_NSIG_WORDS'
undeclared (first use in this function)
/usr/include/linux/signal.h:53: error: `set'
undeclared (first use in this function)
/usr/include/linux/signal.h:55: error: `_NSIG_BPW'
undeclared (first use in this function)
/usr/include/linux/signal.h: At top level:
/usr/include/linux/signal.h:108: error: syntax error
before '*' token
/usr/include/linux/signal.h: In function `sigorsets':
/usr/include/linux/signal.h:108: error: `_NSIG_WORDS'
undeclared (first use in this function)
/usr/include/linux/signal.h:108: error: `a' undeclared
(first use in this function)
/usr/include/linux/signal.h:108: error: `b' undeclared
(first use in this function)
/usr/include/linux/signal.h:108: error: `r' undeclared
(first use in this function)
/usr/include/linux/signal.h: At top level:
/usr/include/linux/signal.h:111: error: syntax error
before '*' token
/usr/include/linux/signal.h: In function `sigandsets':
/usr/include/linux/signal.h:111: error: `_NSIG_WORDS'
undeclared (first use in this function)
/usr/include/linux/signal.h:111: error: `a' undeclared
(first use in this function)
/usr/include/linux/signal.h:111: error: `b' undeclared
(first use in this function)
/usr/include/linux/signal.h:111: error: `r' undeclared
(first use in this function)
/usr/include/linux/signal.h: At top level:
/usr/include/linux/signal.h:114: error: syntax error
before '*' token
/usr/include/linux/signal.h: In function
`signandsets':
/usr/include/linux/signal.h:114: error: `_NSIG_WORDS'
undeclared (first use in this function)
/usr/include/linux/signal.h:114: error: `a' undeclared
(first use in this function)
/usr/include/linux/signal.h:114: error: `b' undeclared
(first use in this function)
/usr/include/linux/signal.h:114: error: `r' undeclared
(first use in this function)
/usr/include/linux/signal.h: At top level:
/usr/include/linux/signal.h:140: error: syntax error
before '*' token
/usr/include/linux/signal.h: In function `signotset':
/usr/include/linux/signal.h:140: error: `_NSIG_WORDS'
undeclared (first use in this function)
/usr/include/linux/signal.h:140: error: `set'
undeclared (first use in this function)
/usr/include/linux/signal.h: At top level:
/usr/include/linux/signal.h:145: error: syntax error
before '*' token
/usr/include/linux/signal.h: In function
`sigemptyset':
/usr/include/linux/signal.h:147: error: `_NSIG_WORDS'
undeclared (first use in this function)
/usr/include/linux/signal.h:149: error: `set'
undeclared (first use in this function)
/usr/include/linux/signal.h:149: error: `sigset_t'
undeclared (first use in this function)
/usr/include/linux/signal.h: At top level:
/usr/include/linux/signal.h:157: error: syntax error
before '*' token
/usr/include/linux/signal.h: In function `sigfillset':
/usr/include/linux/signal.h:159: error: `_NSIG_WORDS'
undeclared (first use in this function)
/usr/include/linux/signal.h:161: error: `set'
undeclared (first use in this function)
/usr/include/linux/signal.h:161: error: `sigset_t'
undeclared (first use in this function)
/usr/include/linux/signal.h: At top level:
/usr/include/linux/signal.h:169: error: syntax error
before '*' token
/usr/include/linux/signal.h:173: error: syntax error
before '*' token
/usr/include/linux/signal.h: In function
`sigaddsetmask':
/usr/include/linux/signal.h:175: error: `set'
undeclared (first use in this function)
/usr/include/linux/signal.h:175: error: `mask'
undeclared (first use in this function)
/usr/include/linux/signal.h: At top level:
/usr/include/linux/signal.h:178: error: syntax error
before '*' token
/usr/include/linux/signal.h: In function
`sigdelsetmask':
/usr/include/linux/signal.h:180: error: `set'
undeclared (first use in this function)
/usr/include/linux/signal.h:180: error: `mask'
undeclared (first use in this function)
/usr/include/linux/signal.h: At top level:
/usr/include/linux/signal.h:183: error: syntax error
before '*' token
/usr/include/linux/signal.h: In function
`sigtestsetmask':
/usr/include/linux/signal.h:185: error: `set'
undeclared (first use in this function)
/usr/include/linux/signal.h:185: error: `mask'
undeclared (first use in this function)
/usr/include/linux/signal.h: At top level:
/usr/include/linux/signal.h:188: error: syntax error
before '*' token
/usr/include/linux/signal.h: In function `siginitset':
/usr/include/linux/signal.h:190: error: `set'
undeclared (first use in this function)
/usr/include/linux/signal.h:190: error: `mask'
undeclared (first use in this function)
/usr/include/linux/signal.h:191: error: `_NSIG_WORDS'
undeclared (first use in this function)
/usr/include/linux/signal.h: At top level:
/usr/include/linux/signal.h:200: error: syntax error
before '*' token
/usr/include/linux/signal.h: In function
`siginitsetinv':
/usr/include/linux/signal.h:202: error: `set'
undeclared (first use in this function)
/usr/include/linux/signal.h:202: error: `mask'
undeclared (first use in this function)
/usr/include/linux/signal.h:203: error: `_NSIG_WORDS'
undeclared (first use in this function)
/usr/include/linux/signal.h: In function
`init_sigpending':
/usr/include/linux/signal.h:216: error: dereferencing
pointer to incomplete type
/usr/include/linux/signal.h:217: error: dereferencing
pointer to incomplete type
/usr/include/linux/signal.h:218: error: dereferencing
pointer to incomplete type
/usr/include/linux/signal.h:218: error: dereferencing
pointer to incomplete type
In file included from /usr/include/linux/mm.h:4,
                 from currenttask.c:3:
/usr/include/linux/sched.h: At top level:
/usr/include/linux/sched.h:273: error: syntax error
before "pgd_t"
/usr/include/linux/sched.h:293: error: syntax error
before ':' token
/usr/include/linux/sched.h:301: error: syntax error
before '}' token
/usr/include/linux/sched.h:325: error: `_NSIG'
undeclared here (not in a function)
/usr/include/linux/sched.h:343: error: field
`shared_pending' has incomplete type
/usr/include/linux/sched.h:513: error: syntax error
before "sigset_t"
/usr/include/linux/sched.h:520: error: syntax error
before '*' token
/usr/include/linux/sched.h:535: error: syntax error
before '}' token
/usr/include/linux/sched.h:728: error: field `task'
has incomplete type
In file included from /usr/include/linux/mm.h:4,
                 from currenttask.c:3:
/usr/include/linux/sched.h:742:25: asm/current.h: No
such file or directory
/usr/include/linux/sched.h:782: error: syntax error
before '*' token
/usr/include/linux/sched.h:784: error: syntax error
before "sigset_t"
/usr/include/linux/sched.h: In function
`signal_pending':
/usr/include/linux/sched.h:806: error: dereferencing
pointer to incomplete type/usr/include/linux/sched.h:
In function `on_sig_stack':
/usr/include/linux/sched.h:813: error: `current'
undeclared (first use in this function)
/usr/include/linux/sched.h: In function
`sas_ss_flags':
/usr/include/linux/sched.h:818: error: `current'
undeclared (first use in this function)
/usr/include/linux/sched.h: In function `suser':
/usr/include/linux/sched.h:843: error: `current'
undeclared (first use in this function)
/usr/include/linux/sched.h: In function `fsuser':
/usr/include/linux/sched.h:852: error: `current'
undeclared (first use in this function)
/usr/include/linux/sched.h: In function `capable':
/usr/include/linux/sched.h:868: error: `current'
undeclared (first use in this function)
/usr/include/linux/sched.h: In function `mmdrop':
/usr/include/linux/sched.h:891: error: dereferencing
pointer to incomplete type/usr/include/linux/sched.h:
At top level:
/usr/include/linux/sched.h:948: error: conflicting
types for `kernel_thread'
/usr/include/asm/processor.h:435: error: previous
declaration of `kernel_thread'
/usr/include/linux/sched.h: In function
`thread_group_empty':
/usr/include/linux/sched.h:1076: error: dereferencing
pointer to incomplete type
/usr/include/linux/sched.h: In function `task_lock':
/usr/include/linux/sched.h:1089: error: dereferencing
pointer to incomplete type
/usr/include/linux/sched.h: In function `get_task_mm':
/usr/include/linux/sched.h:1108: error: dereferencing
pointer to incomplete type
/usr/include/linux/sched.h:1110: error: dereferencing
pointer to incomplete type
/usr/include/linux/sched.h: In function `d_path':
/usr/include/linux/sched.h:1123: error: `current'
undeclared (first use in this function)
/usr/include/linux/sched.h: In function
`set_need_resched':
/usr/include/linux/sched.h:1137: error: `current'
undeclared (first use in this function)
/usr/include/linux/sched.h: In function
`clear_need_resched':
/usr/include/linux/sched.h:1142: error: `current'
undeclared (first use in this function)
/usr/include/linux/sched.h: In function
`set_tsk_need_resched':
/usr/include/linux/sched.h:1147: error: dereferencing
pointer to incomplete type
/usr/include/linux/sched.h: In function
`clear_tsk_need_resched':
/usr/include/linux/sched.h:1152: error: dereferencing
pointer to incomplete type
/usr/include/linux/sched.h: In function
`need_resched':
/usr/include/linux/sched.h:1157: error: `current'
undeclared (first use in this function)
In file included from currenttask.c:3:
/usr/include/linux/mm.h:26:25: asm/pgtable.h: No such
file or directory
In file included from currenttask.c:3:
/usr/include/linux/mm.h: At top level:
/usr/include/linux/mm.h:53: error: syntax error before
"pgprot_t"
/usr/include/linux/mm.h:75: error: syntax error before
'}' token
/usr/include/linux/mm.h:129: error: syntax error
before "protection_map"
/usr/include/linux/mm.h:495: error: syntax error
before "pgprot_t"
/usr/include/linux/mm.h:496: error: syntax error
before "pgprot_t"
/usr/include/linux/mm.h:499: error: syntax error
before '*' token
/usr/include/linux/mm.h:499: error: syntax error
before "pgd_t"
/usr/include/linux/mm.h:500: error: syntax error
before '*' token
/usr/include/linux/mm.h:500: error: syntax error
before "pmd_t"
/usr/include/linux/mm.h:514: error: syntax error
before '*' token
/usr/include/linux/mm.h:514: error: syntax error
before "pgd_t"
/usr/include/linux/mm.h: In function `pmd_alloc':
/usr/include/linux/mm.h:516: error: `pgd' undeclared
(first use in this function)
/usr/include/linux/mm.h:517: error: `mm' undeclared
(first use in this function)
/usr/include/linux/mm.h:517: error: `address'
undeclared (first use in this function)
/usr/include/linux/mm.h: In function `__vma_unlink':
/usr/include/linux/mm.h:581: error: dereferencing
pointer to incomplete type
/usr/include/linux/mm.h:581: error: dereferencing
pointer to incomplete type
/usr/include/linux/mm.h:582: error: dereferencing
pointer to incomplete type
/usr/include/linux/mm.h:582: error: dereferencing
pointer to incomplete type
/usr/include/linux/mm.h:583: error: dereferencing
pointer to incomplete type
/usr/include/linux/mm.h:584: error: dereferencing
pointer to incomplete type
/usr/include/linux/mm.h:585: error: dereferencing
pointer to incomplete type
/usr/include/linux/mm.h: In function `can_vma_merge':
/usr/include/linux/mm.h:590: error: dereferencing
pointer to incomplete type
/usr/include/linux/mm.h:590: error: dereferencing
pointer to incomplete type
/usr/include/linux/mm.h: In function `pf_gfp_mask':
/usr/include/linux/mm.h:638: error: `current'
undeclared (first use in this function)
/usr/include/linux/mm.h: In function
`find_vma_intersection':
/usr/include/linux/mm.h:658: error: dereferencing
pointer to incomplete type
currenttask.c: At top level:
/usr/include/linux/sched.h:277: error: storage size of
`mmap_sem' isn't known
/usr/include/linux/sched.h:514: error: storage size of
`pending' isn't known


		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
