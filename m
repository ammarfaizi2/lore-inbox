Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262718AbUKRKga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbUKRKga (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 05:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbUKRK3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 05:29:47 -0500
Received: from mail.onestepahead.de ([62.96.100.59]:23487 "EHLO
	mail.onestepahead.de") by vger.kernel.org with ESMTP
	id S262720AbUKRK06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 05:26:58 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-0
From: Christian Meder <chris@onestepahead.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
In-Reply-To: <20041117124234.GA25956@elte.hu>
References: <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu>
	 <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu>
	 <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu>
	 <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu>
	 <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
	 <20041117124234.GA25956@elte.hu>
Content-Type: multipart/mixed; boundary="=-k/xeGY65uADo1GzM/FHh"
Date: Thu, 18 Nov 2004 11:24:01 +0100
Message-Id: <1100773441.3434.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-k/xeGY65uADo1GzM/FHh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-11-17 at 13:42 +0100, Ingo Molnar wrote:
> i have released the -V0.7.28-0 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 
> 	http://redhat.com/~mingo/realtime-preempt/
> 
> this is a fixes & latency-reduction release.

Hi,

here's another message log this time on my Dell laptop when removing my
prism wlan pccard running the hostap driver.

BTW I didn't see my previous report about my vdr/router box on lkml so I
hope it got through. Otherwise just tell me and I'll resend it.


			Christian

-- 
Christian Meder, email: chris@onestepahead.de

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)

--=-k/xeGY65uADo1GzM/FHh
Content-Disposition: attachment; filename=kern.log
Content-Type: text/x-log; name=kern.log; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Nov 18 09:43:02 localhost kernel: wifi0: LinkStatus=4 (Access point out of range)
Nov 18 09:43:02 localhost kernel: wifi0: LinkStatus: BSSID=00:09:5b:67:f0:98
Nov 18 09:43:06 localhost kernel: hostap_cs: CS_EVENT_CARD_REMOVAL
Nov 18 09:43:06 localhost kernel: wifi0: card already removed or not configured during shutdown
Nov 18 09:43:06 localhost kernel: wifi0: Interrupt, but dev not OK
Nov 18 09:43:06 localhost kernel: wifi0: card already removed or not configured during shutdown
Nov 18 09:43:07 localhost kernel: BUG: sleeping function called from invalid context modprobe(22211) at kernel/rt.c:1364
Nov 18 09:43:07 localhost kernel: in_atomic():1 [00000004], irqs_disabled():1
Nov 18 09:43:07 localhost kernel:  [__might_sleep+218/233] __might_sleep+0xda/0xe9 (8)
Nov 18 09:43:07 localhost kernel:  [__queue_work+78/102] __queue_work+0x4e/0x66 (24)
Nov 18 09:43:07 localhost kernel:  [__spin_lock+56/87] __spin_lock+0x38/0x57 (16)
Nov 18 09:43:07 localhost kernel:  [__up_mutex+458/1236] __up_mutex+0x1ca/0x4d4 (4)
Nov 18 09:43:07 localhost kernel:  [__up_mutex+458/1236] __up_mutex+0x1ca/0x4d4 (8)
Nov 18 09:43:07 localhost kernel:  [_spin_lock_irqsave+8/11] _spin_lock_irqsave+0x8/0xb (8)
Nov 18 09:43:07 localhost kernel:  [search_module_extables+18/115] search_module_extables+0x12/0x73 (4)
Nov 18 09:43:07 localhost kernel:  [__up_mutex+458/1236] __up_mutex+0x1ca/0x4d4 (4)
Nov 18 09:43:07 localhost kernel:  [search_exception_tables+33/35] search_exception_tables+0x21/0x23 (16)
Nov 18 09:43:07 localhost kernel:  [fixup_exception+30/104] fixup_exception+0x1e/0x68 (8)
Nov 18 09:43:07 localhost kernel:  [do_page_fault+499/1347] do_page_fault+0x1f3/0x543 (12)
Nov 18 09:43:07 localhost kernel:  [__down_mutex+464/844] __down_mutex+0x1d0/0x34c (148)
Nov 18 09:43:07 localhost kernel:  [dput+39/665] dput+0x27/0x299 (4)
Nov 18 09:43:07 localhost kernel:  [do_page_fault+0/1347] do_page_fault+0x0/0x543 (52)
Nov 18 09:43:07 localhost kernel:  [error_code+43/48] error_code+0x2b/0x30 (8)
Nov 18 09:43:07 localhost kernel:  [__up_mutex+458/1236] __up_mutex+0x1ca/0x4d4 (44)
Nov 18 09:43:07 localhost kernel:  [kobject_cleanup+140/142] kobject_cleanup+0x8c/0x8e (44)
Nov 18 09:43:07 localhost kernel:  [up+238/250] up+0xee/0xfa (24)
Nov 18 09:43:07 localhost kernel:  [kobject_cleanup+140/142] kobject_cleanup+0x8c/0x8e (32)
Nov 18 09:43:07 localhost kernel:  [kobject_release+0/8] kobject_release+0x0/0x8 (8)
Nov 18 09:43:07 localhost kernel:  [kref_put+62/232] kref_put+0x3e/0xe8 (12)
Nov 18 09:43:07 localhost kernel:  [bus_remove_driver+63/72] bus_remove_driver+0x3f/0x48 (36)
Nov 18 09:43:07 localhost kernel:  [driver_unregister+11/26] driver_unregister+0xb/0x1a (8)
Nov 18 09:43:07 localhost kernel:  [pg0+541997089/1068487680] exit_prism2_pccard+0xd/0x25 [hostap_cs] (8)
Nov 18 09:43:07 localhost kernel:  [sys_delete_module+315/361] sys_delete_module+0x13b/0x169 (12)
Nov 18 09:43:07 localhost kernel:  [unmap_vma_list+14/23] unmap_vma_list+0xe/0x17 (20)
Nov 18 09:43:07 localhost kernel:  [do_munmap+272/315] do_munmap+0x110/0x13b (12)
Nov 18 09:43:07 localhost kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (12)
Nov 18 09:43:07 localhost kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (24)
Nov 18 09:43:07 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb (12)
Nov 18 09:43:07 localhost kernel: ---------------------------
Nov 18 09:43:07 localhost kernel: | preempt count: 00000005 ]
Nov 18 09:43:07 localhost kernel: | 5-level deep critical section nesting:
Nov 18 09:43:07 localhost kernel: ----------------------------------------
Nov 18 09:43:07 localhost kernel: .. [up+168/250] .... up+0xa8/0xfa
Nov 18 09:43:07 localhost kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 18 09:43:07 localhost kernel: .. [__up_mutex+1221/1236] .... __up_mutex+0x4c5/0x4d4
Nov 18 09:43:07 localhost kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 18 09:43:07 localhost kernel: .. [__up_mutex+311/1236] .... __up_mutex+0x137/0x4d4
Nov 18 09:43:07 localhost kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 18 09:43:07 localhost kernel: .. [__up_mutex+439/1236] .... __up_mutex+0x1b7/0x4d4
Nov 18 09:43:07 localhost kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 18 09:43:07 localhost kernel: .. [print_traces+13/52] .... print_traces+0xd/0x34
Nov 18 09:43:07 localhost kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 18 09:43:07 localhost kernel: 
Nov 18 09:43:07 localhost kernel: BUG: Unable to handle kernel paging request at virtual address 656e7265
Nov 18 09:43:07 localhost kernel:  printing eip:
Nov 18 09:43:07 localhost kernel: c012f1ba
Nov 18 09:43:07 localhost kernel: *pde = 00000000
Nov 18 09:43:07 localhost kernel: Oops: 0000 [#1]
Nov 18 09:43:07 localhost kernel: PREEMPT 
Nov 18 09:43:07 localhost kernel: Modules linked in: hostap_crypt_wep hostap_cs hostap nfs lockd sunrpc lp binfmt_misc 8250_pci 8250_pnp 8250 serial_core evdev snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd snd_page_alloc
Nov 18 09:43:07 localhost kernel: CPU:    0
Nov 18 09:43:07 localhost kernel: EIP:    0060:[__up_mutex+458/1236]    Not tainted VLI
Nov 18 09:43:07 localhost kernel: EFLAGS: 00010097   (2.6.10-rc2-mm1-rt-v0.7.28-0) 
Nov 18 09:43:07 localhost kernel: EIP is at __up_mutex+0x1ca/0x4d4
Nov 18 09:43:07 localhost kernel: eax: 00000064   ebx: 00000064   ecx: 656e7265   edx: 00000064
Nov 18 09:43:07 localhost kernel: esi: c044f828   edi: d798f180   ebp: e09ea578   esp: cf890ec4
Nov 18 09:43:07 localhost kernel: ds: 007b   es: 007b   ss: 0068   preempt: 00000005
Nov 18 09:43:07 localhost kernel: Process modprobe (pid: 22211, threadinfo=cf890000 task=d11e0120)
Nov 18 09:43:07 localhost kernel: Stack: 00000246 d11e0120 d11e0120 00000246 cf890000 c0407898 00000246 c14d7400 
Nov 18 09:43:07 localhost kernel:        c01f73f2 00000000 e09ea574 c044f828 c0457980 c0457990 c013024c cf890000 
Nov 18 09:43:07 localhost kernel:        c0457964 00000246 c0407880 d57ee108 cf890000 e09ea5a8 c01f73f2 e09ea5c0 
Nov 18 09:43:07 localhost kernel: Call Trace:
Nov 18 09:43:07 localhost kernel:  [kobject_cleanup+140/142] kobject_cleanup+0x8c/0x8e (36)
Nov 18 09:43:07 localhost kernel:  [up+238/250] up+0xee/0xfa (24)
Nov 18 09:43:07 localhost kernel:  [kobject_cleanup+140/142] kobject_cleanup+0x8c/0x8e (32)
Nov 18 09:43:07 localhost kernel:  [kobject_release+0/8] kobject_release+0x0/0x8 (8)
Nov 18 09:43:07 localhost kernel:  [kref_put+62/232] kref_put+0x3e/0xe8 (12)
Nov 18 09:43:07 localhost kernel:  [bus_remove_driver+63/72] bus_remove_driver+0x3f/0x48 (36)
Nov 18 09:43:07 localhost kernel:  [driver_unregister+11/26] driver_unregister+0xb/0x1a (8)
Nov 18 09:43:07 localhost kernel:  [pg0+541997089/1068487680] exit_prism2_pccard+0xd/0x25 [hostap_cs] (8)
Nov 18 09:43:07 localhost kernel:  [sys_delete_module+315/361] sys_delete_module+0x13b/0x169 (12)
Nov 18 09:43:07 localhost kernel:  [unmap_vma_list+14/23] unmap_vma_list+0xe/0x17 (20)
Nov 18 09:43:07 localhost kernel:  [do_munmap+272/315] do_munmap+0x110/0x13b (12)
Nov 18 09:43:07 localhost kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (12)
Nov 18 09:43:07 localhost kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (24)
Nov 18 09:43:07 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb (12)
Nov 18 09:43:07 localhost kernel: ---------------------------
Nov 18 09:43:07 localhost kernel: | preempt count: 00000006 ]
Nov 18 09:43:07 localhost kernel: | 6-level deep critical section nesting:
Nov 18 09:43:07 localhost kernel: ----------------------------------------
Nov 18 09:43:07 localhost kernel: .. [task_rq_lock+17/24] .... task_rq_lock+0x11/0x18
Nov 18 09:43:07 localhost kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 18 09:43:07 localhost kernel: .. [task_rq_lock+17/24] .... task_rq_lock+0x11/0x18
Nov 18 09:43:07 localhost kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 18 09:43:07 localhost kernel: .. [__up_mutex+311/1236] .... __up_mutex+0x137/0x4d4
Nov 18 09:43:07 localhost kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 18 09:43:07 localhost kernel: .. [__up_mutex+439/1236] .... __up_mutex+0x1b7/0x4d4
Nov 18 09:43:07 localhost kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 18 09:43:07 localhost kernel: .. [die+54/381] .... die+0x36/0x17d
Nov 18 09:43:07 localhost kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 18 09:43:07 localhost kernel: .. [print_traces+13/52] .... print_traces+0xd/0x34
Nov 18 09:43:07 localhost kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 18 09:43:07 localhost kernel: 
Nov 18 09:43:07 localhost kernel: Code: c0 e8 f5 b8 fe ff 0f 0b 36 04 3d 1d 3a c0 b8 01 00 00 00 e8 23 15 00 00 8b 45 08 e8 ae 79 fe ff 8b 7d 08 8b 8f 48 06 00 00 89 c3 <8b> 11 0f 18 02 90 8d 87 48 06 00 00 39 c1 74 18 89 c6 8b 41 0c 
Nov 18 09:43:07 localhost kernel:  <6>note: modprobe[22211] exited with preempt_count 4
Nov 18 09:43:07 localhost kernel: BUG: scheduling while atomic: modprobe/0x10000004/22211
Nov 18 09:43:07 localhost kernel: caller is __cond_resched+0x39/0x45
Nov 18 09:43:07 localhost kernel:  [__schedule+1439/1519] __sched_text_start+0x59f/0x5ef (8)
Nov 18 09:43:07 localhost kernel:  [__cond_resched+57/69] __cond_resched+0x39/0x45 (72)
Nov 18 09:43:07 localhost kernel:  [cond_resched+28/35] cond_resched+0x1c/0x23 (12)
Nov 18 09:43:07 localhost kernel:  [unmap_vmas+318/359] unmap_vmas+0x13e/0x167 (8)
Nov 18 09:43:07 localhost kernel:  [exit_mmap+79/274] exit_mmap+0x4f/0x112 (60)
Nov 18 09:43:07 localhost kernel:  [mmput+66/320] mmput+0x42/0x140 (40)
Nov 18 09:43:07 localhost kernel:  [do_exit+325/1281] do_exit+0x145/0x501 (24)
Nov 18 09:43:07 localhost kernel:  [do_divide_error+0/246] do_divide_error+0x0/0xf6 (44)
Nov 18 09:43:07 localhost kernel:  [do_page_fault+678/1347] do_page_fault+0x2a6/0x543 (64)
Nov 18 09:43:07 localhost kernel:  [__down_mutex+464/844] __down_mutex+0x1d0/0x34c (148)
Nov 18 09:43:07 localhost kernel:  [dput+39/665] dput+0x27/0x299 (4)
Nov 18 09:43:07 localhost kernel:  [do_page_fault+0/1347] do_page_fault+0x0/0x543 (52)
Nov 18 09:43:07 localhost kernel:  [error_code+43/48] error_code+0x2b/0x30 (8)
Nov 18 09:43:07 localhost kernel:  [__up_mutex+458/1236] __up_mutex+0x1ca/0x4d4 (44)
Nov 18 09:43:07 localhost kernel:  [kobject_cleanup+140/142] kobject_cleanup+0x8c/0x8e (44)
Nov 18 09:43:07 localhost kernel:  [up+238/250] up+0xee/0xfa (24)
Nov 18 09:43:07 localhost kernel:  [kobject_cleanup+140/142] kobject_cleanup+0x8c/0x8e (32)
Nov 18 09:43:07 localhost kernel:  [kobject_release+0/8] kobject_release+0x0/0x8 (8)
Nov 18 09:43:07 localhost kernel:  [kref_put+62/232] kref_put+0x3e/0xe8 (12)
Nov 18 09:43:07 localhost kernel:  [bus_remove_driver+63/72] bus_remove_driver+0x3f/0x48 (36)
Nov 18 09:43:07 localhost kernel:  [driver_unregister+11/26] driver_unregister+0xb/0x1a (8)
Nov 18 09:43:07 localhost kernel:  [pg0+541997089/1068487680] exit_prism2_pccard+0xd/0x25 [hostap_cs] (8)
Nov 18 09:43:07 localhost kernel:  [sys_delete_module+315/361] sys_delete_module+0x13b/0x169 (12)
Nov 18 09:43:07 localhost kernel:  [unmap_vma_list+14/23] unmap_vma_list+0xe/0x17 (20)
Nov 18 09:43:07 localhost kernel:  [do_munmap+272/315] do_munmap+0x110/0x13b (12)
Nov 18 09:43:07 localhost kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (12)
Nov 18 09:43:07 localhost kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (24)
Nov 18 09:43:07 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb (12)
Nov 18 09:43:07 localhost kernel: ---------------------------
Nov 18 09:43:07 localhost kernel: | preempt count: 10000005 ]
Nov 18 09:43:07 localhost kernel: | 5-level deep critical section nesting:
Nov 18 09:43:07 localhost kernel: ----------------------------------------
Nov 18 09:43:07 localhost kernel: .. [task_rq_lock+17/24] .... task_rq_lock+0x11/0x18
Nov 18 09:43:07 localhost kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 18 09:43:07 localhost kernel: .. [task_rq_lock+17/24] .... task_rq_lock+0x11/0x18
Nov 18 09:43:07 localhost kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 18 09:43:07 localhost kernel: .. [__up_mutex+311/1236] .... __up_mutex+0x137/0x4d4
Nov 18 09:43:07 localhost kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 18 09:43:07 localhost kernel: .. [__up_mutex+439/1236] .... __up_mutex+0x1b7/0x4d4
Nov 18 09:43:07 localhost kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 18 09:43:07 localhost kernel: .. [print_traces+13/52] .... print_traces+0xd/0x34
Nov 18 09:43:07 localhost kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 18 09:43:07 localhost kernel: 
Nov 18 09:43:07 localhost kernel: BUG: scheduling while atomic: modprobe/0x00000004/22211
Nov 18 09:43:07 localhost kernel: caller is do_exit+0x2a1/0x501
Nov 18 09:43:07 localhost kernel:  [__schedule+1439/1519] __sched_text_start+0x59f/0x5ef (8)
Nov 18 09:43:07 localhost kernel:  [do_exit+673/1281] do_exit+0x2a1/0x501 (72)
Nov 18 09:43:07 localhost kernel:  [do_divide_error+0/246] do_divide_error+0x0/0xf6 (44)
Nov 18 09:43:07 localhost kernel:  [do_page_fault+678/1347] do_page_fault+0x2a6/0x543 (64)
Nov 18 09:43:07 localhost kernel:  [__down_mutex+464/844] __down_mutex+0x1d0/0x34c (148)
Nov 18 09:43:07 localhost kernel:  [dput+39/665] dput+0x27/0x299 (4)
Nov 18 09:43:07 localhost kernel:  [do_page_fault+0/1347] do_page_fault+0x0/0x543 (52)
Nov 18 09:43:07 localhost kernel:  [error_code+43/48] error_code+0x2b/0x30 (8)
Nov 18 09:43:07 localhost kernel:  [__up_mutex+458/1236] __up_mutex+0x1ca/0x4d4 (44)
Nov 18 09:43:07 localhost kernel:  [kobject_cleanup+140/142] kobject_cleanup+0x8c/0x8e (44)
Nov 18 09:43:07 localhost kernel:  [up+238/250] up+0xee/0xfa (24)
Nov 18 09:43:07 localhost kernel:  [kobject_cleanup+140/142] kobject_cleanup+0x8c/0x8e (32)
Nov 18 09:43:07 localhost kernel:  [kobject_release+0/8] kobject_release+0x0/0x8 (8)
Nov 18 09:43:07 localhost kernel:  [kref_put+62/232] kref_put+0x3e/0xe8 (12)
Nov 18 09:43:07 localhost kernel:  [bus_remove_driver+63/72] bus_remove_driver+0x3f/0x48 (36)
Nov 18 09:43:07 localhost kernel:  [driver_unregister+11/26] driver_unregister+0xb/0x1a (8)
Nov 18 09:43:07 localhost kernel:  [pg0+541997089/1068487680] exit_prism2_pccard+0xd/0x25 [hostap_cs] (8)
Nov 18 09:43:07 localhost kernel:  [sys_delete_module+315/361] sys_delete_module+0x13b/0x169 (12)
Nov 18 09:43:07 localhost kernel:  [unmap_vma_list+14/23] unmap_vma_list+0xe/0x17 (20)
Nov 18 09:43:07 localhost kernel:  [do_munmap+272/315] do_munmap+0x110/0x13b (12)
Nov 18 09:43:07 localhost kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (12)
Nov 18 09:43:07 localhost kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (24)
Nov 18 09:43:07 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb (12)
Nov 18 09:43:07 localhost kernel: ---------------------------
Nov 18 09:43:07 localhost kernel: | preempt count: 00000005 ]
Nov 18 09:43:07 localhost kernel: | 5-level deep critical section nesting:
Nov 18 09:43:07 localhost kernel: ----------------------------------------
Nov 18 09:43:07 localhost kernel: .. [task_rq_lock+17/24] .... task_rq_lock+0x11/0x18
Nov 18 09:43:07 localhost kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 18 09:43:07 localhost kernel: .. [task_rq_lock+17/24] .... task_rq_lock+0x11/0x18
Nov 18 09:43:07 localhost kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 18 09:43:07 localhost kernel: .. [__up_mutex+311/1236] .... __up_mutex+0x137/0x4d4
Nov 18 09:43:07 localhost kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 18 09:43:07 localhost kernel: .. [__up_mutex+439/1236] .... __up_mutex+0x1b7/0x4d4
Nov 18 09:43:07 localhost kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 18 09:43:07 localhost kernel: .. [print_traces+13/52] .... print_traces+0xd/0x34
Nov 18 09:43:07 localhost kernel: .....[<00000000>] ..   ( <= 0x0)
Nov 18 09:43:07 localhost kernel: 

--=-k/xeGY65uADo1GzM/FHh--

