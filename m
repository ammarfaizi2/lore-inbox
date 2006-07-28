Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932591AbWG1IRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbWG1IRq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 04:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWG1IRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 04:17:46 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:59671 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932591AbWG1IRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 04:17:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gI2z/TunebPT9BCZd2z27wdj2vO2WcOg8m6F5lXNEpgjYWjZWnG84L6RP6ir4l6p0scsemP2SK2mv49nvZCs/MWZlisTpI25OfUJJMMSTKF9o4xFp1M4GcbT5cnapWE5P6mS3i4AlNliBxosDzhRWB+VaXqp/A/v5yBC4piswi4=
Message-ID: <6bffcb0e0607280117k68184559t531b737815b2c6e9@mail.gmail.com>
Date: Fri, 28 Jul 2006 10:17:44 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-rc2-mm1
Cc: "Matt Helsley" <matthltc@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0607270632i2ae56e21k40fb12c712980de0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060727015639.9c89db57.akpm@osdl.org>
	 <6bffcb0e0607270632i2ae56e21k40fb12c712980de0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Hi Andrew,
>
> On 27/07/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/
> >
>
> It appears while /sbin/start_udev
>
> Jul 27 15:17:17 ltg01-fedora kernel: BUG: unable to handle kernel
> paging request at virtual address 6b6b6c07
> Jul 27 15:17:17 ltg01-fedora kernel:  printing eip:
> Jul 27 15:17:17 ltg01-fedora kernel: c0138722
> Jul 27 15:17:17 ltg01-fedora kernel: *pde = 00000000
> Jul 27 15:17:17 ltg01-fedora kernel: Oops: 0002 [#1]
> Jul 27 15:17:17 ltg01-fedora kernel: 4K_STACKS PREEMPT SMP
> Jul 27 15:17:17 ltg01-fedora kernel: last sysfs file:
> /devices/pci0000:00/0000:00:1d.7/uevent
> Jul 27 15:17:17 ltg01-fedora kernel: Modules linked in: snd_timer snd
> soundcore snd_page_alloc intel_agp agpgart ide_cd cdrom ipv6 w83627hf
> hwmon_vid hwmon i2c_isa i2c_i801 skge af_packet
> ip_conntrack_netbios_ns ipt_REJECT xt_state ip_conntrack nfnetlink
> xt_tcpudp iptable_filter ip_tables x_tables cpufreq_userspace
> p4_clockmod speedstep_lib binfmt_misc thermal processor fan container
> rtc unix
> Jul 27 15:17:17 ltg01-fedora kernel: CPU:    0
> Jul 27 15:17:17 ltg01-fedora kernel: EIP:    0060:[<c0138722>]    Not
> tainted VLI
> Jul 27 15:17:17 ltg01-fedora kernel: EFLAGS: 00010046   (2.6.18-rc2-mm1 #78)
> Jul 27 15:17:17 ltg01-fedora kernel: EIP is at __lock_acquire+0x362/0xaea
> Jul 27 15:17:17 ltg01-fedora kernel: eax: 00000000   ebx: 6b6b6b6b
> ecx: c0360358   edx: 00000000
> Jul 27 15:17:17 ltg01-fedora kernel: esi: 00000000   edi: 00000000
> ebp: f544ddf4   esp: f544ddc0
> Jul 27 15:17:17 ltg01-fedora kernel: ds: 007b   es: 007b   ss: 0068
> Jul 27 15:17:17 ltg01-fedora kernel: Process udevd (pid: 1353,
> ti=f544d000 task=f6fce8f0 task.ti=f544d000)
> Jul 27 15:17:17 ltg01-fedora kernel: Stack: 00000000 00000000 00000000
> c7749ea4 f6fce8f0 c0138e74 000001e8 00000000
> Jul 27 15:17:17 ltg01-fedora kernel:        00000000 f6653fa4 00000246
> 00000000 00000000 f544de1c c0139214 00000000
> Jul 27 15:17:17 ltg01-fedora kernel:        00000002 00000000 c014fe3a
> c7749ea4 c7749e90 f6fce8f0 f5b19b04 f544de34
> Jul 27 15:17:17 ltg01-fedora kernel: Call Trace:
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c0139214>] lock_acquire+0x71/0x91
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c02f2bfb>] _spin_lock+0x23/0x32
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c014fe3a>]
> __delayacct_blkio_ticks+0x16/0x67
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c01a4f76>] do_task_stat+0x3df/0x6c1
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c01a5265>] proc_tgid_stat+0xd/0xf
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c01a29dd>] proc_info_read+0x50/0xb3
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c0171cbb>] vfs_read+0xcb/0x177
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c017217c>] sys_read+0x3b/0x71
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c0103119>] sysenter_past_esp+0x56/0x8d
> Jul 27 15:17:17 ltg01-fedora kernel: DWARF2 unwinder stuck at
> sysenter_past_esp+0x56/0x8d
> Jul 27 15:17:17 ltg01-fedora kernel: Leftover inexact backtrace:
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c0104318>] show_stack_log_lvl+0x8c/0x97
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c010447f>] show_registers+0x15c/0x1ed
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c01046c2>] die+0x1b2/0x2b7
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c0116f5f>] do_page_fault+0x410/0x4f0
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c0103d1d>] error_code+0x39/0x40
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c0139214>] lock_acquire+0x71/0x91
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c02f2bfb>] _spin_lock+0x23/0x32
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c014fe3a>]
> __delayacct_blkio_ticks+0x16/0x67
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c01a4f76>] do_task_stat+0x3df/0x6c1
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c01a5265>] proc_tgid_stat+0xd/0xf
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c01a29dd>] proc_info_read+0x50/0xb3
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c0171cbb>] vfs_read+0xcb/0x177
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c017217c>] sys_read+0x3b/0x71
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c0103119>] sysenter_past_esp+0x56/0x8d
> Jul 27 15:17:17 ltg01-fedora kernel: Code: 68 4b 75 2f c0 68 d5 04 00
> 00 68 b9 75 31 c0 68 e3 06 31 c0 e8 ce 7e fe ff e8 87 c2 fc ff 83 c4
> 10 eb 08 85 db 0f 84 6b 07 00 00 <f0> ff 83 9c 00 00 00 8b 55 dc 8b 92
> 5c 05 00 00 89 55 e4 83 fa
> Jul 27 15:17:17 ltg01-fedora kernel: EIP: [<c0138722>]
> __lock_acquire+0x362/0xaea SS:ESP 0068:f544ddc0
> Jul 27 15:17:17 ltg01-fedora kernel:  <3>BUG: sleeping function called
> from invalid context at /usr/src/linux-mm/kernel/rwsem.c:20
> Jul 27 15:17:17 ltg01-fedora kernel: in_atomic():1, irqs_disabled():1
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c0104192>] show_trace_log_lvl+0x58/0x152
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c0104896>] show_trace+0xd/0x10
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c01049b5>] dump_stack+0x19/0x1b
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c0118d37>] __might_sleep+0x8d/0x95
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c013595d>] down_read+0x15/0x3b
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c012cd93>]
> blocking_notifier_call_chain+0x11/0x2d
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c012cdc6>] notify_watchers+0x17/0x53
> Jul 27 15:17:17 ltg01-fedora kernel:  [<c0122961>] do_exit+0x26/0xa4f
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c01047a1>] die+0x291/0x2b7
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0116f5f>] do_page_fault+0x410/0x4f0
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0103d1d>] error_code+0x39/0x40
> Jul 27 15:17:18 ltg01-fedora kernel: DWARF2 unwinder stuck at
> error_code+0x39/0x40
> Jul 27 15:17:18 ltg01-fedora kernel: Leftover inexact backtrace:
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0104896>] show_trace+0xd/0x10
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c01049b5>] dump_stack+0x19/0x1b
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0118d37>] __might_sleep+0x8d/0x95
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c013595d>] down_read+0x15/0x3b
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c012cd93>]
> blocking_notifier_call_chain+0x11/0x2d
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c012cdc6>] notify_watchers+0x17/0x53
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0122961>] do_exit+0x26/0xa4f
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c01047a1>] die+0x291/0x2b7
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0116f5f>] do_page_fault+0x410/0x4f0
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0103d1d>] error_code+0x39/0x40
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0139214>] lock_acquire+0x71/0x91
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c02f2bfb>] _spin_lock+0x23/0x32
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c014fe3a>]
> __delayacct_blkio_ticks+0x16/0x67
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c01a4f76>] do_task_stat+0x3df/0x6c1
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c01a5265>] proc_tgid_stat+0xd/0xf
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c01a29dd>] proc_info_read+0x50/0xb3
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0171cbb>] vfs_read+0xcb/0x177
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c017217c>] sys_read+0x3b/0x71
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0103119>] sysenter_past_esp+0x56/0x8d
> Jul 27 15:17:18 ltg01-fedora kernel: note: udevd[1353] exited with
> preempt_count 1
> Jul 27 15:17:18 ltg01-fedora kernel: BUG: scheduling while atomic:
> udevd/0x00000001/1353
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0104192>] show_trace_log_lvl+0x58/0x152
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0104896>] show_trace+0xd/0x10
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c01049b5>] dump_stack+0x19/0x1b
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c02ef76f>] __sched_text_start+0x5f/0xc95
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c02f2977>] __down+0xaf/0xc3
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c02f275e>] __down_failed+0xa/0xe
> Jul 27 15:17:18 ltg01-fedora kernel: DWARF2 unwinder stuck at
> __down_failed+0xa/0xe
> Jul 27 15:17:18 ltg01-fedora kernel: Leftover inexact backtrace:
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0104896>] show_trace+0xd/0x10
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c01049b5>] dump_stack+0x19/0x1b
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c02ef76f>] __sched_text_start+0x5f/0xc95
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c02f2977>] __down+0xaf/0xc3
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c02f275e>] __down_failed+0xa/0xe
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c02f32aa>]
> .text.lock.kernel_lock+0x1b/0x3d
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c023c881>] disassociate_ctty+0xd/0x16e
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0122d8d>] do_exit+0x452/0xa4f
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c01047a1>] die+0x291/0x2b7
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0116f5f>] do_page_fault+0x410/0x4f0
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0103d1d>] error_code+0x39/0x40
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0139214>] lock_acquire+0x71/0x91
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c02f2bfb>] _spin_lock+0x23/0x32
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c014fe3a>]
> __delayacct_blkio_ticks+0x16/0x67
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c01a4f76>] do_task_stat+0x3df/0x6c1
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c01a5265>] proc_tgid_stat+0xd/0xf
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c01a29dd>] proc_info_read+0x50/0xb3
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0171cbb>] vfs_read+0xcb/0x177
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c017217c>] sys_read+0x3b/0x71
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0103119>] sysenter_past_esp+0x56/0x8d
> Jul 27 15:17:18 ltg01-fedora kernel: slab error in
> verify_redzone_free(): cache `delayacct_cache': double free detected
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0104192>] show_trace_log_lvl+0x58/0x152
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0104896>] show_trace+0xd/0x10
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c01049b5>] dump_stack+0x19/0x1b
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c016bdb4>] __slab_error+0x17/0x1c
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c016be85>]
> cache_free_debugcheck+0xcc/0x1c7
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c016c74f>] kmem_cache_free+0xa0/0xff
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c014ff3e>]
> __delayacct_tsk_exit+0x38/0x3d
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0150281>]
> delayacct_watch_task+0x5a/0x65
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c012ca03>] notifier_call_chain+0x20/0x31
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c012cd9f>]
> blocking_notifier_call_chain+0x1d/0x2d
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c012cdc6>] notify_watchers+0x17/0x53
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0122bf4>] do_exit+0x2b9/0xa4f
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0123415>] sys_exit_group+0x0/0x11
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0104896>] show_trace+0xd/0x10
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c01049b5>] dump_stack+0x19/0x1b
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c016bdb4>] __slab_error+0x17/0x1c
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c016be85>]
> cache_free_debugcheck+0xcc/0x1c7
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c016c74f>] kmem_cache_free+0xa0/0xff
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c014ff3e>]
> __delayacct_tsk_exit+0x38/0x3d
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0150281>]
> delayacct_watch_task+0x5a/0x65
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c012ca03>] notifier_call_chain+0x20/0x31
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c012cd9f>]
> blocking_notifier_call_chain+0x1d/0x2d
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c012cdc6>] notify_watchers+0x17/0x53
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0122bf4>] do_exit+0x2b9/0xa4f
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0123415>] sys_exit_group+0x0/0x11
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0123424>] sys_exit_group+0xf/0x11
> Jul 27 15:17:18 ltg01-fedora kernel:  [<c0103119>] sysenter_past_esp+0x56/0x8d
>
> list *0xc0138722
> 0xc0138722 is in __lock_acquire (include2/asm/atomic.h:96).
> 91       *
> 92       * Atomically increments @v by 1.
> 93       */
> 94      static __inline__ void atomic_inc(atomic_t *v)
> 95      {
> 96              __asm__ __volatile__(
> 97                      LOCK_PREFIX "incl %0"
> 98                      :"+m" (v->counter));
> 99      }
> 100
>
> http://www.stardust.webpages.pl/files/mm/2.6.18-rc2-mm1/mm-config
>

Matt, can you look at this?

My hunt file shows me, that this patches are causing oops.
GOOD
#
#
task-watchers-task-watchers.patch
task-watchers-register-process-events-task-watcher.patch
task-watchers-refactor-process-events.patch
task-watchers-make-process-events-configurable-as.patch
task-watchers-allow-task-watchers-to-block.patch
task-watchers-register-audit-task-watcher.patch
task-watchers-register-per-task-delay-accounting.patch
task-watchers-register-profile-as-a-task-watcher.patch
task-watchers-add-support-for-per-task-watchers.patch
task-watchers-register-semundo-task-watcher.patch
task-watchers-register-per-task-semundo-watcher.patch
BAD

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
