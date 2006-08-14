Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWHNTA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWHNTA6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 15:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWHNTA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 15:00:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:18028 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932350AbWHNTA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 15:00:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ojOYWp+1mzotqhkGy0F1QQFJ02KFB8LH6hKqnzRj256zw61xhhff0SuIrewgoOZmcQizJO1jmN50kwp/BTp5565ZC0Z7cWsEdZYXolluiAbsK8x+e8pArn5SJivQU1asrFURd0fhsHzEIDJ+DLhqBOL4tF8Mb6iUC2uwdc46fEA=
Message-ID: <44E0C889.3020706@gmail.com>
Date: Mon, 14 Aug 2006 21:01:29 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.18-rc4-mm1
References: <20060813012454.f1d52189.akpm@osdl.org>	<6bffcb0e0608140702i70fb82ffr99a3ad6fdfbfd55e@mail.gmail.com> <20060814111914.b50f9b30.akpm@osdl.org>
In-Reply-To: <20060814111914.b50f9b30.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 14 Aug 2006 16:02:52 +0200
> "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
> 
>> On 13/08/06, Andrew Morton <akpm@osdl.org> wrote:
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
>>>
>> Aug 14 15:35:10 ltg01-fedora kernel: BUG: unable to handle kernel
>> paging request at virtual address fffeffbf
>> Aug 14 15:35:10 ltg01-fedora kernel:  printing eip:
>> Aug 14 15:35:10 ltg01-fedora kernel: c013d539
>> Aug 14 15:35:10 ltg01-fedora kernel: *pde = 00004067
>> Aug 14 15:35:10 ltg01-fedora kernel: *pte = 00000000
>> Aug 14 15:35:10 ltg01-fedora kernel: Oops: 0000 [#1]
>> Aug 14 15:35:10 ltg01-fedora kernel: 4K_STACKS PREEMPT SMP
>> Aug 14 15:35:10 ltg01-fedora kernel: last sysfs file:
>> /devices/platform/i2c-9191/9191-0290/temp2_input
>> Aug 14 15:35:10 ltg01-fedora kernel: Modules linked in: ipv6 w83627hf
>> hwmon_vid hwmon i2c_isa af_packet ip_conntrack_netbios
>> _ns ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp
>> iptable_filter ip_tables x_tables cpufreq_userspace p4_clockmod spe
>> edstep_lib binfmt_misc thermal processor fan container evdev
>> snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_
>> oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss
>> snd_mixer_oss snd_pcm sk98lin snd_timer skge snd soundcore snd_pag
>> e_alloc ide_cd intel_agp agpgart cdrom i2c_i801 rtc unix
>> Aug 14 15:35:10 ltg01-fedora kernel: CPU:    1
>> Aug 14 15:35:10 ltg01-fedora kernel: EIP:    0060:[<c013d539>]    Not
>> tainted VLI
>> Aug 14 15:35:10 ltg01-fedora kernel: EFLAGS: 00210286   (2.6.18-rc4-mm1 #97)
>> Aug 14 15:35:10 ltg01-fedora kernel: EIP is at futex_wake+0x9c/0xcb
>> Aug 14 15:35:10 ltg01-fedora kernel: eax: 0808c000   ebx: c0670a60
>> ecx: d3a1dfa2   edx: fffeffbf
>> Aug 14 15:35:10 ltg01-fedora kernel: esi: 00000000   edi: fffeffbf
>> ebp: f4896f64   esp: f4896f40
>> Aug 14 15:35:10 ltg01-fedora kernel: ds: 007b   es: 007b   ss: 0068
>> Aug 14 15:35:10 ltg01-fedora kernel: Process firefox-bin (pid: 2210,
>> ti=f4896000 task=f3d180f0 task.ti=f4896000)
>> Aug 14 15:35:10 ltg01-fedora kernel: Stack: c0670a80 00000001 0808c000
>> f4302e74 00000044 ffffffe7 0808c044 bf8f35b0
>> Aug 14 15:35:10 ltg01-fedora kernel:        00000000 f4896f7c c013ed39
>> 00000001 0808c044 7fffffff bf8f35b0 f4896fb4
>> Aug 14 15:35:10 ltg01-fedora kernel:        c013ee84 7fffffff bf8f35b0
>> 00000000 bf8f3528 00000000 f4896fa8 00000000
>> Aug 14 15:35:10 ltg01-fedora kernel: Call Trace:
>> Aug 14 15:35:10 ltg01-fedora kernel:  [<c013ed39>] do_futex+0x3c/0x92
>> Aug 14 15:35:10 ltg01-fedora kernel:  [<c013ee84>] sys_futex+0xf5/0x101
>> Aug 14 15:35:11 ltg01-fedora kernel:  [<c010312d>] sysenter_past_esp+0x56/0x8d
>> Aug 14 15:35:11 ltg01-fedora kernel:  [<b7f1d410>] 0xb7f1d410
>> Aug 14 15:35:11 ltg01-fedora kernel:  [<c0103fc1>] show_trace_log_lvl+0x12/0x22
>> Aug 14 15:35:11 ltg01-fedora kernel:  [<c0104067>] show_stack_log_lvl+0x87/0x8f
>> Aug 14 15:35:11 ltg01-fedora kernel:  [<c0104203>] show_registers+0x151/0x1d8
>> Aug 14 15:35:11 ltg01-fedora kernel:  [<c010444d>] die+0x120/0x1f0
>> Aug 14 15:35:11 ltg01-fedora kernel:  [<c01185cf>] do_page_fault+0x49d/0x580
>> Aug 14 15:35:11 ltg01-fedora kernel:  [<c0303ba9>] error_code+0x39/0x40
>> Aug 14 15:35:11 ltg01-fedora kernel:  [<c013ed39>] do_futex+0x3c/0x92
>> Aug 14 15:35:11 ltg01-fedora kernel:  [<c013ee84>] sys_futex+0xf5/0x101
>> Aug 14 15:35:11 ltg01-fedora kernel:  [<c010312d>] sysenter_past_esp+0x56/0x8d
>> Aug 14 15:35:11 ltg01-fedora kernel:  =======================
>> Aug 14 15:35:11 ltg01-fedora kernel: Code: 45 e8 39 41 04 75 22 8b 45
>> ec 39 41 08 75 1a 83 7a 48 00 74 07 be ea ff ff ff eb
>> 16 89 d0 46 e8 00 fd ff ff 3b 75 e0 7d 09 89 fa <8b> 3f 3b 55 dc eb c0
>> 89 d8 e8 bd 60 1c 00 89 e0 25 00 f0 ff ff
>> Aug 14 15:35:11 ltg01-fedora kernel: EIP: [<c013d539>]
>> futex_wake+0x9c/0xcb SS:ESP 0068:f4896f40
> 
> This is worrisome.  Is it reproducible?

I don't know how to reproduce it, but it happened second time today.

>  If so, reverting
> futex_handle_fault-always-fails.patch and retesting would be useful.

I reverted this patch.

> 
> (please kill the wordwrapping in your email client, btw).
> 
> 
> 

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
