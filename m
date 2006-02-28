Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932703AbWB1X43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703AbWB1X43 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbWB1X43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:56:29 -0500
Received: from dvhart.com ([64.146.134.43]:61354 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932703AbWB1X42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:56:28 -0500
Message-ID: <4404E328.7070807@mbligh.org>
Date: Tue, 28 Feb 2006 15:56:24 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>,
       linuxppc64-dev@ozlabs.org
Subject: Re: 2.6.16-rc5-mm1
References: <20060228042439.43e6ef41.akpm@osdl.org>
In-Reply-To: <20060228042439.43e6ef41.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm1/

New panic on IBM power4 lpar of P690. 2.6.16-rc5-git3 is OK.

(config: 
http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/power4)

http://test.kernel.org/24165/debug/console.log


STAFProc version 2.6.2 initialized
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=32 NUMA PSERIES LPAR
Modules linked in:
NIP: C000000000064748 LR: C000000000064764 CTR: C0000000000A8B10
REGS: c00000077dfaad30 TRAP: 0300   Not tainted  (2.6.16-rc5-mm1-autokern1)
MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 28000488  XER: 00000000
DAR: 0000000000000000, DSISR: 0000000040000000
TASK = c00000076a1ac720[11058] 'mingetty' THREAD: c00000077dfa8000 CPU: 1
GPR00: 0000000000000007 C00000077DFAAFB0 C000000000644F70 C00000076F303F08
GPR04: C00000076D478E00 0000000000000000 C00000076D478E00 0000000000000001
GPR08: 000000000000000A 0000000000000000 00000000000001AA C00000076F303F08
GPR12: 0000000048000442 C000000000548B80 0000000010060000 0000000010060000
GPR16: 0000000010060000 0000000010080000 0000000010080000 0000000010060000
GPR20: 0000000010010000 0000000000000001 0000000000000000 0000000000000001
GPR24: 0000000010003738 C00000077255F010 0000000000000001 0000000000000000
GPR28: 0000000000000007 0000000000000000 C00000000055F4A8 C0000000041F82A0
NIP [C000000000064748] .__rcu_process_callbacks+0x1fc/0x2f8
LR [C000000000064764] .__rcu_process_callbacks+0x218/0x2f8
Call Trace:
[C00000077DFAAFB0] [C000000000064764] 
.__rcu_process_callbacks+0x218/0x2f8 (unreliable)
[C00000077DFAB040] [C000000000064874] .rcu_process_callbacks+0x30/0x58
[C00000077DFAB0C0] [C000000000053848] .tasklet_action+0xe4/0x19c
[C00000077DFAB160] [C000000000053EA8] .__do_softirq+0x9c/0x16c
[C00000077DFAB200] [C00000000000B6C8] .do_softirq+0x74/0xac
[C00000077DFAB280] [C000000000054388] .irq_exit+0x64/0x7c
[C00000077DFAB300] [C00000000001E0AC] .timer_interrupt+0x460/0x48c
[C00000077DFAB3E0] [C0000000000034DC] decrementer_common+0xdc/0x100
--- Exception: 901 at ._atomic_dec_and_lock+0x3c/0xb8
     LR = .mntput_no_expire+0x30/0xcc
[C00000077DFAB6D0] [C0000007680CF438] 0xc0000007680cf438 (unreliable)
[C00000077DFAB750] [C0000000000CD6D0] .mntput_no_expire+0x30/0xcc
[C00000077DFAB7E0] [C0000000000B9F40] .path_release+0x44/0x5c
[C00000077DFAB870] [C0000000000ED840] .proc_pid_follow_link+0x34/0xf0
[C00000077DFAB900] [C0000000000BD01C] .__link_path_walk+0xe64/0x1394
[C00000077DFAB9E0] [C0000000000BD5DC] .link_path_walk+0x90/0x168
[C00000077DFABAE0] [C0000000000BDE28] .do_path_lookup+0x2fc/0x364
[C00000077DFABB90] [C0000000000BF4E0] .__user_walk_fd+0x68/0xa8
[C00000077DFABC30] [C0000000000B5578] .vfs_stat_fd+0x24/0x70
[C00000077DFABD30] [C0000000000B56BC] .sys_stat64+0x1c/0x50
[C00000077DFABE30] [C00000000000871C] syscall_exit+0x0/0x40
Instruction dump:
38000000 901d0080 e87f0040 2fa30000 419e00fc 7c6b1b78 3b800000 ebab0000
7d635b78 fbbf0040 60000000 e92b0008 <e8090000> f8410028 60000000 e9690010
  <0>Kernel panic - not syncing: Fatal exception in interrupt
  smp_call_function on cpu 1: other cpus not responding (1)
-- 0:conmux-control -- time-stamp -- Feb/28/06  5:08:52 --
