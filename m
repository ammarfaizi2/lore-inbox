Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWITUyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWITUyW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWITUyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:54:21 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:8948 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750733AbWITUyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:54:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GII1n2fHDvNUwAgF36Yo32HdxcyoLgrWcAGbG8Ys07SmFBMFPS+wWenNSnQ5i5G1gxWxD1TvamOAafZDdb6lLgWxI8IMa5/OJ06czj8YNKqomd2zuRl+R1M9YEBnQu103a20ohrUB0Mp/6v7n6Pq1bywRTxwXGc/kgtrY0wJ7Tg=
Message-ID: <6bffcb0e0609201354u7251d89en2c224b841b211d8f@mail.gmail.com>
Date: Wed, 20 Sep 2006 22:54:18 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.18-rt1
Cc: linux-kernel@vger.kernel.org, "Thomas Gleixner" <tglx@linutronix.de>,
       "John Stultz" <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Dipankar Sarma" <dipankar@in.ibm.com>,
       "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <20060920141907.GA30765@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060920141907.GA30765@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/09/06, Ingo Molnar <mingo@elte.hu> wrote:
> I'm pleased to announce the 2.6.18-rt1 tree, which can be downloaded
> from the usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/
>

2.6.18-rt3

Ingo, can you take a look at this bugs?

BUG: scheduling with irqs disabled: softirq-timer/1/0x00000001/17
caller is rt_spin_lock_slowlock+0x121/0x1af
 [<c0104356>] show_trace_log_lvl+0x68/0x193
 [<c0104a5a>] show_trace+0x1b/0x20
 [<c0104b38>] dump_stack+0x1f/0x24
 [<c02edb34>] schedule+0x69/0xe3
 [<c02ee8c0>] rt_spin_lock_slowlock+0x121/0x1af
 [<c02eef4f>] rt_spin_lock+0x10/0x2c
 [<c0171d6d>] __kmalloc+0xad/0x115
 [<c020c146>] soft_cursor+0x52/0x16c
 [<c020c00b>] bit_cursor+0x483/0x498
 [<c02071ab>] fbcon_cursor+0x218/0x24d
 [<c0244ac1>] hide_cursor+0x22/0x61
 [<c024811f>] vt_console_print+0x91/0x207
 [<c0120d31>] __call_console_drivers+0x6f/0x8c
 [<c0120dac>] _call_console_drivers+0x5e/0x67
 [<c0121367>] release_console_sem+0x132/0x1f2
 [<c0121051>] vprintk+0x28d/0x2f5
 [<c01210d3>] printk+0x1a/0x1c
 [<c0129ab3>] run_timer_softirq+0x77b/0xbb6
 [<c012632c>] ksoftirqd+0x11d/0x200
 [<c013386b>] kthread+0xc7/0xf8
 [<c0101005>] kernel_thread_helper+0x5/0xb
DWARF2 unwinder stuck at kernel_thread_helper+0x5/0xb
Leftover inexact backtrace:
 [<c0104a5a>] show_trace+0x1b/0x20
 [<c0104b38>] dump_stack+0x1f/0x24
 [<c02edb34>] schedule+0x69/0xe3
 [<c02ee8c0>] rt_spin_lock_slowlock+0x121/0x1af
 [<c02eef4f>] rt_spin_lock+0x10/0x2c
 [<c0171d6d>] __kmalloc+0xad/0x115
 [<c020c146>] soft_cursor+0x52/0x16c
 [<c020c00b>] bit_cursor+0x483/0x498
 [<c02071ab>] fbcon_cursor+0x218/0x24d
 [<c0244ac1>] hide_cursor+0x22/0x61
 [<c024811f>] vt_console_print+0x91/0x207
 [<c0120d31>] __call_console_drivers+0x6f/0x8c
 [<c0120dac>] _call_console_drivers+0x5e/0x67
 [<c0121367>] release_console_sem+0x132/0x1f2
 [<c0121051>] vprintk+0x28d/0x2f5
 [<c01210d3>] printk+0x1a/0x1c
 [<c0129ab3>] run_timer_softirq+0x77b/0xbb6
 [<c012632c>] ksoftirqd+0x11d/0x200
 [<c013386b>] kthread+0xc7/0xf8
 [<c0101005>] kernel_thread_helper+0x5/0xb
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c02ef447>] .... __spin_lock+0x12/0x35
.....[<c0129387>] ..   ( <= run_timer_softirq+0x4f/0xbb6)

skipping trace printing on CPU#1 != -1
BUG: scheduling while atomic: softirq-timer/1/0x00000001/17, CPU#1
 [<c0104356>] show_trace_log_lvl+0x68/0x193
 [<c0104a5a>] show_trace+0x1b/0x20
 [<c0104b38>] dump_stack+0x1f/0x24
 [<c02ecc43>] __schedule+0x7d/0xded
 [<c02edb8d>] schedule+0xc2/0xe3
 [<c02ee8c0>] rt_spin_lock_slowlock+0x121/0x1af
 [<c02eef4f>] rt_spin_lock+0x10/0x2c
 [<c0171d6d>] __kmalloc+0xad/0x115
 [<c020c146>] soft_cursor+0x52/0x16c
 [<c020c00b>] bit_cursor+0x483/0x498
 [<c02071ab>] fbcon_cursor+0x218/0x24d
 [<c0244ac1>] hide_cursor+0x22/0x61
 [<c024811f>] vt_console_print+0x91/0x207
 [<c0120d31>] __call_console_drivers+0x6f/0x8c
 [<c0120dac>] _call_console_drivers+0x5e/0x67
 [<c0121367>] release_console_sem+0x132/0x1f2
 [<c0121051>] vprintk+0x28d/0x2f5
 [<c01210d3>] printk+0x1a/0x1c
 [<c0129ab3>] run_timer_softirq+0x77b/0xbb6
 [<c012632c>] ksoftirqd+0x11d/0x200
 [<c013386b>] kthread+0xc7/0xf8
 [<c0101005>] kernel_thread_helper+0x5/0xb
DWARF2 unwinder stuck at kernel_thread_helper+0x5/0xb
Leftover inexact backtrace:
 [<c0104a5a>] show_trace+0x1b/0x20
 [<c0104b38>] dump_stack+0x1f/0x24
 [<c02ecc43>] __schedule+0x7d/0xded
 [<c02edb8d>] schedule+0xc2/0xe3
 [<c02ee8c0>] rt_spin_lock_slowlock+0x121/0x1af
 [<c02eef4f>] rt_spin_lock+0x10/0x2c
 [<c0171d6d>] __kmalloc+0xad/0x115
 [<c020c146>] soft_cursor+0x52/0x16c
 [<c020c00b>] bit_cursor+0x483/0x498
 [<c02071ab>] fbcon_cursor+0x218/0x24d
 [<c0244ac1>] hide_cursor+0x22/0x61
 [<c024811f>] vt_console_print+0x91/0x207
 [<c0120d31>] __call_console_drivers+0x6f/0x8c
 [<c0120dac>] _call_console_drivers+0x5e/0x67
 [<c0121367>] release_console_sem+0x132/0x1f2
 [<c0121051>] vprintk+0x28d/0x2f5
 [<c01210d3>] printk+0x1a/0x1c
 [<c0129ab3>] run_timer_softirq+0x77b/0xbb6
 [<c012632c>] ksoftirqd+0x11d/0x200
 [<c013386b>] kthread+0xc7/0xf8
 [<c0101005>] kernel_thread_helper+0x5/0xb
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c02ef447>] .... __spin_lock+0x12/0x35
.....[<c0129387>] ..   ( <= run_timer_softirq+0x4f/0xbb6)

(gdb) l *rt_spin_lock_slowlock+0x121/0x1af
0xc02ee79f is in rt_spin_lock_slowlock (/usr/src/linux-rt/kernel/rtmutex.c:660).
655      * enables the seemless use of arbitrary (blocking) spinlocks within
656      * sleep/wakeup event loops.
657      */
658     static void fastcall noinline __sched
659     rt_spin_lock_slowlock(struct rt_mutex *lock)
660     {
661             struct rt_mutex_waiter waiter;
662             unsigned long saved_state, state;
663
664             debug_rt_mutex_init_waiter(&waiter);

 l *__spin_lock+0x12/0x35
0xc02ef435 is in __spin_lock (/usr/src/linux-rt/kernel/spinlock.c:222).
217             _raw_write_lock(lock);
218     }
219     EXPORT_SYMBOL(__write_lock_bh);
220
221     void __lockfunc __spin_lock(raw_spinlock_t *lock)
222     {
223             preempt_disable();
224             spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
225             _raw_spin_lock(lock);
226     }

l *0xc0129387
0xc0129387 is in run_timer_softirq
(/usr/src/linux-rt/include/linux/seqlock.h:148).
143     }
144
145     static __always_inline void __write_seqlock_raw(raw_seqlock_t *sl)
146     {
147             spin_lock(&sl->lock);
148             ++sl->sequence;
149             smp_wmb();
150     }
151
152     static __always_inline void __write_sequnlock_raw(raw_seqlock_t *sl)

SELinux stuff.

=============================================
[ INFO: possible recursive locking detected ]
---------------------------------------------
init/1 is trying to acquire lock:
 (policy_rwlock){--..}, at: [<c01df7ab>] security_genfs_sid+0x1f/0xeb

but task is already holding lock:
 (policy_rwlock){--..}, at: [<c01df88c>] security_fs_use+0x15/0xbb

other info that might help us debug this:
3 locks held by init/1:
 #0:  (sel_mutex){--..}, at: [<c01da736>] sel_write_load+0x1b/0x2c0
 #1:  (&type->s_umount_key#14){--..}, at: [<c01d6de7>]
selinux_complete_init+0x67/0xbe
 #2:  (policy_rwlock){--..}, at: [<c01df88c>] security_fs_use+0x15/0xbb

stack backtrace:
 [<c0104356>] show_trace_log_lvl+0x68/0x193
 [<c0104a5a>] show_trace+0x1b/0x20
 [<c0104b38>] dump_stack+0x1f/0x24
 [<c013b795>] __lock_acquire+0x788/0x9be
 [<c013bca4>] lock_acquire+0x55/0x72
 [<c02ef13d>] rt_read_lock+0x1f/0x5f
 [<c01df7ab>] security_genfs_sid+0x1f/0xeb
 [<c01df913>] security_fs_use+0x9c/0xbb
 [<c01d667e>] superblock_doinit+0xb5/0x6b5
 [<c01d6df5>] selinux_complete_init+0x75/0xbe
 [<c01e0ec5>] security_load_policy+0xc9/0x275
 [<c01da7c1>] sel_write_load+0xa6/0x2c0
 [<c0176411>] vfs_write+0xaf/0x153
 [<c0176a71>] sys_write+0x3f/0x66
 [<c0103216>] sysenter_past_esp+0x63/0xa1
DWARF2 unwinder stuck at sysenter_past_esp+0x63/0xa1
Leftover inexact backtrace:
 [<c0104a5a>] show_trace+0x1b/0x20
 [<c0104b38>] dump_stack+0x1f/0x24
 [<c013b795>] __lock_acquire+0x788/0x9be
 [<c013bca4>] lock_acquire+0x55/0x72
 [<c02ef13d>] rt_read_lock+0x1f/0x5f
 [<c01df7ab>] security_genfs_sid+0x1f/0xeb
 [<c01df913>] security_fs_use+0x9c/0xbb
 [<c01d667e>] superblock_doinit+0xb5/0x6b5
 [<c01d6df5>] selinux_complete_init+0x75/0xbe
 [<c01e0ec5>] security_load_policy+0xc9/0x275
 [<c01da7c1>] sel_write_load+0xa6/0x2c0
 [<c0176411>] vfs_write+0xaf/0x153
 [<c0176a71>] sys_write+0x3f/0x66
 [<c0103216>] sysenter_past_esp+0x63/0xa1
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

skipping trace printing on CPU#1 != -1

l *security_genfs_sid+0x1f/0xeb
0xc01df78c is in security_genfs_sid
(/usr/src/linux-rt/security/selinux/ss/services.c:1612).
1607     */
1608    int security_genfs_sid(const char *fstype,
1609                           char *path,
1610                           u16 sclass,
1611                           u32 *sid)
1612    {
1613            int len;
1614            struct genfs *genfs;
1615            struct ocontext *c;
1616            int rc = 0, cmp = 0;

l *security_fs_use+0x15/0xbb
0xc01df877 is in security_fs_use
(/usr/src/linux-rt/security/selinux/ss/services.c:1669).
1664     */
1665    int security_fs_use(
1666            const char *fstype,
1667            unsigned int *behavior,
1668            u32 *sid)
1669    {
1670            int rc = 0;
1671            struct ocontext *c;
1672
1673            POLICY_RDLOCK;

config & dmesg http://www.stardust.webpages.pl/files/o_bugs/rt/2.6.18-rt1/

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
