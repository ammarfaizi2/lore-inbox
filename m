Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWDCKrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWDCKrB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 06:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWDCKrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 06:47:01 -0400
Received: from mail2.ugr.es ([150.214.35.29]:59608 "EHLO mail2.ugr.es")
	by vger.kernel.org with ESMTP id S932290AbWDCKrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 06:47:01 -0400
Message-ID: <4430FD71.2080602@ugr.es>
Date: Mon, 03 Apr 2006 12:48:17 +0200
From: Ruben Garcia <ruben@ugr.es>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kswapd [oops] [2.6.16.1] hangs AMD64
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

Good morning.

I'm getting these oops every six hours approximately
The oops is always at dispose_list+114.
I am using encrypted swap. I tried both encryted swap over loop and
direct encrypted swap.
I will try unencrypted swap next.
My machine is an AMD64.

I'm aware there are a lot of changes mentioning swap in 2.6.17.preX.
I will test 2.6.17 when it comes out if I receive no reply.

I hope these can be of use in debugging kswapd.
If there is something you'd like me to test, just ask.
R.

Oops:
- ---------------------------------------
Mar 30 14:35:00 blackhole kernel: [26295.049536] Modules linked in:
snd_rtctimer rfcomm l2cap bluetooth powernow_k8 cpufreq_use
rspace cpufreq_stats freq_table cpufreq_powersave cpufreq_ondemand
cpufreq_conservative lp video thermal processor fan containe
r button battery ac ipv6 mousedev tsdev ide_cd cdrom parport_pc parport
pcspkr psmouse rtc ide_generic snd_seq_dummy snd_seq_os
s snd_seq_midi snd_seq_midi_event snd_seq snd_via82xx gameport
snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm sn
d_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd
soundcore i2c_viapro ehci_hcd uhci_hcd generic sata_via l
ibata scsi_mod bt878 tuner bttv video_buf firmware_class compat_ioctl32
i2c_algo_bit v4l2_common btcx_risc ir_common tveeprom i
2c_core videodev sk98lin skge shpchp pci_hotplug aes dm_crypt loop
dm_mod md_mod unix
Mar 30 14:35:00 blackhole kernel: [26295.049699] Pid: 140, comm: kswapd0
Not tainted 2.6.16.1 #4
Mar 30 14:35:00 blackhole kernel: [26295.049711] RIP:
0010:[dispose_list+114/319] <ffffffff8017f5ff>{dispose_list+114}
Mar 30 14:35:00 blackhole kernel: [26295.049727] RSP:
0018:ffff81003fdd7d78  EFLAGS: 00010246
Mar 30 14:35:00 blackhole kernel: [26295.049743] RAX: 0000000000000000
RBX: ffff81003487a760 RCX: 0000000000000036
Mar 30 14:35:00 blackhole kernel: [26295.049757] RDX: ffff800001f64870
RSI: ffff81003487a8d8 RDI: ffffffffffffffff
Mar 30 14:35:00 blackhole kernel: [26295.049770] RBP: ffff81003487a750
R08: ffff810001cd4228 R09: 0000000000000006
Mar 30 14:35:00 blackhole kernel: [26295.049783] R10: 0000000000000006
R11: ffffffff801b4912 R12: 000000000000001b
Mar 30 14:35:00 blackhole kernel: [26295.049795] R13: ffff81003fdd7da8
R14: 0000000000000080 R15: 0000000000000080
Mar 30 14:35:00 blackhole kernel: [26295.049809] FS:
00000000424e6960(0000) GS:ffffffff803fa000(0000) knlGS:000000007c355bb0
Mar 30 14:35:00 blackhole kernel: [26295.049827] CS:  0010 DS: 0018 ES:
0018 CR0: 000000008005003b
Mar 30 14:35:00 blackhole kernel: [26295.049838] CR2: ffff800001f64870
CR3: 0000000028507000 CR4: 00000000000006e0
Mar 30 14:35:00 blackhole kernel: [26295.049852] Process kswapd0 (pid:
140, threadinfo ffff81003fdd6000, task ffff81003fd0f040)
Mar 30 14:35:00 blackhole kernel: [26295.049869] Stack: 0000000000000000
ffff810027f21438 ffff810027f21448 0000000000000080
Mar 30 14:35:00 blackhole kernel: [26295.049885]        0000000000000000
ffffffff8017f8b3 ffff8100286199f8 ffff81002944fa78
Mar 30 14:35:00 blackhole kernel: [26295.049906]        ffff81003fdd7db8
ffff81003ffa84c0
Mar 30 14:35:00 blackhole kernel: [26295.049919] Call Trace:
<ffffffff8017f8b3>{shrink_icache_memory+487}
Mar 30 14:35:00 blackhole kernel: [26295.049944]
<ffffffff80150b4b>{shrink_slab+223} <ffffffff80151f19>{balance_pgdat+56
8}
Mar 30 14:35:00 blackhole kernel: [26295.049982]
<ffffffff80152150>{kswapd+255} <ffffffff8013aa0c>{autoremove_wake_funct
ion+0}
Mar 30 14:35:00 blackhole kernel: [26295.050012]
<ffffffff8010b286>{child_rip+8} <ffffffff80152051>{kswapd+0}
Mar 30 14:35:00 blackhole kernel: [26295.050042]
<ffffffff8010b27e>{child_rip+0}
Mar 30 14:35:00 blackhole kernel: [26295.050061]
Mar 30 14:35:00 blackhole kernel: [26295.050062] Code: 48 89 02 74 04 48
89 50 08 48 c7 43 f0 00 00 00 00 48 c7 43
Mar 30 14:35:00 blackhole kernel: [26295.050303]  <6>note: kswapd0[140]
exited with preempt_count 1


- -------------------------------

(gdb) disassemble dispose_list
Dump of assembler code for function dispose_list:
0xffffffff8017f58d <dispose_list+0>:    push   %r13
0xffffffff8017f58f <dispose_list+2>:    mov    %rdi,%r13
0xffffffff8017f592 <dispose_list+5>:    push   %r12
0xffffffff8017f594 <dispose_list+7>:    xor    %r12d,%r12d
0xffffffff8017f597 <dispose_list+10>:   push   %rbp
0xffffffff8017f598 <dispose_list+11>:   push   %rbx
0xffffffff8017f599 <dispose_list+12>:   push   %rax
0xffffffff8017f59a <dispose_list+13>:   jmpq   0xffffffff8017f66f
<dispose_list+226>
0xffffffff8017f59f <dispose_list+18>:   mov    (%rbx),%rdx
0xffffffff8017f5a2 <dispose_list+21>:   mov    0x8(%rbx),%rax
0xffffffff8017f5a6 <dispose_list+25>:   lea    0xfffffffffffffff0(%rbx),%rbp
0xffffffff8017f5aa <dispose_list+29>:   mov    %rax,0x8(%rdx)
0xffffffff8017f5ae <dispose_list+33>:   mov    %rdx,(%rax)
0xffffffff8017f5b1 <dispose_list+36>:   movq   $0x200200,0x8(%rbx)
0xffffffff8017f5b9 <dispose_list+44>:   movq   $0x100100,(%rbx)
0xffffffff8017f5c0 <dispose_list+51>:   cmpq   $0x0,0x160(%rbp)
0xffffffff8017f5c8 <dispose_list+59>:   je     0xffffffff8017f5d8
<dispose_list+75>
0xffffffff8017f5ca <dispose_list+61>:   lea    0x108(%rbx),%rdi
0xffffffff8017f5d1 <dispose_list+68>:   xor    %esi,%esi
0xffffffff8017f5d3 <dispose_list+70>:   callq  0xffffffff80150984
<truncate_inode_pages>
0xffffffff8017f5d8 <dispose_list+75>:   mov    %rbp,%rdi
0xffffffff8017f5db <dispose_list+78>:   callq  0xffffffff8017f483
<clear_inode>
0xffffffff8017f5e0 <dispose_list+83>:   mov    %gs:0x10,%rax
0xffffffff8017f5e9 <dispose_list+92>:   incl   0xffffffffffffe044(%rax)
0xffffffff8017f5ef <dispose_list+98>:   mov    0xfffffffffffffff8(%rbx),%rdx
0xffffffff8017f5f3 <dispose_list+102>:  test   %rdx,%rdx
0xffffffff8017f5f6 <dispose_list+105>:  je     0xffffffff8017f618
<dispose_list+139>
0xffffffff8017f5f8 <dispose_list+107>:  mov    0xfffffffffffffff0(%rbx),%rax
0xffffffff8017f5fc <dispose_list+111>:  test   %rax,%rax
0xffffffff8017f5ff <dispose_list+114>:  mov    %rax,(%rdx)
0xffffffff8017f602 <dispose_list+117>:  je     0xffffffff8017f608
<dispose_list+123>
0xffffffff8017f604 <dispose_list+119>:  mov    %rdx,0x8(%rax)
0xffffffff8017f608 <dispose_list+123>:  movq   $0x0,0xfffffffffffffff0(%rbx)
0xffffffff8017f610 <dispose_list+131>:  movq   $0x0,0xfffffffffffffff8(%rbx)
0xffffffff8017f618 <dispose_list+139>:  lea    0x20(%rbp),%rax
0xffffffff8017f61c <dispose_list+143>:  mov    0x20(%rbp),%rcx
0xffffffff8017f620 <dispose_list+147>:  mov    0x8(%rax),%rdx
0xffffffff8017f624 <dispose_list+151>:  mov    %rdx,0x8(%rcx)
0xffffffff8017f628 <dispose_list+155>:  mov    %rcx,(%rdx)
- ---Type <return> to continue, or q <return> to quit---
0xffffffff8017f62b <dispose_list+158>:  mov    %rax,0x8(%rax)
0xffffffff8017f62f <dispose_list+162>:  mov    %rax,0x20(%rbp)
0xffffffff8017f633 <dispose_list+166>:  mov    %gs:0x10,%rax
0xffffffff8017f63c <dispose_list+175>:  decl   0xffffffffffffe044(%rax)
0xffffffff8017f642 <dispose_list+181>:  mov    %gs:0x10,%rax
0xffffffff8017f64b <dispose_list+190>:  mov    0xffffffffffffe038(%rax),%eax
0xffffffff8017f651 <dispose_list+196>:  mov    %eax,%eax
0xffffffff8017f653 <dispose_list+198>:  test   $0x8,%al
0xffffffff8017f655 <dispose_list+200>:  je     0xffffffff8017f65c
<dispose_list+207>
0xffffffff8017f657 <dispose_list+202>:  callq  0xffffffff802decf9
<preempt_schedule>
0xffffffff8017f65c <dispose_list+207>:  mov    %rbp,%rdi
0xffffffff8017f65f <dispose_list+210>:  inc    %r12d
0xffffffff8017f662 <dispose_list+213>:  callq  0xffffffff8017ec70
<wake_up_inode>
0xffffffff8017f667 <dispose_list+218>:  mov    %rbp,%rdi
0xffffffff8017f66a <dispose_list+221>:  callq  0xffffffff8017eb2e
<destroy_inode>
0xffffffff8017f66f <dispose_list+226>:  mov    0x0(%r13),%rbx
0xffffffff8017f673 <dispose_list+230>:  cmp    %r13,%rbx
0xffffffff8017f676 <dispose_list+233>:  jne    0xffffffff8017f59f
<dispose_list+18>
0xffffffff8017f67c <dispose_list+239>:  mov    %gs:0x10,%rax
0xffffffff8017f685 <dispose_list+248>:  incl   0xffffffffffffe044(%rax)
0xffffffff8017f68b <dispose_list+254>:  sub    %r12d,2427998(%rip)
  # 0xffffffff803d02f0 <inodes_stat>
0xffffffff8017f692 <dispose_list+261>:  mov    %gs:0x10,%rax
0xffffffff8017f69b <dispose_list+270>:  decl   0xffffffffffffe044(%rax)
0xffffffff8017f6a1 <dispose_list+276>:  mov    %gs:0x10,%rax
0xffffffff8017f6aa <dispose_list+285>:  mov    0xffffffffffffe038(%rax),%eax
0xffffffff8017f6b0 <dispose_list+291>:  mov    %eax,%eax
0xffffffff8017f6b2 <dispose_list+293>:  test   $0x8,%al
0xffffffff8017f6b4 <dispose_list+295>:  je     0xffffffff8017f6c3
<dispose_list+310>
0xffffffff8017f6b6 <dispose_list+297>:  pop    %r13
0xffffffff8017f6b8 <dispose_list+299>:  pop    %rbx
0xffffffff8017f6b9 <dispose_list+300>:  pop    %rbp
0xffffffff8017f6ba <dispose_list+301>:  pop    %r12
0xffffffff8017f6bc <dispose_list+303>:  pop    %r13
0xffffffff8017f6be <dispose_list+305>:  jmpq   0xffffffff802decf9
<preempt_schedule>
0xffffffff8017f6c3 <dispose_list+310>:  pop    %r12
0xffffffff8017f6c5 <dispose_list+312>:  pop    %rbx
0xffffffff8017f6c6 <dispose_list+313>:  pop    %rbp
0xffffffff8017f6c7 <dispose_list+314>:  pop    %r12
0xffffffff8017f6c9 <dispose_list+316>:  pop    %r13
0xffffffff8017f6cb <dispose_list+318>:  retq
- ---Type <return> to continue, or q <return> to quit---
End of assembler dump.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFEMP1xjJvgg3iy84QRA6xyAJ4+HtNDt1jM0IHiWoEzjxb6n8/AoACeLV9n
MN8yF190gmdtTRMzfrFltcA=
=m5Kj
-----END PGP SIGNATURE-----
