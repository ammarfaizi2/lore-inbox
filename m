Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932685AbWHNUs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbWHNUs1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 16:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932733AbWHNUs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 16:48:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:6231 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932685AbWHNUs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 16:48:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=o/iRgiWf7qr1RKtkXSjZSgFusxDMLEth2ui7QOYR7oNsq5ts8a6kRTsi/xjhquKGA5jmifzedKsVNPhbxX+dEJCYu4krobJTumr308rIDeLf86NjAshHNgsH6BxzirDTk1q+VqyImH5uPxmyhbD+sG3XKdkIKh7E4HjPRBjb44g=
Message-ID: <44E0E1BA.3000204@gmail.com>
Date: Mon, 14 Aug 2006 22:48:58 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       Dinakar Guniguntala <dino@in.ibm.com>, Dave Jones <davej@redhat.com>
Subject: Re: 2.6.18-rc4-mm1
References: <20060813012454.f1d52189.akpm@osdl.org>	 <6bffcb0e0608140702i70fb82ffr99a3ad6fdfbfd55e@mail.gmail.com>	 <20060814111914.b50f9b30.akpm@osdl.org> <44E0C889.3020706@gmail.com>	 <1155583256.5413.42.camel@localhost.localdomain>	 <6bffcb0e0608141227i2c4c48b6w8e18165ac406862@mail.gmail.com> <1155584697.5413.51.camel@localhost.localdomain>
In-Reply-To: <1155584697.5413.51.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Mon, 2006-08-14 at 21:27 +0200, Michal Piotrowski wrote:
>> On 14/08/06, john stultz <johnstul@us.ibm.com> wrote:
>>> On Mon, 2006-08-14 at 21:01 +0200, Michal Piotrowski wrote:
>>>> Andrew Morton wrote:
>>>>> On Mon, 14 Aug 2006 16:02:52 +0200
>>>>> "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
>>>>>> On 13/08/06, Andrew Morton <akpm@osdl.org> wrote:
>>>>>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
>>>>>>>
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel: BUG: unable to handle kernel
>>>>>> paging request at virtual address fffeffbf
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel:  printing eip:
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel: c013d539
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel: *pde = 00004067
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel: *pte = 00000000
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel: Oops: 0000 [#1]
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel: 4K_STACKS PREEMPT SMP
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel: last sysfs file:
>>>>>> /devices/platform/i2c-9191/9191-0290/temp2_input
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel: Modules linked in: ipv6 w83627hf
>>>>>> hwmon_vid hwmon i2c_isa af_packet ip_conntrack_netbios
>>>>>> _ns ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp
>>>>>> iptable_filter ip_tables x_tables cpufreq_userspace p4_clockmod spe
>>>>>> edstep_lib binfmt_misc thermal processor fan container evdev
>>>>>> snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_
>>>>>> oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss
>>>>>> snd_mixer_oss snd_pcm sk98lin snd_timer skge snd soundcore snd_pag
>>>>>> e_alloc ide_cd intel_agp agpgart cdrom i2c_i801 rtc unix
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel: CPU:    1
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel: EIP:    0060:[<c013d539>]    Not
>>>>>> tainted VLI
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel: EFLAGS: 00210286   (2.6.18-rc4-mm1 #97)
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel: EIP is at futex_wake+0x9c/0xcb
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel: eax: 0808c000   ebx: c0670a60
>>>>>> ecx: d3a1dfa2   edx: fffeffbf
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel: esi: 00000000   edi: fffeffbf
>>>>>> ebp: f4896f64   esp: f4896f40
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel: ds: 007b   es: 007b   ss: 0068
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel: Process firefox-bin (pid: 2210,
>>>>>> ti=f4896000 task=f3d180f0 task.ti=f4896000)
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel: Stack: c0670a80 00000001 0808c000
>>>>>> f4302e74 00000044 ffffffe7 0808c044 bf8f35b0
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel:        00000000 f4896f7c c013ed39
>>>>>> 00000001 0808c044 7fffffff bf8f35b0 f4896fb4
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel:        c013ee84 7fffffff bf8f35b0
>>>>>> 00000000 bf8f3528 00000000 f4896fa8 00000000
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel: Call Trace:
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel:  [<c013ed39>] do_futex+0x3c/0x92
>>>>>> Aug 14 15:35:10 ltg01-fedora kernel:  [<c013ee84>] sys_futex+0xf5/0x101
>>>>>> Aug 14 15:35:11 ltg01-fedora kernel:  [<c010312d>] sysenter_past_esp+0x56/0x8d
>>>>>> Aug 14 15:35:11 ltg01-fedora kernel:  [<b7f1d410>] 0xb7f1d410
>>>>>> Aug 14 15:35:11 ltg01-fedora kernel:  [<c0103fc1>] show_trace_log_lvl+0x12/0x22
>>>>>> Aug 14 15:35:11 ltg01-fedora kernel:  [<c0104067>] show_stack_log_lvl+0x87/0x8f
>>>>>> Aug 14 15:35:11 ltg01-fedora kernel:  [<c0104203>] show_registers+0x151/0x1d8
>>>>>> Aug 14 15:35:11 ltg01-fedora kernel:  [<c010444d>] die+0x120/0x1f0
>>>>>> Aug 14 15:35:11 ltg01-fedora kernel:  [<c01185cf>] do_page_fault+0x49d/0x580
>>>>>> Aug 14 15:35:11 ltg01-fedora kernel:  [<c0303ba9>] error_code+0x39/0x40
>>>>>> Aug 14 15:35:11 ltg01-fedora kernel:  [<c013ed39>] do_futex+0x3c/0x92
>>>>>> Aug 14 15:35:11 ltg01-fedora kernel:  [<c013ee84>] sys_futex+0xf5/0x101
>>>>>> Aug 14 15:35:11 ltg01-fedora kernel:  [<c010312d>] sysenter_past_esp+0x56/0x8d
>>>>>> Aug 14 15:35:11 ltg01-fedora kernel:  =======================
>>>>>> Aug 14 15:35:11 ltg01-fedora kernel: Code: 45 e8 39 41 04 75 22 8b 45
>>>>>> ec 39 41 08 75 1a 83 7a 48 00 74 07 be ea ff ff ff eb
>>>>>> 16 89 d0 46 e8 00 fd ff ff 3b 75 e0 7d 09 89 fa <8b> 3f 3b 55 dc eb c0
>>>>>> 89 d8 e8 bd 60 1c 00 89 e0 25 00 f0 ff ff
>>>>>> Aug 14 15:35:11 ltg01-fedora kernel: EIP: [<c013d539>]
>>>>>> futex_wake+0x9c/0xcb SS:ESP 0068:f4896f40
>>>>> This is worrisome.  Is it reproducible?
>>>> I don't know how to reproduce it, but it happened second time today.
>>>>
>>>>>  If so, reverting
>>>>> futex_handle_fault-always-fails.patch and retesting would be useful.
>>>> I reverted this patch.
>>> Just to be clear, the issue has shown itself without the patch?
>> No, it hasn't.
> 
> Thanks for the clarification. 
> 
>>> Or is
>>> that not the case?
>> In current -mm only futex_handle_fault-always-fails.patch changes
>> kernel/futex.c, so IMHO it's very probable that there is something
>> wrong with this patch.
> 
> Yea, I'd believe that. I'm newish to the futex code, and as I said w/
> the patch I'm not 100% sure its the right fix, but it does resolve an
> issue we found.
> 
> I'll take another look to see if I futzed something up or if the fix is
> just incomplete, although some more familiar eyes with the code would
> probably help here.
> 

Hmmm... It looks a bit different without futex_handle_fault-always-fails.patch

Aug 14 22:30:09 ltg01-fedora kernel: general protection fault: 0000 [#1]
Aug 14 22:30:09 ltg01-fedora kernel: 4K_STACKS PREEMPT SMP
Aug 14 22:30:09 ltg01-fedora kernel: last sysfs file: /devices/platform/i2c-9191/9191-0290/temp2_input
Aug 14 22:30:09 ltg01-fedora kernel: Modules linked in: ipv6 w83627hf hwmon_vid hwmon i2c_isa af_packet ip_conntrack_netbios
_ns ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp iptable_filter ip_tables x_tables cpufreq_userspace p4_clockmod spe
edstep_lib binfmt_misc thermal processor fan container evdev snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_
oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm sk98lin skge snd_timer snd soundcore snd_pag
e_alloc ide_cd i2c_i801 intel_agp agpgart cdrom rtc unix
Aug 14 22:30:09 ltg01-fedora kernel: CPU:    0
Aug 14 22:30:09 ltg01-fedora kernel: EIP:    0060:[<c0205249>]    Not tainted VLI
Aug 14 22:30:09 ltg01-fedora kernel: EFLAGS: 00010246   (2.6.18-rc4-mm1 #101)
Aug 14 22:30:09 ltg01-fedora kernel: EIP is at __list_add+0x3d/0x7a
Aug 14 22:30:09 ltg01-fedora kernel: eax: 00000000   ebx: c0670a80   ecx: c038d4dc   edx: 00000000
Aug 14 22:30:09 ltg01-fedora kernel: esi: ffffffff   edi: f50ebee8   ebp: f50ebed0   esp: f50ebec4
Aug 14 22:30:09 ltg01-fedora kernel: ds: 007b   es: 007b   ss: 0068
Aug 14 22:30:09 ltg01-fedora kernel: Process thunderbird-bin (pid: 2288, ti=f50eb000 task=c75b9260 task.ti=f50eb000)
Aug 14 22:30:09 ltg01-fedora kernel: Stack: f50ebee8 080e7dc0 c0670a60 f50ebf64 c013de71 00000001 c75b9260 0000ea6b
Aug 14 22:30:10 ltg01-fedora kernel:        00000001 f50ebf20 c013adf0 00000001 00000000 dead4ead ffffffff ffffffff
Aug 14 22:30:10 ltg01-fedora kernel:        c75b9260 00000000 00000000 f50ebf10 f50ebf10 c0670a60 080e7000 f3e65c94
Aug 14 22:30:10 ltg01-fedora kernel: Call Trace:
Aug 14 22:30:10 ltg01-fedora kernel:  [<c013de71>] futex_wait+0x15c/0x220
Aug 14 22:30:10 ltg01-fedora kernel:  [<c013ed17>] do_futex+0x33/0x92
Aug 14 22:30:10 ltg01-fedora kernel:  [<c013ee6b>] sys_futex+0xf5/0x101
Aug 14 22:30:10 ltg01-fedora kernel:  [<c010312d>] sysenter_past_esp+0x56/0x8d
Aug 14 22:30:10 ltg01-fedora kernel:  [<b7f12410>] 0xb7f12410
Aug 14 22:30:10 ltg01-fedora kernel:  [<c0103fc1>] show_trace_log_lvl+0x12/0x22
Aug 14 22:30:10 ltg01-fedora kernel:  [<c0104067>] show_stack_log_lvl+0x87/0x8f
Aug 14 22:30:10 ltg01-fedora kernel:  [<c0104203>] show_registers+0x151/0x1d8
Aug 14 22:30:10 ltg01-fedora kernel:  [<c010444d>] die+0x120/0x1f0
Aug 14 22:30:10 ltg01-fedora kernel:  [<c0104c9f>] do_general_protection+0x1d1/0x1d9
Aug 14 22:30:10 ltg01-fedora kernel:  [<c0303b89>] error_code+0x39/0x40
Aug 14 22:30:10 ltg01-fedora kernel:  [<c013de71>] futex_wait+0x15c/0x220
Aug 14 22:30:10 ltg01-fedora kernel:  [<c013ed17>] do_futex+0x33/0x92
Aug 14 22:30:10 ltg01-fedora kernel:  [<c013ee6b>] sys_futex+0xf5/0x101
Aug 14 22:30:10 ltg01-fedora kernel:  [<c010312d>] sysenter_past_esp+0x56/0x8d
Aug 14 22:30:10 ltg01-fedora kernel:  =======================
Aug 14 22:30:10 ltg01-fedora kernel: Code: cb 39 71 04 0f 95 c2 e8 12 0f 00 00 85 c0 74 19 ff 73 04 56 68 a1 89 33 c0 e8 97
ce f1 ff 0f 0b 1a 00 7e 89 33 c0 83 c4 0c 31 d2 <39> 1e b8 f8 d4 38 c0 0f 95 c2 e8 e4 0e 00 00 85 c0 74 18 ff 36
Aug 14 22:30:10 ltg01-fedora kernel: EIP: [<c0205249>] __list_add+0x3d/0x7a SS:ESP 0068:f50ebec4
Aug 14 22:30:10 ltg01-fedora kernel:  <6>note: thunderbird-bin[2288] exited with preempt_count 1
Aug 14 22:30:10 ltg01-fedora kernel: BUG: sleeping function called from invalid context at /usr/src/linux-mm/mm/slab.c:2989
Aug 14 22:30:10 ltg01-fedora kernel: in_atomic():1, irqs_disabled():0
Aug 14 22:30:10 ltg01-fedora kernel:  [<c0103e41>] dump_trace+0x70/0x176
Aug 14 22:30:10 ltg01-fedora kernel:  [<c0103fc1>] show_trace_log_lvl+0x12/0x22
Aug 14 22:30:10 ltg01-fedora kernel:  [<c0103fde>] show_trace+0xd/0xf
Aug 14 22:30:10 ltg01-fedora kernel:  [<c01040b0>] dump_stack+0x17/0x19
Aug 14 22:30:10 ltg01-fedora kernel:  [<c011ec0c>] __might_sleep+0x92/0x9a
Aug 14 22:30:10 ltg01-fedora kernel:  [<c017319e>] kmem_cache_zalloc+0x27/0xe7
Aug 14 22:30:11 ltg01-fedora kernel:  [<c0154b57>] taskstats_exit_alloc+0x30/0x6e
Aug 14 22:30:11 ltg01-fedora kernel:  [<c012455e>] do_exit+0x1a3/0x5cd
Aug 14 22:30:11 ltg01-fedora kernel:  [<c0104515>] die+0x1e8/0x1f0
Aug 14 22:30:11 ltg01-fedora kernel:  [<c0104c9f>] do_general_protection+0x1d1/0x1d9
Aug 14 22:30:11 ltg01-fedora kernel:  [<c0303b89>] error_code+0x39/0x40
Aug 14 22:30:11 ltg01-fedora kernel:  [<c0205249>] __list_add+0x3d/0x7a
Aug 14 22:30:11 ltg01-fedora kernel:  [<c013de71>] futex_wait+0x15c/0x220
Aug 14 22:30:11 ltg01-fedora kernel:  [<c013ed17>] do_futex+0x33/0x92
Aug 14 22:30:11 ltg01-fedora kernel:  [<c013ee6b>] sys_futex+0xf5/0x101
Aug 14 22:30:11 ltg01-fedora kernel:  [<c010312d>] sysenter_past_esp+0x56/0x8d
Aug 14 22:30:11 ltg01-fedora kernel:  [<b7f12410>] 0xb7f12410
Aug 14 22:30:11 ltg01-fedora kernel:  [<c0103fc1>] show_trace_log_lvl+0x12/0x22
Aug 14 22:30:11 ltg01-fedora kernel:  [<c0103fde>] show_trace+0xd/0xf
Aug 14 22:30:11 ltg01-fedora kernel:  [<c01040b0>] dump_stack+0x17/0x19
Aug 14 22:30:11 ltg01-fedora kernel:  [<c011ec0c>] __might_sleep+0x92/0x9a
Aug 14 22:30:11 ltg01-fedora kernel:  [<c017319e>] kmem_cache_zalloc+0x27/0xe7
Aug 14 22:30:11 ltg01-fedora kernel:  [<c0154b57>] taskstats_exit_alloc+0x30/0x6e
Aug 14 22:30:11 ltg01-fedora kernel:  [<c012455e>] do_exit+0x1a3/0x5cd
Aug 14 22:30:11 ltg01-fedora kernel:  [<c0104515>] die+0x1e8/0x1f0
Aug 14 22:30:11 ltg01-fedora kernel:  [<c0104c9f>] do_general_protection+0x1d1/0x1d9
Aug 14 22:30:11 ltg01-fedora kernel:  [<c0303b89>] error_code+0x39/0x40
Aug 14 22:30:11 ltg01-fedora kernel:  [<c013de71>] futex_wait+0x15c/0x220
Aug 14 22:30:11 ltg01-fedora kernel:  [<c013ed17>] do_futex+0x33/0x92
Aug 14 22:30:11 ltg01-fedora kernel:  [<c013ee6b>] sys_futex+0xf5/0x101
Aug 14 22:30:11 ltg01-fedora kernel:  [<c010312d>] sysenter_past_esp+0x56/0x8d
Aug 14 22:30:11 ltg01-fedora kernel:  =======================

0xc0205249 is in __list_add (/usr/src/linux-mm/lib/list_debug.c:28).
23              if (unlikely(next->prev != prev)) {
24                      printk("list_add corruption. next->prev should be %p, but was %p\n",
25                              prev, next->prev);
26                      BUG();
27              }
28              if (unlikely(prev->next != next)) {
29                      printk("list_add corruption. prev->next should be %p, but was %p\n",
30                              next, prev->next);
31                      BUG();
32              }

I'll revert debug-variants-of-linked-list-macros.patch

> thanks
> -john
> 
> 

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
