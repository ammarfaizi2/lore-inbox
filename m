Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUJLPWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUJLPWu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 11:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbUJLPWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 11:22:50 -0400
Received: from mail3.utc.com ([192.249.46.192]:48534 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S265161AbUJLPSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 11:18:41 -0400
Message-ID: <416BF44E.6080309@cybsft.com>
Date: Tue, 12 Oct 2004 10:12:14 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T6
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu>
In-Reply-To: <20041012123318.GA2102@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080907080607000404050706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080907080607000404050706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> i've uploaded -T7:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-T7
> 
OK. This one builds just fine here. Again I tried booting preempt 
realtime. We were going along fine and then all hell broke loose on the 
console. Pressed Ctrl-s to stop the scrolling and it then bit the dust. 
It did manage to get into the logs this time and I am attaching that. 
This is a different SMP system that I use as a workstation at a client site.
Dual 2.6GHz Xeons (with HT)
512MB

kr


--------------080907080607000404050706
Content-Type: text/plain;
 name="rtpreT7.dump"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtpreT7.dump"

Oct 12 09:52:58 swdev14 syslogd 1.4.1: restart.
Oct 12 09:52:58 swdev14 syslog: syslogd startup succeeded
Oct 12 09:52:59 swdev14 kernel: klogd 1.4.1, log source = /proc/kmsg started.
Oct 12 09:52:59 swdev14 syslog: klogd startup succeeded
Oct 12 09:52:59 swdev14 kernel:  sys_init_module+0x68/0x1ce
Oct 12 09:52:59 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 09:52:59 swdev14 kernel: scheduling while atomic: usb.agent/0x04010000/1298
Oct 12 09:52:59 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 09:52:59 swdev14 kernel:  [<c0299267>] schedule+0xbaf/0xbe2
Oct 12 09:52:59 swdev14 kernel:  [<c0299716>] cond_resched+0x63/0x83
Oct 12 09:52:59 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:52:59 swdev14 kernel:  [<c02996d9>] cond_resched+0x26/0x83
Oct 12 09:52:59 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:52:59 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:52:59 swdev14 kernel:  [<c02996d9>] cond_resched+0x26/0x83
Oct 12 09:52:59 swdev14 kernel:  [<c0299716>] cond_resched+0x63/0x83
Oct 12 09:52:59 swdev14 kernel:  [<c0133b8e>] _rw_mutex_read_lock+0x24/0x39
Oct 12 09:52:59 swdev14 kernel:  [<c011f8f1>] profile_hook+0x1d/0x47
Oct 12 09:52:59 swdev14 irqbalance: irqbalance startup succeeded
Oct 12 09:52:59 swdev14 kernel:  [<c011fde3>] profile_tick+0x63/0x65
Oct 12 09:52:59 swdev14 kernel:  [<c0113d03>] smp_apic_timer_interrupt+0x60/0xe4
Oct 12 09:52:59 swdev14 kernel:  [<c0106bb6>] apic_timer_interrupt+0x1a/0x20
Oct 12 09:52:59 swdev14 kernel: EXT3 FS on hda6, internal journal
Oct 12 09:52:59 swdev14 kernel: device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Oct 12 09:52:59 swdev14 kernel: Adding 2048216k swap on /dev/hda5.  Priority:-1 extents:1
Oct 12 09:52:59 swdev14 kernel: scheduling while atomic: rc.sysinit/0x04010001/1561
Oct 12 09:52:59 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 09:52:59 swdev14 kernel:  [<c0299267>] schedule+0xbaf/0xbe2
Oct 12 09:52:59 swdev14 kernel:  [<c0299716>] cond_resched+0x63/0x83
Oct 12 09:52:59 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:52:59 swdev14 kernel:  [<c02996d9>] cond_resched+0x26/0x83
Oct 12 09:52:59 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:52:59 swdev14 portmap: portmap startup succeeded
Oct 12 09:52:59 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:52:59 swdev14 kernel:  [<c02996d9>] cond_resched+0x26/0x83
Oct 12 09:52:59 swdev14 kernel:  [<c0299716>] cond_resched+0x63/0x83
Oct 12 09:52:59 swdev14 kernel:  [<c0133b8e>] _rw_mutex_read_lock+0x24/0x39
Oct 12 09:52:59 swdev14 kernel:  [<c011f8f1>] profile_hook+0x1d/0x47
Oct 12 09:52:59 swdev14 kernel:  [<c011fde3>] profile_tick+0x63/0x65
Oct 12 09:52:59 swdev14 kernel:  [<c0113d03>] smp_apic_timer_interrupt+0x60/0xe4
Oct 12 09:52:59 swdev14 kernel:  [<c0106bb6>] apic_timer_interrupt+0x1a/0x20
Oct 12 09:52:59 swdev14 kernel:  [<c011007b>] generic_set_mtrr+0x68/0x9c
Oct 12 09:52:59 swdev14 kernel:  [<c029a35d>] _spin_unlock_irqrestore+0x10/0x36
Oct 12 09:52:59 swdev14 rpc.statd[2649]: Version 1.0.6 Starting
Oct 12 09:52:59 swdev14 kernel:  [<c0118895>] try_to_wake_up+0x1e8/0x270
Oct 12 09:52:59 swdev14 kernel:  [<c0118940>] wake_up_process+0x23/0x27
Oct 12 09:52:59 swdev14 kernel:  [<c011923d>] sched_migrate_task+0x7e/0x9d
Oct 12 09:52:59 swdev14 nfslock: rpc.statd startup succeeded
Oct 12 09:52:59 swdev14 kernel:  [<c01192e6>] sched_exec+0x8a/0xd4
Oct 12 09:52:59 swdev14 kernel:  [<c01192fb>] sched_exec+0x9f/0xd4
Oct 12 09:52:59 swdev14 kernel:  [<c0166f3b>] do_execve+0x3e/0x249
Oct 12 09:52:59 swdev14 kernel:  [<c0168881>] getname+0x91/0xbc
Oct 12 09:52:59 swdev14 kernel:  [<c0104d5d>] sys_execve+0x47/0x9a
Oct 12 09:52:59 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 09:52:59 swdev14 kernel: scheduling while atomic: grep/0x04010000/1569
Oct 12 09:52:59 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 09:52:59 swdev14 kernel:  [<c0299267>] schedule+0xbaf/0xbe2
Oct 12 09:52:59 swdev14 kernel:  [<c0299716>] cond_resched+0x63/0x83
Oct 12 09:52:59 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:52:59 swdev14 kernel:  [<c02996d9>] cond_resched+0x26/0x83
Oct 12 09:53:00 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:00 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:53:00 swdev14 kernel:  [<c02996d9>] cond_resched+0x26/0x83
Oct 12 09:53:00 swdev14 kernel:  [<c0299716>] cond_resched+0x63/0x83
Oct 12 09:53:00 swdev14 kernel:  [<c0133b8e>] _rw_mutex_read_lock+0x24/0x39
Oct 12 09:53:00 swdev14 kernel:  [<c011f8f1>] profile_hook+0x1d/0x47
Oct 12 09:53:00 swdev14 rpcidmapd: rpc.idmapd startup succeeded
Oct 12 09:53:00 swdev14 kernel:  [<c011fde3>] profile_tick+0x63/0x65
Oct 12 09:53:00 swdev14 kernel:  [<c0113d03>] smp_apic_timer_interrupt+0x60/0xe4
Oct 12 09:53:00 swdev14 kernel:  [<c0106bb6>] apic_timer_interrupt+0x1a/0x20
Oct 12 09:53:00 swdev14 kernel:  [<c011007b>] generic_set_mtrr+0x68/0x9c
Oct 12 09:53:00 swdev14 kernel:  [<c02996c7>] cond_resched+0x14/0x83
Oct 12 09:53:00 swdev14 kernel:  [<c0133822>] _mutex_lock+0x19/0x3f
Oct 12 09:53:00 swdev14 kernel:  [<c014d347>] handle_mm_fault+0x54/0x18a
Oct 12 09:53:00 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:00 swdev14 random: Initializing random number generator:  succeeded
Oct 12 09:53:00 swdev14 kernel:  [<c0116fa8>] do_page_fault+0x20b/0x662
Oct 12 09:53:00 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:00 swdev14 kernel:  [<c02996c1>] cond_resched+0xe/0x83
Oct 12 09:53:00 swdev14 kernel:  [<c014e08f>] sys_brk+0x28/0x10f
Oct 12 09:53:00 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:00 swdev14 kernel:  [<c02996d9>] cond_resched+0x26/0x83
Oct 12 09:53:00 swdev14 kernel:  [<c014e08f>] sys_brk+0x28/0x10f
Oct 12 09:53:00 swdev14 kernel:  [<c014fd3a>] sys_munmap+0x59/0x7b
Oct 12 09:53:00 swdev14 rc: Starting pcmcia:  succeeded
Oct 12 09:53:00 swdev14 kernel:  [<c0116d9d>] do_page_fault+0x0/0x662
Oct 12 09:53:00 swdev14 kernel:  [<c0106c31>] error_code+0x2d/0x38
Oct 12 09:53:00 swdev14 kernel: scheduling while atomic: cat/0x04010000/1752
Oct 12 09:53:00 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 09:53:00 swdev14 kernel:  [<c0299267>] schedule+0xbaf/0xbe2
Oct 12 09:53:00 swdev14 kernel:  [<c0299716>] cond_resched+0x63/0x83
Oct 12 09:53:00 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:53:00 swdev14 kernel:  [<c02996d9>] cond_resched+0x26/0x83
Oct 12 09:53:00 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:00 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:53:00 swdev14 kernel:  [<c02996d9>] cond_resched+0x26/0x83
Oct 12 09:53:00 swdev14 kernel:  [<c0299716>] cond_resched+0x63/0x83
Oct 12 09:53:00 swdev14 kernel:  [<c0133b8e>] _rw_mutex_read_lock+0x24/0x39
Oct 12 09:53:00 swdev14 kernel:  [<c011f8f1>] profile_hook+0x1d/0x47
Oct 12 09:53:00 swdev14 kernel:  [<c011fde3>] profile_tick+0x63/0x65
Oct 12 09:53:00 swdev14 kernel:  [<c0113d03>] smp_apic_timer_interrupt+0x60/0xe4
Oct 12 09:53:00 swdev14 kernel:  [<c0106bb6>] apic_timer_interrupt+0x1a/0x20
Oct 12 09:53:00 swdev14 kernel:  [<c011007b>] generic_set_mtrr+0x68/0x9c
Oct 12 09:53:00 swdev14 kernel:  [<c015b55f>] vfs_read+0x0/0x134
Oct 12 09:53:00 swdev14 kernel:  [<c015b8ed>] sys_read+0x50/0x7a
Oct 12 09:53:00 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 09:53:00 swdev14 kernel: schedulingro0x603>] er_i> [ic_<4c0134_pre<4> pr<c01tr88>] checkpt1fd9>
Oct 12 09:53:00 swdev14 kernel:  [<c0299] 49/0x1pr19136>] pt_ [<mc4> _spore+0xb[<c7
Oct 12 09:53:00 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:00 swdev14 kernel:  [<c0298496>] __down+0x8a/0x107
Oct 12 09:53:00 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 09:53:00 swdev14 kernel:  [<c029865c>] __down_failed+0x8/0xc
Oct 12 09:53:00 swdev14 kernel:  [<c0133ee3>] .text.lock.mutex+0x5/0x146
Oct 12 09:53:00 swdev14 kernel:  [<c0133884>] _mutex_lock_irqsave+0x16/0x1c
Oct 12 09:53:00 swdev14 kernel:  [<e0840abe>] boomerang_start_xmit+0x123/0x2eb [3c59x]
Oct 12 09:53:00 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:00 swdev14 kernel:  [<c029a2b8>] _spin_unlock+0xb/0x34
Oct 12 09:53:00 swdev14 kernel:  [<c02404f3>] qdisc_restart+0x132/0x1e6
Oct 12 09:53:00 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:00 swdev14 kernel:  [<c0240517>] qdisc_restart+0x156/0x1e6
Oct 12 09:53:00 swdev14 kernel:  [<c02313dd>] dev_queue_xmit+0x239/0x2d9
Oct 12 09:53:00 swdev14 kernel:  [<c024ecfa>] ip_finish_output+0xd5/0x216
Oct 12 09:53:00 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:00 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:00 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:01 swdev14 kernel:  [<c023bf2c>] nf_hook_slow+0xec/0x11e
Oct 12 09:53:01 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:01 swdev14 kernel:  [<c024f539>] ip_queue_xmit+0x495/0x59e
Oct 12 09:53:01 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:01 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:01 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:01 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:01 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:01 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:01 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:01 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:01 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:01 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:01 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:01 swdev14 kernel:  [<c025fbf1>] tcp_transmit_skb+0x432/0x852
Oct 12 09:53:01 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:01 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:01 swdev14 kernel:  [<c025fc9d>] tcp_transmit_skb+0x4de/0x852
Oct 12 09:53:01 swdev14 kernel:  [<c01b2056>] memcpy+0x12/0x3c
Oct 12 09:53:01 swdev14 kernel:  [<c0260a83>] tcp_write_xmit+0x149/0x2c0
Oct 12 09:53:01 swdev14 kernel:  [<c0254a8e>] tcp_sendmsg+0x4ff/0x108d
Oct 12 09:53:01 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:01 swdev14 kernel:  [<c0254a65>] tcp_sendmsg+0x4d6/0x108d
Oct 12 09:53:01 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:01 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:01 swdev14 kernel: ]97a>]6>0dae+0>+0c0+0xc0_wxumi5e+] v/t[x010xdux0>0c0>on> [o0c0/41cre46/nd_x8he> _mu+pd/ro03>e [i
Oct 12 09:53:01 swdev14 kernel:  [<]9/0r1936pt> [m4>_sre+[07
Oct 12 09:53:01 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:01 swdev14 kernel:  [<c0298496>] __down+0x8a/0x107
Oct 12 09:53:01 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 09:53:01 swdev14 kernel:  [<c029865c>] __down_failed+0x8/0xc
Oct 12 09:53:01 swdev14 kernel:  [<c0133ee3>] .text.lock.mutex+0x5/0x146
Oct 12 09:53:01 swdev14 kernel:  [<c0133884>] _mutex_lock_irqsave+0x16/0x1c
Oct 12 09:53:01 swdev14 kernel:  [<e0840abe>] boomerang_start_xmit+0x123/0x2eb [3c59x]
Oct 12 09:53:01 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:01 swdev14 kernel:  [<c029a2b8>] _spin_unlock+0xb/0x34
Oct 12 09:53:01 swdev14 kernel:  [<c02404f3>] qdisc_restart+0x132/0x1e6
Oct 12 09:53:01 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:01 swdev14 kernel:  [<c0240517>] qdisc_restart+0x156/0x1e6
Oct 12 09:53:01 swdev14 kernel:  [<c02313dd>] dev_queue_xmit+0x239/0x2d9
Oct 12 09:53:01 swdev14 kernel:  [<c024ecfa>] ip_finish_output+0xd5/0x216
Oct 12 09:53:01 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:01 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:01 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:01 swdev14 kernel:  [<c023bf2c>] nf_hook_slow+0xec/0x11e
Oct 12 09:53:01 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:01 swdev14 kernel:  [<c024f539>] ip_queue_xmit+0x495/0x59e
Oct 12 09:53:01 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:01 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:01 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:01 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:01 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:01 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:01 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:01 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:01 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:01 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:01 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:01 swdev14 kernel:  [<c025fbf1>] tcp_transmit_skb+0x432/0x852
Oct 12 09:53:01 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:01 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:01 swdev14 kernel:  [<c025fc9d>] tcp_transmit_skb+0x4de/0x852
Oct 12 09:53:01 swdev14 kernel:  [<c01b2056>] memcpy+0x12/0x3c
Oct 12 09:53:01 swdev14 kernel:  [<c0260a83>] tcp_write_xmit+0x149/0x2c0
Oct 12 09:53:01 swdev14 kernel:  [<c0254a8e>] tcp_sendmsg+0x4ff/0x108d
Oct 12 09:53:01 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:01 swdev14 kernel:  [<c0254a65>] tcp_sendmsg+0x4d6/0x108d
Oct 12 09:53:01 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:01 swdev14 last message repeated 2 times
Oct 12 09:53:01 swdev14 kernel:  [<c0227bda>] sock_aio_write+0x124/0x136
Oct 12 09:53:01 swdev14 kernel:  [<c02764e0>] inet_sendmsg+0x50/0x5b
Oct 12 09:53:01 swdev14 kernel:  [<c0227bda>] sock_aio_write+0x124/0x136
Oct 12 09:53:01 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:01 swdev14 kernel:  [<c015b73d>] do_sync_write+0xaa/0xd6
Oct 12 09:53:01 swdev14 kernel:  [<c01333e3>] autoremove_wake_function+0x0/0x57
Oct 12 09:53:01 swdev14 kernel:  [<c01a9bd8>] dummy_file_permiansm026chec> [_skb<4>x3c
Oct 12 09:53:01 swdev14 kernel: 3>] tc4a8eg+0[<nt+54sg+04aft_
Oct 12 09:53:01 swdev14 kernel:   su7
Oct 12 09:53:01 swdev14 kernel: ] x97
Oct 12 09:53:01 swdev14 kernel:  ref>] c01348_pr
Oct 12 09:53:01 swdev14 kernel:   pr<c01tra88>] check_pt1f9d9>7
Oct 12 09:53:01 swdev14 kernel:  [<c02992] 496/0x1pr19136>]pt_ [<mc4> _spore+0x[<7
Oct 12 09:53:01 swdev14 kernel:  [<c01136d4>] mcount+0x1>] ] dunc[<cwn_<c013.lo338ck_ [omec514d>c0unl02404f3>] qest[<c0nt+qdisc56/0>] de+outd1e
Oct 12 09:53:01 swdev14 kernel: ] 0x239>[<cout>] suntsub_pree+0xpin_unlox34 subt+0xpree2/0a2c7ck+134eem29a2clocc013nt+265end
Oct 12 09:53:01 swdev14 kernel: <4 tc [unttcp_v4_s+0x5fmit6>x3c>] +0x[<c025sen8d
Oct 12 09:53:01 swdev14 kernel: ] a65>] t+0x134ampt0134emp34apt_caio_x13>]x50a>e+0d4>0x1d>] e+01a9bile_cricrit<4> [<mco[<cwri10617_pa3>scle 2/27is /0x2674> [ondc0pre
Oct 12 09:53:01 swdev14 kernel: <4] c [<ck_
Oct 12 09:53:01 swdev14 kernel: <029<4con<4> [<c_rw+0c01/fde
Oct 12 09:53:01 swdev14 kernel: < smnter4
Oct 12 09:53:01 swdev14 kernel: <er_in/0xe_con9/fb2>]12cheing1e1d6edce+08>] _ti106fck+] 0xn+0x8a/[<ctimi9
Oct 12 09:53:01 swdev14 kernel: <_pr0x_mcount+0x11
Oct 12 09:53:01 swdev14 kernel: <] _sqrec0298491>] __d+0+0<c04def0x0/029+0x01ock.46
Oct 12 09:53:01 swdev14 kernel: mutexve+ boomerang_start_xmit+0x123/0x2eb [3c59x]
Oct 12 09:53:01 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:01 swdev14 kernel:  [<c029a2b8>] _spin_unlock+0xb/0x34
Oct 12 09:53:01 swdev14 kernel:  [<c02404f3>] qdisc_restart+0x132/0x1e6
Oct 12 09:53:01 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:01 swdev14 kernel:  [<c0240517>] qdisc_restart+0x156/0x1e6
Oct 12 09:53:01 swdev14 kernel:  [<c02313dd>] dev_queue_xmit+0x239/0x2d9
Oct 12 09:53:01 swdev14 kernel:  [<c024ecfa>] ip_finish_output+0xd5/0x216
Oct 12 09:53:01 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:01 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:01 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:01 swdev14 kernel:  [<c023bf2c>] nf_hook_slow+0xec/0x11e
Oct 12 09:53:01 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:01 swdev14 kernel:  [<c024f539>] ip_queue_xmit+0x495/0x59e
Oct 12 09:53:01 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:01 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:01 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:01 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:01 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:02 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:02 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:02 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:02 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:02 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:02 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:02 swdev14 kernel:  [<c025fbf1>] tcp_transmit_skb+0x432/0x852
Oct 12 09:53:02 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:02 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:02 swdev14 kernel:  [<c025fc9d>] tcp_transmit_skb+0x4de/0x852
Oct 12 09:53:02 swdev14 kernel:  [<c01b2056>] memcpy+0x12/0x3c
Oct 12 09:53:02 swdev14 kernel:  [<c0260a83>] tcp_write_xmit+0x149/0x2c0
Oct 12 09:53:02 swdev14 kernel:  [<c0254a8e>] tcp_sendmsg+0x4ff/0x108d
Oct 12 09:53:02 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:02 swdev14 kernel:  [<c0254a65>] tcp_sendmsg+0x4d6/0x108d
Oct 12 09:53:02 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:02 swdev14 last message repeated 2 times
Oct 12 09:53:02 swdev14 kernel:  [<c0227bda>] sock_aio_write+0x124/0x136
Oct 12 09:53:02 swdev14 kernel:  [<c02764e0>] inet_sendmsg+0x50/0x5b
Oct 12 09:53:02 swdev14 kernel:  [<c0227bda>] sock_aio_write+0x124/0x136
Oct 12 09:53:02 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:02 swdev14 kernel:  [<c015b73d>] do_sync_write+0xaa/0xd6
Oct 12 09:53:02 swdev14 kernel:  [<c01333e3>] autoremove_wake_function+0x0/0x57
Oct 12 09:53:02 swdev14 kernel:  [<c01a9bd8>] dummy_file_permission+0x8/0xc
Oct 12 09:53:02 swdev14 kernel:  [<c015b80b>] vfs_write+0xa2/0x134
Oct 12 09:53:02 swdev14 kernel:  [<c015b869>] vfs_write+0x100/0x134
Oct 12 09:53:02 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:02 swdev14 kernel:  [<c015b967>] sys_write+0x50/0x7a
Oct 12 09:53:02 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 09:53:02 swdev14 kernel: scheduling while atomic: mount/0x04010002/2732
Oct 12 09:53:02 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 09:53:02 swdev14 kernel:  [<c0299267>] schedule+0xbaf/0xbe2
Oct 12 09:53:02 swdev14 kernel:  [<c0299716>] cond_resched+0x63/0x83
Oct 12 09:53:02 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:53:02 swdev14 kernel:  [<c02996d9>] cond_resched+0x26/0x83
Oct 12 09:53:02 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:02 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:53:02 swdev14 kernel:  [<c02996d9>] cond_resched+0x26/0x83
Oct 12 09:53:02 swdev14 kernel:  [<c0299716>] cond_resched+0x63/0x83
Oct 12 09:53:02 swdev14 kernel:  [<c0133b8e>] _rw_mutex_read_lock+0x24/0x39
Oct 12 09:53:02 swdev14 kernel:  [<c011f8f1>] profile_hook+0x1d/0x47
Oct 12 09:53:02 swdev14 kernel:  [<c011fde3>] profile_tick+0x63/0x65
Oct 12 09:53:02 swdev14 kernel:  [<c0113d03>] smp_apic_timer_interrupt+0x60/0xe4
Oct 12 09:53:02 swdev14 kernel:  [<c0106bb6>] apic_timer_interrupt+0x1a/0x20
Oct 12 09:53:02 swdev14 kernel:  [<c011f0b2>] release_console_sem+0x59/0xcf
Oct 12 09:53:02 swdev14 kernel:  [<c011efb2>] vprintk+0x128/0x16f
Oct 12 09:53:02 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:02 swdev14 kernel:  [<c011ee86>] printk+0x1d/0x21
Oct 12 09:53:02 swdev14 kernel:  [<c0106edc>] show_trace+0x4e/0x8d
Oct 12 09:53:02 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:02 swdev14 kernel:  [<c0106fd9>] dump_stack+0x23/0x27
Oct 12 09:53:02 swdev14 kernel:  [<c0299267>] schedule+0xbaf/0xbe2
Oct 12 09:53:02 swdev14 kernel:  [<c0298496>] __down+0x8a/0x107
Oct 12 09:53:02 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:02 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:53:02 swdev14 kernel:  [<c01347
Oct 12 09:53:02 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:02 swdev14 kernel:  [<c0298496>] __down+0x8a/0x107
Oct 12 09:53:02 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 09:53:02 swdev14 kernel:  [<c029865c>] __down_failed+0x8/0xc
Oct 12 09:53:02 swdev14 kernel:  [<c0133ee3>] .text.lock.mutex+0x5/0x146
Oct 12 09:53:02 swdev14 kernel:  [<c0133884>] _mutex_lock_irqsave+0x16/0x1c
Oct 12 09:53:02 swdev14 kernel:  [<e0840abe>] boomerang_start_xmit+0x123/0x2eb [3c59x]
Oct 12 09:53:02 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:02 swdev14 kernel:  [<c029a2b8>] _spin_unlock+0xb/0x34
Oct 12 09:53:02 swdev14 kernel:  [<c02404f3>] qdisc_restart+0x132/0x1e6
Oct 12 09:53:02 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:02 swdev14 kernel:  [<c0240517>] qdisc_restart+0x156/0x1e6
Oct 12 09:53:02 swdev14 kernel:  [<c02313dd>] dev_queue_xmit+0x239/0x2d9
Oct 12 09:53:02 swdev14 kernel:  [<c024ecfa>] ip_finish_output+0xd5/0x216
Oct 12 09:53:02 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:02 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:02 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:02 swdev14 kernel:  [<c023bf2c>] nf_hook_slow+0xec/0x11e
Oct 12 09:53:02 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:02 swdev14 kernel:  [<c024f539>] ip_queue_xmit+0x495/0x59e
Oct 12 09:53:02 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:02 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:02 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:02 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:02 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:02 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:02 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:02 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:02 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:02 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:02 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:02 swdev14 kernel:  [<c025fbf1>] tcp_transmit_skb+0x432/0x852
Oct 12 09:53:02 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:02 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:02 swdev14 kernel:  [<c025fc9d>] tcp_transmit_skb+0x4de/0x852
Oct 12 09:53:02 swdev14 kernel:  [<c01b2056>] memcpy+0x12/0x3c
Oct 12 09:53:02 swdev14 kernel:  [<c0260a83>] tcp_write_xmit+0x149/0x2c0
Oct 12 09:53:02 swdev14 kernel:  [<c0254a8e>] tcp_sendmsg+0x4ff/0x108d
Oct 12 09:53:02 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:02 swdev14 kernel:  [<c0254a65>] tcp_sendmsg+0x4d6/0x108d
Oct 12 09:53:02 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:02 swdev14 last message repeated 2 times
Oct 12 09:53:02 swdev14 kernel:  [<c0227bda>] sock_aio_write+0x124/0x136
Oct 12 09:53:02 swdev14 kernel:  [<c02764e0>] inet_sendmsg+0x50/0x5b
Oct 12 09:53:02 swdev14 kernel:  [<c0227bda>] sock_aio_write+0x124/0x136
Oct 12 09:53:02 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:02 swdev14 kernel:  [<c015b73d>] do_sync_write+0xaa/0xd6
Oct 12 09:53:02 swdev14 kernel:  [<c01333e3>] autoremove_wake_function+0x0/0x57
Oct 12 09:53:03 swdev14 kernel:  [<c01a9bd8>] dummy_file_permission+0x8/0xc
Oct 12 09:53:03 swdev14 kernel:  [<c015b80b>] vfs_write+0xa2/0x134
Oct 12 09:53:03 swdev14 kernel:  [<c015b869>] vfs_write+0x100/0x134
Oct 12 09:53:03 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:03 swdev14 kernel:  [<c015b967>] sys_write+0x50/0x7a
Oct 12 09:53:03 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 09:53:03 swdev14 kernel: scheduling while atomic: mount/0x04010002/2732
Oct 12 09:53:03 swdev14 kernel: c0c>o4> [ou0c0/41c0r4d_xche> w_mu+pdo03>er i< ><4 c0t88>] cp1fd97
Oct 12 09:53:03 swdev14 kernel:  [<]49/0r136>p [m<4_sore+[7
Oct 12 09:53:03 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:03 swdev14 kernel:  [<c0298496>] __down+0x8a/0x107
Oct 12 09:53:03 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 09:53:03 swdev14 kernel:  [<c029865c>] __down_failed+0x8/0xc
Oct 12 09:53:03 swdev14 kernel:  [<c0133ee3>] .text.lock.mutex+0x5/0x146
Oct 12 09:53:03 swdev14 kernel:  [<c0133884>] _mutex_lock_irqsave+0x16/0x1c
Oct 12 09:53:03 swdev14 kernel:  [<e0840abe>] boomerang_start_xmit+0x123/0x2eb [3c59x]
Oct 12 09:53:03 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:03 swdev14 kernel:  [<c029a2b8>] _spin_unlock+0xb/0x34
Oct 12 09:53:03 swdev14 kernel:  [<c02404f3>] qdisc_restart+0x132/0x1e6
Oct 12 09:53:03 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:03 swdev14 kernel:  [<c0240517>] qdisc_restart+0x156/0x1e6
Oct 12 09:53:03 swdev14 kernel:  [<c02313dd>] dev_queue_xmit+0x239/0x2d9
Oct 12 09:53:03 swdev14 kernel:  [<c024ecfa>] ip_finish_output+0xd5/0x216
Oct 12 09:53:03 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:03 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:03 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:03 swdev14 kernel:  [<c023bf2c>] nf_hook_slow+0xec/0x11e
Oct 12 09:53:03 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:03 swdev14 kernel:  [<c024f539>] ip_queue_xmit+0x495/0x59e
Oct 12 09:53:03 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:03 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:03 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:03 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:03 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:03 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:03 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:03 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:03 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:03 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:03 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:03 swdev14 kernel:  [<c025fbf1>] tcp_transmit_skb+0x432/0x852
Oct 12 09:53:03 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:03 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:03 swdev14 kernel:  [<c025fc9d>] tcp_transmit_skb+0x4de/0x852
Oct 12 09:53:03 swdev14 kernel:  [<c01b2056>] memcpy+0x12/0x3c
Oct 12 09:53:03 swdev14 kernel:  [<c0260a83>] tcp_write_xmit+0x149/0x2c0
Oct 12 09:53:03 swdev14 kernel:  [<c0254a8e>] tcp_sendmsg+0x4ff/0x108d
Oct 12 09:53:03 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:03 swdev14 kernel:  [<c0254sg4at<4 97
Oct 12 09:53:03 swdev14 kernel: >]97a6>xde+0>0c0xc_wx0mmi5e  p<c01tra88>] checkpt_x
Oct 12 09:53:03 swdev14 kernel:  [<] s96/0x1pr19936>]pt_> [<mc<4> _spore+0x[<07
Oct 12 09:53:03 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:03 swdev14 kernel:  [<c0298496>] __down+0x8a/0x107
Oct 12 09:53:03 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 09:53:03 swdev14 kernel:  [<c029865c>] __down_failed+0x8/0xc
Oct 12 09:53:03 swdev14 kernel:  [<c0133ee3>] .text.lock.mutex+0x5/0x146
Oct 12 09:53:03 swdev14 kernel:  [<c0133884>] _mutex_lock_irqsave+0x16/0x1c
Oct 12 09:53:03 swdev14 kernel:  [<e0840abe>] boomerang_start_xmit+0x123/0x2eb [3c59x]
Oct 12 09:53:03 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:03 swdev14 kernel:  [<c029a2b8>] _spin_unlock+0xb/0x34
Oct 12 09:53:03 swdev14 kernel:  [<c02404f3>] qdisc_restart+0x132/0x1e6
Oct 12 09:53:03 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:03 swdev14 kernel:  [<c0240517>] qdisc_restart+0x156/0x1e6
Oct 12 09:53:03 swdev14 kernel:  [<c02313dd>] dev_queue_xmit+0x239/0x2d9
Oct 12 09:53:03 swdev14 kernel:  [<c024ecfa>] ip_finish_output+0xd5/0x216
Oct 12 09:53:03 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:03 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:03 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:03 swdev14 kernel:  [<c023bf2c>] nf_hook_slow+0xec/0x11e
Oct 12 09:53:03 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:03 swdev14 kernel:  [<c024f539>] ip_queue_xmit+0x495/0x59e
Oct 12 09:53:03 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:03 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:03 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:03 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:03 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:03 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:03 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:03 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:03 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:03 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:03 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:03 swdev14 kernel:  [<c025fbf1>] tcp_transmit_skb+0x432/0x852
Oct 12 09:53:03 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:03 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:03 swdev14 kernel:  [<c025fc9d>] tcp_transmit_skb+0x4de/0x852
Oct 12 09:53:03 swdev14 kernel:  [<c01b2056>] memcpy+0x12/0x3c
Oct 12 09:53:03 swdev14 kernel:  [<c0260a83>] tcp_write_xmit+0x149/0x2c0
Oct 12 09:53:03 swdev14 kernel:  [<c0254a8e>] tcp_sendmsg+0x4ff/0x108d
Oct 12 09:53:03 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:03 swdev14 kernel:  [<c0254a65>] tcp_sendmsg+0x4d6/0x108d
Oct 12 09:53:03 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:03 swdev14 last message repeated 2 times
Oct 12 09:53:03 swdev14 kernel:  [<c0227bda>] sock_aio_write+0x124/0x136
Oct 12 09:53:03 swdev14 kernel:  [<c02764e0>] inet_sendmsg+0x50/0x5b
Oct 12 09:53:03 swdev14 kernel:  [<c0227bda>] sock_aio_write+0x124/0x136
Oct 12 09:53:03 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:03 swdev14 kernel:  [<c015b73d>] do_sync_write+0xaa/0xd6
Oct 12 09:53:03 swdev14 kernel:  [<c01333e3>] autoremove_wake_function+0x0/0x57
Oct 12 09:53:03 swdev14 kernel:  [<c01a9bd8>] dummy_file_permission+0x8/0xc
Oct 12 09:53:03 swdev14 kernel:  [<c015b80b>] vfs_write+0xa2/0x134
Oct 12 09:53:03 swdev14 kernel:  [<c015b869>] vfs_write+0x100/0x134
Oct 12 09:53:03 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:03 swdev14 kernel:  [<c015b967>] sys_write+0x50/0x7a
Oct 12 09:53:03 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 09:53:03 swdev14 kernel: scheduling while atomic: mount/0x04010002/2732
Oct 12 09:53:04 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 09:53:04 swdev14 kernel:  [<c0299267>] schedule+0xbaf/0xbe2
Oct 12 09:53:04 swdev14 kernel:  [<c0299716>] cond_resched+0x63/0x83
Oct 12 09:53:04 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:53:04 swdev14 kernel:  [<c02996d9>] cond_resched+0x26/0x83
Oct 12 09:53:04 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:04 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:53:04 swdev14 kernel:  [<c02996d9>] cond_resched+0x26/0x83
Oct 12 09:53:04 swdev14 kernel:  [<c0299716>] cond_resched+0x63/0x83
Oct 12 09:53:04 swdev14 kernel:  [<c0133b8e>] _rw_mutex_read_lock+0x24/0x39
Oct 12 09:53:04 swdev14 kernel:  [<c011f8f1>] profile_hook+0x1d/0x47
Oct 12 09:53:04 swdev14 kernel:  [ro0x603>] er_> [<ic_
Oct 12 09:53:04 swdev14 kernel:  recf>] <c013488_pr<4>  pr<c010tra888>] check_pt_x1f9d9>
Oct 12 09:53:04 swdev14 kernel:  [<c029926] s496/0xr19136>] pt [<mco<4> _spre+0xb[<7
Oct 12 09:53:04 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x1] dunc[<cwn_<c013.lo338ck_> [omec514dc0unl02404f3>] qest[<c0nt56/0>] de+0xecfa>outdst_oux2f4/0x18148
Oct 12 09:53:04 swdev14 kernel: <4 nf_11e
Oct 12 09:53:04 swdev14 kernel: 4>] 0x239>[<out>] suuntsub_pree+0xpin_unlox34 subt+0pre2/0a2c7ck+134eemp29a2clocc013nt+265end
Oct 12 09:53:04 swdev14 kernel: <4 tcp [unttcp_v4_s+0x5fmit>x3c>] +0x<c025sen8d
Oct 12 09:53:04 swdev14 kernel: ] a65>] t+0x34mpt13emp34apt_ciox1]x50>e+040x13d>] e+0>] aue_fritcri<4> [<mc<cwri1061_pa3>scle 2/27is /0267> ond0pre
Oct 12 09:53:04 swdev14 kernel: <] c [<ck_
Oct 12 09:53:04 swdev14 kernel: <4con<4> [<c_r0c0/fde
Oct 12 09:53:04 swdev14 kernel: < smter4
Oct 12 09:53:04 swdev14 kernel: <er_in/0_con9/efb2>]12cheing1e1d6edce+08>] _ti106fck] 0xb+0x8a/[<ctimi9
Oct 12 09:53:04 swdev14 kernel: _pr0x4__mcount+0x1
Oct 12 09:53:04 swdev14 kernel: <] _sqre0298491>] __+0x+0<c04de+0x0/029+0x01ck.46
Oct 12 09:53:04 swdev14 kernel: mutexve] boomerang_start_xmit+0x123/0x2eb [3c59x]
Oct 12 09:53:04 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:04 swdev14 kernel:  [<c029a2b8>] _spin_unlock+0xb/0x34
Oct 12 09:53:04 swdev14 kernel:  [<c02404f3>] qdisc_restart+0x132/0x1e6
Oct 12 09:53:04 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:04 swdev14 kernel:  [<c0240517>] qdisc_restart+0x156/0x1e6
Oct 12 09:53:04 swdev14 kernel:  [<c02313dd>] dev_queue_xmit+0x239/0x2d9
Oct 12 09:53:04 swdev14 kernel:  [<c024ecfa>] ip_finish_output+0xd5/0x216
Oct 12 09:53:04 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:04 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:04 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:04 swdev14 kernel:  [<c023bf2c>] nf_hook_slow+0xec/0x11e
Oct 12 09:53:04 swdev14 kernel:  [<cg[<nt4sgat<4 s7
Oct 12 09:53:04 swdev14 kernel: <>97a>6>]0xdte+0>0c00xce_wx0mi15e /0n[<x01xd0>+0c4>o> [ouc6/481cr46d_xhed>_mu+pd/ro03>e i< c>]c01_p
Oct 12 09:53:04 swdev14 kernel: <4 <c0tr81fd9
Oct 12 09:53:04 swdev14 kernel:  [<]9/0r1936pt [m4>_re+[<7
Oct 12 09:53:04 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:04 swdev14 kernel:  [<c0298496>] __down+0x8a/0x107
Oct 12 09:53:04 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 09:53:04 swdev14 kernel:  [<c029865c>] __down_failed+0x8/0xc
Oct 12 09:53:04 swdev14 kernel:  [<c0133ee3>] .text.lock.mutex+0x5/0x146
Oct 12 09:53:04 swdev14 kernel:  [<c0133884>] _mutex_lock_irqsave+0x16/0x1c
Oct 12 09:53:04 swdev14 kernel:  [<e0840abe>] boomerang_start_xmit+0x123/0x2eb [3c59x]
Oct 12 09:53:04 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:04 swdev14 kernel:  [<c029a2b8>] _spin_unlock+0xb/0x34
Oct 12 09:53:04 swdev14 kernel:  [<c02404f3>] qdisc_restart+0x132/0x1e6
Oct 12 09:53:04 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:04 swdev14 kernel:  [<c0240517>] qdisc_restart+0x156/0x1e6
Oct 12 09:53:04 swdev14 kernel:  [<c02313dd>] dev_queue_xmit+0x239/0x2d9
Oct 12 09:53:04 swdev14 kernel:  [<c024ecfa>] ip_finish_output+0xd5/0x216
Oct 12 09:53:04 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:04 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:04 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:04 swdev14 kernel:  [<c023bf2c>] nf_hook_slow+0xec/0x11e
Oct 12 09:53:04 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:04 swdev14 kernel:  [<c024f539>] ip_queue_xmit+0x495/0x59e
Oct 12 09:53:04 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:04 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:04 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:04 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:04 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:04 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:04 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:04 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:04 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:04 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:04 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:04 swdev14 kernel:  [<c025fbf1>] tcp_transmit_skb+0x432/0x852
Oct 12 09:53:04 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:04 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:04 swdev14 kernel:  [<c025fc9d>] tcp_transmit_skb+0x4de/0x852
Oct 12 09:53:04 swdev14 kernel:  [<c01b2056>] memcpy+0x12/0x3c
Oct 12 09:53:04 swdev14 kernel:  [<c0260a83>] tcp_write_xmit+0x149/0x2c0
Oct 12 09:53:04 swdev14 kernel:  [<c0254a8e>] tcp_sendmsg+0x4ff/0x108d
Oct 12 09:53:04 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:04 swdev14 kernel:  [<c0254a65>] tcp_sendmsg+at<4 7
Oct 12 09:53:04 swdev14 kernel: <>x97a>6>xde+0>0c0xc_wx0ummio15e v/t[<x00xdx0>cc04>o4> [ou0c02/41cr4d_x8che>w_mu+pd/o> [<ic_
Oct 12 09:53:04 swdev14 kernel:  rec>]c01348_pre<4>  pr<c01tra88>] checkptx1f9d9>7
Oct 12 09:53:04 swdev14 kernel:  [<c02992] s49/0x10r191936>]pt [mc4>_re+[<07
Oct 12 09:53:04 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:04 swdev14 kernel:  [<c0298496>] __down+0x8a/0x107
Oct 12 09:53:04 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 09:53:04 swdev14 kernel:  [<c029865c>] __down_failed+0x8/0xc
Oct 12 09:53:04 swdev14 kernel:  [<c0133ee3>] .text.lock.mutex+0x5/0x146
Oct 12 09:53:04 swdev14 kernel:  [<c0133884>] _mutex_lock_irqsave+0x16/0x1c
Oct 12 09:53:04 swdev14 kernel:  [<e0840abe>] boomerang_start_xmit+0x123/0x2eb [3c59x]
Oct 12 09:53:04 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:04 swdev14 kernel:  [<c029a2b8>] _spin_unlock+0xb/0x34
Oct 12 09:53:04 swdev14 kernel:  [<c02404f3>] qdisc_restart+0x132/0x1e6
Oct 12 09:53:04 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:04 swdev14 kernel:  [<c0240517>] qdisc_restart+0x156/0x1e6
Oct 12 09:53:04 swdev14 kernel:  [<c02313dd>] dev_queue_xmit+0x239/0x2d9
Oct 12 09:53:04 swdev14 kernel:  [<c024ecfa>] ip_finish_output+0xd5/0x216
Oct 12 09:53:04 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:04 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:04 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:04 swdev14 kernel:  [<c023bf2c>] nf_hook_slow+0xec/0x11e
Oct 12 09:53:04 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:04 swdev14 kernel:  [<c024f539>] ip_queue_xmit+0x495/0x59e
Oct 12 09:53:04 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:04 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:04 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:04 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:04 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:05 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:05 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:05 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:05 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:05 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:05 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:05 swdev14 kernel:  [<c025fbf1>] tcp_transmit_skb+0x432/0x852
Oct 12 09:53:05 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:05 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:05 swdev14 kernel:  [<c025fc9d>] tcp_transmit_skb+0x4de/0x852
Oct 12 09:53:05 swdev14 kernel:  [<c01b2056>] memcpy+0x12/0x3c
Oct 12 09:53:05 swdev14 kernel:  [<c0260a83>] tcp_write_xmit+0x149/0x2c0
Oct 12 09:53:05 swdev14 kernel:  [<c0254a8e>] tcp_sendmsg+0x4ff/0x108d
Oct 12 09:53:05 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:05 swdev14 kernel:  [<c0254a65>] tcp_sgat<4> s97
Oct 12 09:53:05 swdev14 kernel: <>]97a>]6>xde+0> 0c00xc0mi5e] v/t[x010xd0>0c0>o> [o0c02/4x1cr46d_xched> _mut+pd/o03>er ic
Oct 12 09:53:05 swdev14 kernel: < f>c013_p<4 <c0t88>] cpx1d9
Oct 12 09:53:05 swdev14 kernel:  [<c]9/0136>p [mc4_sre+[7
Oct 12 09:53:05 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:05 swdev14 kernel:  [<c0298496>] __down+0x8a/0x107
Oct 12 09:53:05 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 09:53:05 swdev14 kernel:  [<c029865c>] __down_failed+0x8/0xc
Oct 12 09:53:05 swdev14 kernel:  [<c0133ee3>] .text.lock.mutex+0x5/0x146
Oct 12 09:53:05 swdev14 kernel:  [<c0133884>] _mutex_lock_irqsave+0x16/0x1c
Oct 12 09:53:05 swdev14 kernel:  [<e0840abe>] boomerang_start_xmit+0x123/0x2eb [3c5<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:05 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:05 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:05 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:05 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:05 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:05 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:05 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:05 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:05 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:05 swdev14 kernel:  [<c025fbf1>] tcp_transmit_skb+0x432/0x852
Oct 12 09:53:05 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:05 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:05 swdev14 kernel:  [<c025fc9d>] tcp_transmit_skb+0x4de/0x852
Oct 12 09:53:05 swdev14 kernel:  [<c01b2056>] memcpy+0x12/0x3c
Oct 12 09:53:05 swdev14 kernel:  [<c0260a83>] tcp_write_xmit+0x149/0x2c0
Oct 12 09:53:05 swdev14 kernel:  [<c0254a8e>] tcp_sendmsg+0x4ff/0x108d
Oct 12 09:53:05 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:05 swdev14 kernel:  [<c0254a65>] tcp_sendmsg+0x4d6/0x108d
Oct 12 09:53:05 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:05 swdev14 last message repeated 2 times
Oct 12 09:53:05 swdev14 kernel:  [<c0227bda>] sock_aio_write+0x124/0x136
Oct 12 09:53:05 swdev14 kernel:  [<c02764e0>] inet_sendmsg+0x50/0x5b
Oct 12 09:53:05 swdev14 kernel:  [<c0227bda>] sock_aio_write+0x124/0x136
Oct 12 09:53:05 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:05 swdev14 kernel:  [<c015b73d>] do_sync_write+0xaa/0xd6
Oct 12 09:53:05 swdev14 kernel:  [<c01333e3>] autoremove_wake_function+0x0/0x57
Oct 12 09:53:05 swdev14 kernel:  [<c01a9bd8>] dummy_file_permission+0x8/0xc
Oct 12 09:53:05 swdev14 kernel:  [<c015b80b>] vfs_write+0xa2/0x134
Oct 12 09:53:05 swdev14 kernel:  [<c015b869>] vfs_write+0x100/0x134
Oct 12 09:53:05 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:05 swdev14 kernel:  [<c015b967>] sys_write+0x50/0x7a
Oct 12 09:53:05 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 09:53:05 swdev14 kernel: scheduling while atomic: mount/0x04010002/2732
Oct 12 09:53:05 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 09:53:05 swdev14 kernel:  [<c0299267>] schedule+0xbaf/0xbe2
Oct 12 09:53:05 swdev14 kernel:  [<c0299716>] cond_resched+0x63/0x83
Oct 12 09:53:05 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:53:05 swdev14 kernel:  [<c02996d9>] cond_resched+0x26/0x83
Oct 12 09:53:05 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:05 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:53:05 swdev14 kernel:  [<c02996d9>] cond_resched+0x26/0x83
Oct 12 09:53:05 swdev14 kernel:  [<c0299716>] cond_resched+0x63/0x83
Oct 12 09:53:05 swdev14 kernel:  [<c0133b8e>] _rw_mutex_read_lock+0x24/0x39
Oct 12 09:53:05 swdev14 kernel:  [<c011f8f1>] profile_hook+0x1d/0x47
Oct 12 09:53:05 swdev14 kernel:  [<c011fde3>] profile_tick+0x63/0x65
Oct 12 09:53:05 swdev14 kernel:  [<c0113d03>] smp_apic_timer_interrupt+0x60/0xe4
Oct 12 09:53:05 swdev14 kernel:  [<c0106bb6>] apic_timer_interrupt+0x1a/0x20
Oct 12 09:53:05 swdev14 kernel:  [<c011f0b2>] release_console_sem+0x59/0xcf
Oct 12 09:53:05 swdev14 kernel:  [<c011efb2>] vprintk+0x128/0x16f
Oct 12 09:53:05 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:05 swdev14 kernel:  [<c011ee86>] printk+0x1d/0x21
Oct 12 09:53:05 swdev14 kernel:  [<c0106edc>] show_trace+0x4e/0x8d
Oct 12 09:53:05 swdev14 kernel: 134g+0 [<k+<c0<4__c01348_p91134ng[<21>] rqre6
Oct 12 09:53:05 swdev14 kernel: x85/001> [<cdo> [<cef1c
Oct 12 09:53:05 swdev14 kernel: >] <4.te0x5/001save> [rt_xeb _1
Oct 12 09:53:05 swdev14 kernel: ck+0xb/[<c0x132<c/0x15171e6
Oct 12 09:53:05 swdev14 kernel:  [<dd>it+0> [_output+0xd5/6
Oct 12 09:53:05 swdev14 kernel: </06d402pu023bf_s<c02ut> [<_q9e<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:05 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:05 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:05 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:05 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:05 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:05 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:05 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:05 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:05 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:05 swdev14 kernel:  [<c025fbf1>] tcp_transmit_skb+0x432/0x852
Oct 12 09:53:05 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:05 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:05 swdev14 kernel:  [<c025fc9d>] tcp_transmit_skb+0x4de/0x852
Oct 12 09:53:05 swdev14 kernel:  [<c01b2056>] memcpy+0x12/0x3c
Oct 12 09:53:05 swdev14 kernel:  [<c0260a83>] tcp_write_xmit+0x149/0x2c0
Oct 12 09:53:05 swdev14 kernel:  [<c0254a8e>] tcp_sendmsg+0x4ff/0x108d
Oct 12 09:53:05 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:05 swdev14 kernel:  [<c0254a65>] tcp_sendmsg+0x4d6/0x108d
Oct 12 09:53:05 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:05 swdev14 last message repeated 2 times
Oct 12 09:53:05 swdev14 kernel:  [<c0227bda>] sock_aio_write+0x124/0x136
Oct 12 09:53:05 swdev14 kernel:  [<c02764e0>] inet_sendmsg+0x50/0x5b
Oct 12 09:53:05 swdev14 kernel:  [<c0227bda>] sock_aio_write+0x124/0x136
Oct 12 09:53:05 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:05 swdev14 kernel:  [<c015b73d>] do_sync_write+0xaa/0xd6
Oct 12 09:53:05 swdev14 kernel:  [<c01333e3>] autoremove_wake_function+0x0/0x57
Oct 12 09:53:05 swdev14 kernel:  [<c01a9bd8>] dummy_file_permission+0x8/0xc
Oct 12 09:53:05 swdev14 kernel:  [<c015b80b>] vfs_write+0xa2/0x134
Oct 12 09:53:05 swdev14 kernel:  [<c015b869>] vfs_write+0x100/0x134
Oct 12 09:53:05 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:05 swdev14 kernel:  [<c015b967>] sys_write+0x50/0x7a
Oct 12 09:53:05 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 09:53:05 swdev14 kernel: scheduling while atomic: mount/0x04010002/2732
Oct 12 09:53:05 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 09:53:05 swdev14 kernel:  [<c0299267>] schedule+0xbaf/0xbe2
Oct 12 09:53:05 swdev14 kernel:  [<c0299716>] cond_resched+0x63/0x83
Oct 12 09:53:06 swdev14 kernel:  [<c0134936>] touch_preempt_ti0x9 _spina/0] chimi
Oct 12 09:53:06 swdev14 kernel:  _s34
Oct 12 09:53:06 swdev14 kernel: <4d><c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:06 swdev14 kernel:  [<c025fbf1>] tcp_transmit_skb+0x432/0x852
Oct 12 09:53:06 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:06 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:06 swdev14 kernel:  [<c025fc9d>] tcp_transmit_skb+0x4de/0x852
Oct 12 09:53:06 swdev14 kernel:  [<c01b2056>] memcpy+0x12/0x3c
Oct 12 09:53:06 swdev14 kernel:  [<c0260a83>] tcp_write_xmit+0x149/0x2c0
Oct 12 09:53:06 swdev14 kernel:  [<c0254a8e>] tcp_sendmsg+0x4ff/0x108d
Oct 12 09:53:06 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:06 swdev14 kernel:  [<c0254a65>] tcp_sendmsg+0x4d6/0x108d
Oct 12 09:53:06 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:06 swdev14 last message repeated 2 times
Oct 12 09:53:06 swdev14 kernel:  [<c0227bda>] sock_aio_write+0x124/0x136
Oct 12 09:53:06 swdev14 kernel:  [<c02764e0>] inet_sendmsg+0x50/0x5b
Oct 12 09:53:06 swdev14 kernel:  [<c0227bda>] sock_aio_write+0x124/0x136
Oct 12 09:53:06 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:06 swdev14 kernel:  [<c015b73d>] do_sync_write+0xaa/0xd6
Oct 12 09:53:06 swdev14 kernel:  [<c01333e3>] autoremove_wake_function+0x0/0x57
Oct 12 09:53:06 swdev14 kernel:  [<c01a9bd8>] dummy_file_permission+0x8/0xc
Oct 12 09:53:06 swdev14 kernel:  [<c015b80b>] vfs_write+0xa2/0x134
Oct 12 09:53:06 swdev14 kernel:  [<c015b869>] vfs_write+0x100/0x134
Oct 12 09:53:06 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:06 swdev14 kernel:  [<c015b967>] sys_write+0x50/0x7a
Oct 12 09:53:06 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 09:53:06 swdev14 kernel: scheduling while atomic: mount/0x04010002/2732
Oct 12 09:53:06 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 09:53:06 swdev14 kernel:  [<c0299267>] schedule+0xbaf/0xbe2
Oct 12 09:53:06 swdev14 kernel:  [<c0299716>] cond_resched+0x63/0x83
Oct 12 09:53:06 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:53:06 swdev14 kernel:  [<c02996d9>] cond_resched+0x26/0x83
Oct 12 09:53:06 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:06 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:53:06 swdev14 kernel:  [<c02996d9>] cond_resched+0x26/0x83
Oct 12 09:53:06 swdev14 kernel:  [<c0299716>] cond_resched+0x63/0x83
Oct 12 09:53:06 swdev14 kernel:  [<c0133b8e>] _rw_mutex_read_lock+0x24/0x39
Oct 12 09:53:06 swdev14 kernel:  [<c011f8f1>] profile_hook+0x1d/0x47
Oct 12 09:53:06 swdev14 kernel:  [<c011fde3>] profile_tick+0x63/0x65
Oct 12 09:53:06 swdev14 kernel:  [<c0113d03>] smp_apic_timer_interrupt+0x60/0xe4
Oct 12 09:53:06 swdev14 kernel:  [<c0106bb6>] apic_timer_interrupt+0x1a/0x20
Oct 12 09:53:06 swdev14 kernel:  [<c011f0b2>] release_console_sem+0x59/0xcf
Oct 12 09:53:06 swdev14 kernel:  [<c011efb2>] vprintk+0x128/0x16f
Oct 12 09:53:06 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:06 swdev14 kernel:  [<c011ee86>] printk+0x1d/0x21
Oct 12 09:53:06 swdev14 kernel:  [<c0106edc>] show_trace+0x4e/0x8d
Oct 12 09:53:06 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:06 swdev14 kernel:  [<c0106fd9>] dump_stack+0x23/0x27
Oct 12 09:53:06 swdev14 kernel:  [<c0299267>] schedule+0xbaf/0xbe2
Oct 12 09:53:06 swdev14 kernel:  [<c0298496>] __down+0x8a/0x107
Oct 12 09:53:06 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:06 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:53:06 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:06 swdev14 kernel:  [<c029a358>] _spin_unlock_irqrestore+0xb/0x36
Oct 12 09:53:06 swdev14 kernel:  [<c0298491>] __down+0x85/0x107
Oct 12 09:53:06 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:06 swdev14 kernel:  [<c0298496>] __down+0x8a/0x107
Oct 12 09:53:06 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 09:53:06 swdev14 kernel:  [<c029865c>] __down_failed+0x8/0xc
Oct 12 09:53:06 swdev14 kernel:  [<c0133ee3>] .text.lock.mutex+0x5/0x146
Oct 12 09:53:06 swdev14 kernel:  [<c0133884>] _mutex_lock_irqsave+0x16/0x1c
Oct 12 09:53:06 swdev14 kernel:  [<e0840abe>] boomerang_start_xmit+0x123/0x2eb [3c59x]
Oct 12 09:53:06 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:06 swdev14 kernel:  [<c029a2b8>] _spin_unlock+0xb/0x34
Oct 12 09:53:06 swdev14 kernel:  [<c02404f3>] qdisc_restart+0x132/0x1e6
Oct 12 09:53:06 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:06 swdev14 kernel:  [<c0240517>] qdisc_restart+0x156/0x1e6
Oct 12 09:53:06 swdev14 kernel:  [<c02313dd>] dev_queue_xmit+0x239/0x2d9
Oct 12 09:53:06 swdev14 kernel:  [<c024ecfa>] ip_finish_output+0xd5/0x216
Oct 12 09:53:06 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:06 swdev14 kernel:  [<c01136d4>] mco[<c_obfow+while atfti<c02 i83
Oct 12 09:53:06 swdev14 kernel: t+0 schedule+0xxbe<4>t+0>]
Oct 12 09:53:06 swdev14 kernel:  cond_resed+out<c0ti[<cpreem2/0> co26/1>]
Oct 12 09:53:06 swdev14 kernel: pt<c0134<cing+0x191/0x1f9 _spin_unlock+0x1a/0x34
Oct 12 09:53:06 swdev14 kernel: 
Oct 12 09:53:06 swdev14 kernel:  [<c0134936>] [<c0134af1>] touch_preempt_timing+0x46/0x4a sub_preempt_count+0x82/0x97
Oct 12 09:53:06 swdev14 kernel: 
Oct 12 09:53:06 swdev14 kernel:  [<c02996d9>] [<c0134af1>] cond_resched+0x26/0x83 sub_preempt_count+0x82/0x97
Oct 12 09:53:06 swdev14 kernel: 
Oct 12 09:53:06 swdev14 kernel:  [<c029a2c7>] [<c0299716>] _spin_unlock+0x1a/0x34 cond_resched+0x63/0x83
Oct 12 09:53:06 swdev14 kernel: 
Oct 12 09:53:06 swdev14 kernel:  [<c0134888>] [<c0133b8e>] check_preempt_timing+0x191/0x1f9 _rw_mutex_read_lock+0x24/0x39
Oct 12 09:53:06 swdev14 kernel: 
Oct 12 09:53:06 swdev14 kernel:  [<c029a2c7>] [<c011f8f1>] _spin_unlock+0x1a/0x34 profile_hook+0x1d/0x47
Oct 12 09:53:06 swdev14 kernel: 
Oct 12 09:53:06 swdev14 kernel:  [<c013414d>] [<c011fde3>] __mcount+0x1d/0x21 profile_tick+0x63/0x65
Oct 12 09:53:06 swdev14 kernel: 
Oct 12 09:53:06 swdev14 kernel:  [<c0265d8c>] [<c0113d03>] tcp_v4_send_check+0xe/0xe2 smp_apic_timer_interrupt+0x60/0xe4
Oct 12 09:53:06 swdev14 kernel: 
Oct 12 09:53:06 swdev14 kernel:  [<c025fbf1>] [<c0106bb6>] tcp_transmit_skb+0x432/0x852 apic_timer_interrupt+0x1a/0x20
Oct 12 09:53:06 swdev14 kernel: 
Oct 12 09:53:06 swdev14 kernel:  [<c01136d4>] [<c029007b>] mcount+0x14/0x18 packet_sendmsg+0x210/0x280
Oct 12 09:53:06 swdev14 kernel: 
Oct 12 09:53:06 swdev14 kernel:  [<c0265d8c>] [<c0299fdb>] tcp_v4_send_check+0xe/0xe2 _spin_lock+0x56/0x78
Oct 12 09:53:06 swdev14 kernel: 
Oct 12 09:53:06 swdev14 kernel:  [<c025fc9d>] [<c02405a7>] tcp_transmit_skb+0x4de/0x852 dev_watchdog+0x0/0xb7
Oct 12 09:53:06 swdev14 kernel: 
Oct 12 09:53:06 swdev14 kernel:  [<c01b2056>] [<c02405c3>] memcpy+x2eb [3c59x]
Oct 12 09:53:06 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:06 swdev14 kernel:  [<c029a2b8>] _spin_unlock+0xb/0x34
Oct 12 09:53:06 swdev14 kernel:  [<c02404f3>] qdisc_restart+0x132/0x1e6
Oct 12 09:53:06 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:06 swdev14 kernel:  [<c0240517>] qdisc_restart+0x156/0x1e6
Oct 12 09:53:06 swdev14 kernel:  [<c02313dd>] dev_queue_xmit+0x239/0x2d9
Oct 12 09:53:06 swdev14 kernel:  [<c024ecfa>] ip_finish_output+0xd5/0x216
Oct 12 09:53:06 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:06 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:06 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:06 swdev14 kernel:  [<c023bf2c>] nf_hook_slow+0xec/0x11e
Oct 12 09:53:06 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:06 swdev14 kernel:  [<c024f539>] ip_queue_xmit+0x495/0x59e
Oct 12 09:53:06 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:06 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:06 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:06 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:06 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:06 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:06 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:06 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:06 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:06 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:07 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:07 swdev14 kernel:  [<c025fbf1>] tcp_transmit_skb+0x432/0x852
Oct 12 09:53:07 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:07 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:07 swdev14 kernel:  [<c025fc9d>] tcp_transmit_skb+0x4de/0x852
Oct 12 09:53:07 swdev14 kernel:  [<c01b2056>] memcpy+0x12/0x3c
Oct 12 09:53:07 swdev14 kernel:  [<c0260a83>] tcp_write_xmit+0x149/0x2c0
Oct 12 09:53:07 swdev14 kernel:  [<c0254a8e>] tcp_sendmsg+0x4ff/0x108d
Oct 12 09:53:07 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:07 swdev14 kernel:  [<c0254a65>] tcp_sendmsg+0x4d6/0x108d
Oct 12 09:53:07 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:07 swdev14 last message repeated 2 times
Oct 12 09:53:07 swdev14 kernel:  [<c0227bda>] sock_aio_write+0x124/0x136
Oct 12 09:53:07 swdev14 kernel:  [<c02764e0>] inet_sendmsg+0x50/0x5b
Oct 12 09:53:07 swdev14 kernel:  [<c0227bda>] sock_aio_write+0x124/0x136
Oct 12 09:53:07 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:07 swdev14 kernel:  [<c015b73d>] do_sync_write+0xaa/0xd6
Oct 12 09:53:07 swdev14 kernel:  [<c01333e3>] autoremove_wake_function+0x0/0x57
Oct 12 09:53:07 swdev14 kernel:  [<c01a9bd8>] dummy_file_permission+0x8/0xc
Oct 12 09:53:07 swdev14 kernel:  [<c015b80b>] vfs_write+0xa2/0x134
Oct 12 09:53:07 swdev14 kernel:  [<c015b869>] vfs_write+0x100/0x134
Oct 12 09:53:07 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:07 swdev14 kernel:  [<c015b967>] sys_write+0x50/0x7a
Oct 12 09:53:07 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 09:53:07 swdev14 kernel: scheduling while atomic: mount/0x04010002/2732
Oct 12 09:53:07 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 09:53:07 swdev14 kernel:  [<c0299267>] schedule+0xbaf/0xbe2
Oct 12 09:53:07 swdev14 kernel:  [<c0299716>] cond_resched+0x63/0x83
Oct 12 09:53:07 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:53:07 swdev14 kernel:  [<c02996d9>] cond_resched+0x26/0x83
Oct 12 09:53:07 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:07 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:53:07 swdev14 kernel:  [<c02996d9>] cond_resched+0x26/0x83
Oct 12 09:53:07 swdev14 kernel:  [<c0299716>] cond_resched+0x63/0x83
Oct 12 09:53:07 swdev14 kernel:  [<c0133b8e>] _rw_mutex_read_lock+0x24/0x39
Oct 12 09:53:07 swdev14 kernel:  [<c011f8f1>] profile_hook+0x1d/0x47
Oct 12 09:53:07 swdev14 kernel:  [<c011fde3>] profile_tick+0x63/0x65
Oct 12 09:53:07 swdev14 kernel:  [<c0113d03>] smp_apic_timer_interrupt+0x60/0xe4
Oct 12 09:53:07 swdev14 kernel:  [<c0106bb6>] apic_timer_interrupt+0x1a/0x20
Oct 12 09:53:07 swdev14 kernel:  [<c011f0b2>] release_console_sem+0x59/0xcf
Oct 12 09:53:07 swdev14 kernel:  [<c011efb2>] vprintk+0x128/0x16f
Oct 12 09:53:07 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:07 swdev14 kernel:  [<c011ee86>] printk+0x1d/0x21
Oct 12 09:53:07 swdev14 kernel:  [<c0106edc>] show_trace+0x4e/0x8d
Oct 12 09:53:07 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:07 swdev14 kernel:  [<c0106fd9>] dump_stack+0x23/0x27
Oct 12 09:53:07 swdev14 kernel:  [<c0299267>] schedule+0xbaf/0xbe2
Oct 12 09:53:07 swdev14 kernel:  [<c0298496>] __down+0x8a/0x107
Oct 12 09:53:07 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:07 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:53:07 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:07 swdev14 kernel:  [<c029a358>] _spin_unlock_irqrestore+0xb/0x36
Oct 12 09:53:07 swdev14 kernel:  [<c0298491>] __down+0x85/0x107
Oct 12 09:53:07 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:07 swdev14 kernel:  [<c0298496>] __down+0x8a/0x107
Oct 12 09:53:07 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 09:53:07 swdev14 kernel:  [<c029865c>] __down_failed+0x8/0xc
Oct 12 09:53:07 swdev14 kernel:  [<c0133ee3>] .text.lock.mutex+0x5/0x146
Oct 12 09:53:07 swdev14 kernel:  [<c0133884>] _mutex_lock_irqsave+0x16/0x1c
Oct 12 09:53:07 swdev14 kernel:  [<e0840abe>] boomerang_start_xmit+0x123/0x2eb [3c59x]
Oct 12 09:53:07 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:07 swdev14 kernel:  [<c029a2b8>] _spin_unlock+0xb/0x34
Oct 12 09:53:07 swdev14 kernel:  [<c02404f3>] qdisc_restart+0x132/0x1e6
Oct 12 09:53:07 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:07 swdev14 kernel:  [<c0240517>] qdisc_restart+0x156/0x1e6
Oct 12 09:53:07 swdev14 kernel:  [<c02313dd>] dev_queue_xmit+0x239/0x2d9
Oct 12 09:53:07 swdev14 kernel:  [<c024ecfa>] ip_finish_output+0xd5/0x216
Oct 12 09:53:07 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:07 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:07 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:07 swdev14 kernel:  [<c023bf2c>] nf_hook_slow+0xec/0x11e
Oct 12 09:53:07 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:07 swdev14 kernel:  [<c024f539>] ip_queue_xmit+0x495/0x59e
Oct 12 09:53:07 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:07 swdev14 kernel:  [>] de+0xecfa>outpdst_ox2f4/0x18
Oct 12 09:53:07 swdev14 kernel: <148> [<c02_hoe
Oct 12 09:53:07 swdev14 kernel: <4] d539>it+> [t_o [<_pr134afmpt4> [spi
Oct 12 09:53:07 swdev14 kernel: +0x8c01/02c7> [<c0134eck0x<c04
Oct 12 09:53:07 swdev14 kernel: ] 1>] eck+0[<rans/0x14/0026che> [_skb<43c3>] 4a8g+0[<nt54sg+4at_c
Oct 12 09:53:07 swdev14 kernel:   su97
Oct 12 09:53:07 swdev14 kernel: >] x97
Oct 12 09:53:07 swdev14 kernel: <4a>36
Oct 12 09:53:07 swdev14 kernel: >] 0x5da>te+0x12> [0xc01+0xac01e_wakx0/ummyion15e+0] vf[<c0x500100x5dulx0>c+0xc02>on4> [<c0ouc+0c06/488x1c01pree46nd_rex8hed+0> w_mutex+0 prd/0ro0x603>] er_ [<ic_
Oct 12 09:53:07 swdev14 kernel:  rcf>]<c013488_pr
Oct 12 09:53:07 swdev14 kernel:   p<c010tra88>] check_pptx1f9d9>7
Oct 12 09:53:07 swdev14 kernel:  [<c0299267] s49/0xp36>]pt_> [<cmco4> _spiore+0xb[<07
Oct 12 09:53:07 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:07 swdev14 kernel:  [<c0298496>] __down+0x8a/0x107
Oct 12 09:53:07 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 09:53:07 swdev14 kernel:  [<c029865c>] __down_failed+0x8/0xc
Oct 12 09:53:07 swdev14 kernel:  [<c0133ee3>] .text.lock.mutex+0x5/0x146
Oct 12 09:53:07 swdev14 kernel:  [<c0133884>] _mutex_lock_irqsave+0x16/0x1c
Oct 12 09:53:07 swdev14 kernel:  [<e0840abe>] boomerang_start_xmit+0x123/0x2eb [3c59x]
Oct 12 09:53:07 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:07 swdev14 kernel:  [<c029a2b8>] _spin_unlock+0xb/0x34
Oct 12 09:53:07 swdev14 kernel:  [<c02404f3>] qdisc_restart+0x132/0x1e6
Oct 12 09:53:07 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:07 swdev14 kernel:  [<c0240517>] qdisc_restart+0x156/0x1e6
Oct 12 09:53:07 swdev14 kernel:  [<c02313dd>] dev_queue_xmit+0x239/0x2d9
Oct 12 09:53:07 swdev14 kernel:  [<c024ecfa>] ip_finish_output+0xd5/0x216
Oct 12 09:53:07 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:07 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:07 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:07 swdev14 kernel:  [<c023bf2c>] nf_hook_slow+0xec/0x11e
Oct 12 09:53:07 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:07 swdev14 kernel:  [<c024f539>] ip_queue_xmit+0x495/0x59e
Oct 12 09:53:07 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:07 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:07 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:07 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:08 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:08 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:08 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:08 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:08 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:08 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:08 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:08 swdev14 kernel:  [<c025fbf1>] tcp_transmit_skb+0x432/0x852
Oct 12 09:53:08 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:08 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:08 swdev14 kernel:  [<c025fc9d>] tcp_transmit_skb+0x4de/0x852
Oct 12 09:53:08 swdev14 kernel:  [<c01b2056>] memcpy+0x12/0x3c
Oct 12 09:53:08 swdev14 kernel:  [<c0260a83>] tcp_write_xmit+0x149/0x2c0
Oct 12 09:53:08 swdev14 kernel:  [<c0254a8e>] tcp_sendmsg+0x4ff/0x108d
Oct 12 09:53:08 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:08 swdev14 kernel:  [<c0254a65>] tcp_sendmsg+0x4d6/0x108d
Oct 12 09:53:08 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:08 swdev14 last message repeated 2 times
Oct 12 09:53:08 swdev14 kernel:  [<c0227bda>] sock_aio_write+0x124/0x136
Oct 12 09:53:08 swdev14 kernel:  [<c02764e0>] inet_sendmsg+0x50/0x5b
Oct 12 09:53:08 swdev14 kernel:  [<c0227bda>] sock_aio_write+0x124/0x136
Oct 12 09:53:08 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:08 swdev14 kernel:  [<c015b73d>] do_sync_write+0xaa/0xd6
Oct 12 09:53:08 swdev14 kernel:  [<c01333e3>] autoremove_wake_function+0x0/0x57
Oct 12 09:53:08 swdev14 kernel: ummyio15e+0] vf/0xnt[<0x50100x5dux0>c+0c02>on> [<c0ou0c026/48x1c01re46/nd_rex8ched+> _mute+0 pd/0o0x03>] er [ic
Oct 12 09:53:08 swdev14 kernel: <4 rcf>]<c0134_pr
Oct 12 09:53:08 swdev14 kernel:   p<c01tra88>] check_pt_1fd97
Oct 12 09:53:08 swdev14 kernel:  [<c029996/0xpr191936>]pt_> [<mc<4> _spore+0x[<7
Oct 12 09:53:08 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:08 swdev14 kernel:  [<c0298496>] __down+0x8a/0x107
Oct 12 09:53:08 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 09:53:08 swdev14 kernel:  [<c029865c>] __down_failed+0x8/0xc
Oct 12 09:53:08 swdev14 kernel:  [<c0133ee3>] .text.lock.mutex+0x5/0x146
Oct 12 09:53:08 swdev14 kernel:  [<c0133884>] _mutex_lock_irqsave+0x16/0x1c
Oct 12 09:53:08 swdev14 kernel:  [<e0840abe>] boomerang_start_xmit+0x123/0x2eb [3c59x]
Oct 12 09:53:08 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:08 swdev14 kernel:  [<c029a2b8>] _spin_unlock+0xb/0x34
Oct 12 09:53:08 swdev14 kernel:  [<c02404f3>] qdisc_restart+0x132/0x1e6
Oct 12 09:53:08 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:08 swdev14 kernel:  [<c0240517>] qdisc_restart+0x156/0x1e6
Oct 12 09:53:08 swdev14 kernel:  [<c02313dd>] dev_queue_xmit+0x239/0x2d9
Oct 12 09:53:08 swdev14 kernel:  [<c024ecfa>] ip_finish_output+0xd5/0x216
Oct 12 09:53:08 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:08 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:08 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:08 swdev14 kernel:  [<c023bf2c>] nf_hook_slow+0xec/0x11e
Oct 12 09:53:08 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:08 swdev14 kernel:  [<c024f539>] ip_queue_xmit+0x495/0x59e
Oct 12 09:53:08 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:08 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:08 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:08 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:08 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:08 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:08 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:08 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:08 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:08 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:08 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:08 swdev14 kernel:  [<c025fbf1>] tcp_transmit_skb+0x432/0x852
Oct 12 09:53:08 swdev14 kernel:  [<c01136d4>cp_transmit_skb+0x432/0x852
Oct 12 09:53:08 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:08 swdev14 kernel:  [<c0265d8c>] tcp_v4_send_check+0xe/0xe2
Oct 12 09:53:08 swdev14 kernel:  [<c025fc9d>] tcp_transmit_skb+0x4de/0x852
Oct 12 09:53:08 swdev14 kernel:  [<c01b2056>] memcpy+0x12/0x3c
Oct 12 09:53:08 swdev14 kernel:  [<c0260a83>] tcp_write_xmit+0x149/0x2c0
Oct 12 09:53:08 swdev14 kernel:  [<c0254a8e>] tcp_sendmsg+0x4ff/0x108d
Oct 12 09:53:08 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:08 swdev14 kernel:  [<c0254a65>] tcp_sendmsg+0x4d6/0x108d
Oct 12 09:53:08 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:08 swdev14 last message repeated 2 times
Oct 12 09:53:08 swdev14 kernel:  [<c0227bda>] sock_aio_write+0x124/0x136
Oct 12 09:53:08 swdev14 kernel:  [<c02764e0>] inet_sendmsg+0x50/0x5b
Oct 12 09:53:08 swdev14 kernel:  [<c0227bda>] sock_aio_write+0x124/0x136
Oct 12 09:53:08 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:08 swdev14 kernel:  [<c015b73d>] do_sync_write+0xaa/0xd6
Oct 12 09:53:08 swdev14 kernel:  [<c01333e3>] autoremove_wake_function+0x0/0x57
Oct 12 09:53:08 swdev14 kernel:  [<c01a9bd8>] dummy_file_permission+0x8/0xc
Oct 12 09:53:08 swdev14 kernel:  [<c015b80b>] vfs_write+0xa2/0x134
Oct 12 09:53:08 swdev14 kernel:  [<c015b869>] vfs_write+0x100/0x134
Oct 12 09:53:08 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:08 swdev14 kernel:  [<c015b967>] sys_write+0x50/0x7a
Oct 12 09:53:08 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 09:53:08 swdev14 kernel: scheduling while atomic: mount/0x04010002/2732
Oct 12 09:53:08 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 09:53:08 swdev14 kernel:  [<c0299267>] schedule+0xbaf/0xbe2
Oct 12 09:53:08 swdev14 kernel:  [<c0299716>] cond_resched+0x63/0x83
Oct 12 09:53:08 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:53:08 swdev14 kernel:  [<c02996d9>] cond_resched+0x26/0x83
Oct 12 09:53:08 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:08 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:53:08 swdev14 kernel:  [<c02996d9>] cond_resched+0x26/0x83
Oct 12 09:53:08 swdev14 kernel:  [<c0299716>] cond_resched+0x63/0x83
Oct 12 09:53:08 swdev14 kernel:  [<c0133b8e>] _rw_mutex_read_lock+0x24/0prx02> d91p[l>c.4av/p4> p> [/0x48e0x1a/023c/0x11514
Oct 12 09:53:08 swdev14 kernel:   i>st> b_p82/0134cou4> ock> [reem/0x_pre82/7+0xchecingc7+0x4d>d/0v4_/0ra/0 m
Oct 12 09:53:08 swdev14 kernel: <4ck<c0t_skb+0
Oct 12 09:53:08 swdev14 kernel: <4em4>i4>x4<c+0<c6/0x01x82/013pt_co97
Oct 12 09:53:08 swdev14 kernel: mpx97_a0xe0>]g+0>] m18
Oct 12 09:53:08 swdev14 kernel: wr4>ake_fun0x5_fil0x vfs0xrite+0x100/
Oct 12 09:53:08 swdev14 kernel: <4 mco
Oct 12 09:53:08 swdev14 kernel: <4ite+0x50/0x7a
Oct 12 09:53:08 swdev14 kernel:  [52/lin10lerx63/0299/0x99ed [<preemp46d_resched+0x26/0x83
Oct 12 09:53:08 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:08 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:53:08 swdev14 kernel:  [<c02996d9>] cond_resched+0x26/0x83
Oct 12 09:53:08 swdev14 kernel:  [<c0299716>] cond_resched+0x63/0x83
Oct 12 09:53:08 swdev14 kernel:  [<c0133b8e>] _rw_mutex_read_lock+0x24/0x39
Oct 12 09:53:08 swdev14 kernel:  [<c011f8f1>] profile_hook+0x1d/0x47
Oct 12 09:53:08 swdev14 kernel:  [<c011fde3>] profile_tick+0x63/0x65
Oct 12 09:53:08 swdev14 kernel:  [<c0113d03>] smp_apic_timer_interrupt+0x60/0xe4
Oct 12 09:53:08 swdev14 kernel:  [<c0106bb6>] apic_timer_interrupt+0x1a/0x20
Oct 12 09:53:08 swdev14 kernel:  [<c011f0b2>] release_console_sem+0x59/0xcf
Oct 12 09:53:08 swdev14 kernel:  [<c011efb2>] vprintk+0x128/0x16f
Oct 12 09:53:08 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:08 swdev14 kernel:  [<c011ee86>] printk+0x1d/0x21
Oct 12 09:53:09 swdev14 kernel:  [<c0106edc>] show_trace+0x4e/0x8d
Oct 12 09:53:09 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:09 swdev14 kernel:  [<c0106fd9>] dump_stack+0x23/0x27
Oct 12 09:53:09 swdev14 kernel:  [<c0299267>] schedule+0xbaf/0xbe2
Oct 12 09:53:09 swdev14 kernel:  [<c0298496>] __down+0x8a/0x107
Oct 12 09:53:09 swdev14 kernel:  [<c0134888>] check_preempt_timing+0x191/0x1f9
Oct 12 09:53:09 swdev14 kernel:  [<c0134936>] touch_preempt_timing+0x46/0x4a
Oct 12 09:53:09 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:09 swdev14 kernel:  [<c029a358>] _spin_unlock_irqrestore+0xb/0x36
Oct 12 09:53:09 swdev14 kernel:  [<c0298491>] __down+0x85/0x107
Oct 12 09:53:09 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:09 swdev14 kernel:  [<c0298496>] __down+0x8a/0x107
Oct 12 09:53:09 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 09:53:09 swdev14 kernel:  [<c029865c>] __down_failed+0x8/0xc
Oct 12 09:53:09 swdev14 kernel:  [<c0133ee3>] .text.lock.mutex+0x5/0x146
Oct 12 09:53:09 swdev14 kernel:  [<c0133884>] _mutex_lock_irqsave+0x16/0x1c
Oct 12 09:53:09 swdev14 kernel:  [<e0840abe>] boomerang_start_xmit+0x123/0x2eb [3c59x]
Oct 12 09:53:09 swdev14 kernel:  [<c013414d>] __mcount+0x1d/0x21
Oct 12 09:53:09 swdev14 kernel:  [<c029a2b8>] _spin_unlock+0xb/0x34
Oct 12 09:53:09 swdev14 kernel:  [<c02404f3>] qdisc_restart+0x132/0x1e6
Oct 12 09:53:09 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:09 swdev14 kernel:  [<c0240517>] qdisc_restart+0x156/0x1e6
Oct 12 09:53:09 swdev14 kernel:  [<c02313dd>] dev_queue_xmit+0x239/0x2d9
Oct 12 09:53:09 swdev14 kernel:  [<c024ecfa>] ip_finish_output+0xd5/0x216
Oct 12 09:53:09 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:09 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 09:53:09 swdev14 kernel:  [<c025148e>] dst_output+0x1a/0x2f
Oct 12 09:53:09 swdev14 kernel:  [<c023bf2c>] nf_hook_slow+0xec/0x11e
Oct 12 09:53:09 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:09 swdev14 kernel:  [<c024f539>] ip_queue_xmit+0x495/0x59e
Oct 12 09:53:09 swdev14 kernel:  [<c0251474>] dst_output+0x0/0x2f
Oct 12 09:53:09 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:09 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:53:09 swdev14 kernel:  [<c029a2c7>] _spin_unlock+0x1a/0x34
Oct 12 09:53:09 swdev14 kernel:  [<c0134af1>] sub_preempt_count+0x82/0x97
Oct 12 09:56:00 swdev14 syslogd 1.4.1: restart.

--------------080907080607000404050706--
