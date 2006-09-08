Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWIHTW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWIHTW3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 15:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWIHTW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 15:22:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:35521 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751056AbWIHTW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 15:22:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=OSUnX79vXjz40dUR1A/ZY8psj/udu2EL+u1CGS7v50IFSpfNubwG9sYX+oBPQI5l5N7HRy3jXmqekVykNAiKICNGBzpCcwvtLHpiP7dVxWVjEfHkK1EeMmVg+/923bdewJpX84oV6Vwarn3mLiIeAJGgVeyb8x51lc0sj1bxV1Y=
Message-ID: <4501C31E.2040508@gmail.com>
Date: Fri, 08 Sep 2006 21:23:10 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.18-rc6-mm1
References: <20060908011317.6cb0495a.akpm@osdl.org>
In-Reply-To: <20060908011317.6cb0495a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm1/
> 
> - autofs4 mounting of NFS is still sick.

BUG: unable to handle kernel paging request at virtual address fdb52df8
 printing eip:
 c013894c
*pde = 37c85067
*pte = 00000000
Oops: 0000 [#1]
4K_STACKS PREEMPT SMP
last sysfs file: /devices/platform/i2c-9191/9191-0290/temp2_input
Modules linked in: ipv6 af_packet ip_conntrack_netbios_ns ipt_REJECT xt_state ip_conntrack
nfnetlink xt_tcpudp iptable_filter ip_tables x_tables cpufreq_userspace p4_clockmod speedstep_lib binfmt_misc thermal proces
sor fan container evdev snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_se
q_device sk98lin snd_pcm_oss snd_mixer_oss snd_pcm skge snd_timer snd soundcore snd_page_alloc ide_cd i2c_i801 iTCO_wdt inte
l_agp cdrom agpgart rtc unix
CPU:    0
EIP:    0060:[<c013894c>]    Not tainted VLI
EFLAGS: 00210212   (2.6.18-rc6-mm1 #115)
EIP is at __module_text_address+0xf/0x5c
eax: fdb54000   ebx: fdb67c04   ecx: f7c10000   edx: fdb52d00
esi: 000000fa   edi: f7c10f9c   ebp: 00000005   esp: f7c10e68
ds: 007b   es: 007b   ss: 0068
Process udevd (pid: 20250, ti=f7c10000 task=f7c21000 task.ti=f7c10000)
Stack: f7c10000 c5f36030 c012fb6c f7c10000 c014f61b c0341710 000284d0 00000010
       f7c21000 00000002 f7c10000 00200202 f57ce3c0 f52a8bfc f57ce3c0 f76a6ca4
      f4a3c800 c01575e4 f52a8bfc f7d31ec0 f76a6ca4 80010000 c015894c f76a6ca4
Call Trace:
[<c012fb6c>] __kernel_text_address+0x18/0x23
[<c014f61b>] __alloc_pages+0x301/0x313
[<c01575e4>] __pte_alloc+0xf/0x78
[<c015894c>] copy_page_range+0x139/0x3dd
[<c011e67b>] copy_process+0xc1e/0x13cf
[<c011f001>] do_fork+0xb6/0x1d2
[<c017cdfa>] mntput_no_expire+0x11/0x81
[<c010122e>] sys_clone+0x28/0x2d
[<c0102fc6>] sysenter_past_esp+0x5f/0x85
[<c0110033>] wakeup_pmode_return+0x33/0x55
=======================
Code: 31 c0 5b 5e 5f 5d c3 83 01 01 83 51 04 00 8b 12 31 c0 81 fa 10 eb 33 c0 0f 45 c2 c3 5
6 53 89 c1 8b 15 10 eb 33 c0 83 ea 04 eb 20 <8b> b2 f8 00 00 00 8b 82 e8 00 00 00 39 c1 72 23 01 f0 39 c1 73
Sep  8 20:23:34 euridica kernel: EIP: [<c013894c>] __module_text_address+0xf/0x5c SS:ESP 0068:f7c10e68

config file -> http://www.stardust.webpages.pl/files/mm/2.6.18-rc6-mm1/mm-config
Unfortunately, this kernel was build without debugging symbols. I'll try to reproduce this oops with CONFIG_DEBUG_*=y.

Ingo, can you take a look at this?

BUG: warning at /usr/src/linux-mm/kernel/lockdep.c:2359/check_flags()
 [<c01041ca>] dump_trace+0x63/0x1ca
 [<c0104343>] show_trace_log_lvl+0x12/0x25
 [<c01049a3>] show_trace+0xd/0x10
 [<c0104a68>] dump_stack+0x16/0x18
 [<c0138553>] check_flags+0x92/0x220
 [<c013b033>] lock_acquire+0x3a/0x88
 [<c0136d32>] down_write+0x28/0x43
 [<c0164a9b>] sys_brk+0x20/0xd6
 [<c0103166>] sysenter_past_esp+0x5f/0x99
DWARF2 unwinder stuck at sysenter_past_esp+0x5f/0x99

Leftover inexact backtrace:

 =======================
irq event stamp: 603424
hardirqs last  enabled at (603423): [<c0103238>] restore_nocheck+0x12/0x15
hardirqs last disabled at (603424): [<c0103173>] sysenter_past_esp+0x6c/0x99
softirqs last  enabled at (603376): [<c0126a61>] __do_softirq+0xe4/0xea
softirqs last disabled at (603371): [<c0105b3b>] do_softirq+0x6d/0x11f

config file -> http://www.stardust.webpages.pl/files/mm/2.6.18-rc6-mm1/mm-config2
http://www.stardust.webpages.pl/files/mm/2.6.18-rc6-mm1/mm-dmesg

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
