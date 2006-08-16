Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWHPDmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWHPDmQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 23:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWHPDmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 23:42:16 -0400
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:43793 "EHLO
	smtp-vbr11.xs4all.nl") by vger.kernel.org with ESMTP
	id S1750888AbWHPDmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 23:42:16 -0400
Message-ID: <44E29415.4040400@xs4all.nl>
Date: Wed, 16 Aug 2006 05:42:13 +0200
From: Udo van den Heuvel <udovdh@xs4all.nl>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Folkert van Heusden <folkert@vanheusden.com>
Subject: And another Oops / BUG? (2.6.17.8 on VIA Epia CL6000)
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=8300CC02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Again my CL6000 Oopsed.
Again named was involved.
Again I cannot locate the cause.
The log is below as it was pushed through ksymoops, providing a map and
vlinux file.

How can I proceed to find the cause?

Kidn regards,
Udo

Aug 16 04:05:35 epia kernel: BUG: unable to handle kernel paging request
at virtual address 4e2aad0b
Aug 16 04:05:35 epia kernel:  printing eip:
Aug 16 04:05:35 epia kernel: 4e2aad0b
Aug 16 04:05:35 epia kernel: *pde = 17493067
Aug 16 04:05:35 epia kernel: *pte = 00000000
Aug 16 04:05:35 epia kernel: Oops: 0000 [#1]
Aug 16 04:05:35 epia kernel: PREEMPT
Aug 16 04:05:35 epia kernel: Modules linked in: vfat fat sg usb_storage
scsi_mod ub sch_tbf xt_string xt_MARK xt_length xt_tcpmss xt_mac xt_mark
vt1211 hwmon_vid i2c_isa ipv6 ipt_ttl ipt_owner ip_nat_irc
ip_conntrack_irc ipt_REDIRECT ipt_tos ip_nat_ftp ip_conntrack_ftp
ip_nat_h323 ip_conntrack_h323 ipt_MASQUERADE ipt_LOG ipt_TCPMSS
ipt_REJECT xt_limit xt_state ipt_TARPIT iptable_filter ipt_TOS
iptable_mangle xt_NOTRACK iptable_raw binfmt_misc lp parport_pc parport
nvram ehci_hcd snd_via82xx snd_ac97_codec snd_ac97_bus uhci_hcd
snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart
snd_rawmidi snd_seq_device snd i2c_viapro
Aug 16 04:05:35 epia kernel: CPU:    0
Aug 16 04:05:35 epia kernel: EIP:
0060:[phys_startup_32+1310371083/-1073741824]    Not tainted VLI
Aug 16 04:05:35 epia kernel: EIP:    0060:[<4e2aad0b>]    Not tainted VLI
Aug 16 04:05:35 epia kernel: EFLAGS: 00010296   (2.6.17.8 #12)
Aug 16 04:05:35 epia kernel: EIP is at 0x4e2aad0b
Aug 16 04:05:35 epia kernel: eax: 00000000   ebx: 93bf9812   ecx:
0000000d   edx: 00000001
Aug 16 04:05:35 epia kernel: esi: 881a4646   edi: 28462d61   ebp:
5264e26e   esp: dbf2ff28
Aug 16 04:05:35 epia kernel: ds: 007b   es: 007b   ss: 0068
Aug 16 04:05:35 epia kernel: Process named (pid: 1613,
threadinfo=dbf2e000 task=ddf49a70)
Aug 16 04:05:35 epia kernel: Stack: a8eeb915 ac5f96d2 a6a7fa48 07747a07
2e8a8f29 0b278443 f4d0058f 5ddb9729
Aug 16 04:05:35 epia kernel:        e5192a07 f5a4118b 0c192206 1735c0fb
f5e9cf9a f49cf89e a781aef5 8ed4bd64
Aug 16 04:05:35 epia kernel:        3a730230 b41b1fcf f03ef9a4 a23392c2
ee21f54a 1136953c c5eb4177 59fc2579
Aug 16 04:05:36 epia kernel: Call Trace:
Reading Oops report from the terminal
Aug 16 04:05:35 epia kernel: BUG: unable to handle kernel paging request
at virtual address 4e2aad0bAug 16 04:05:36 epia kernel:  <c0103675>
show_stack_log_lvl+0x85/0x90  <c010380b> show_registers+0x14b/0x1c0
Aug 16 04:05:36 epia kernel:  <c01039e2> die+0x162/0x240  <c010f7d1>
do_page_fault+0x441/0x524
Aug 16 04:05:36 epia kernel:  <c010308f> error_code+0x4f/0x60
Aug 16 04:05:36 epia kernel: Code:  Bad EIP value.
Aug 16 04:05:36 epia kernel: EIP:
[phys_startup_32+1310371083/-1073741824] 0x4e2aad0b SS:ESP 0068:dbf2ff28
Aug 16 04:05:36 epia kernel: EIP: [<4e2aad0b>] 0x4e2aad0b SS:ESP
0068:dbf2ff28

Aug 16 04:05:35 epia kernel: 4e2aad0b
Aug 16 04:05:35 epia kernel: *pde = 17493067
Aug 16 04:05:35 epia kernel: Oops: 0000 [#1]
Aug 16 04:05:35 epia kernel: CPU:    0
Aug 16 04:05:35 epia kernel: EIP:
0060:[phys_startup_32+1310371083/-1073741824]    Not tainted VLI
Aug 16 04:05:35 epia kernel: EIP:    0060:[<4e2aad0b>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
Aug 16 04:05:35 epia kernel: EFLAGS: 00010296   (2.6.17.8 #12)
Aug 16 04:05:35 epia kernel: eax: 00000000   ebx: 93bf9812   ecx:
0000000d   edx: 00000001
Aug 16 04:05:35 epia kernel: esi: 881a4646   edi: 28462d61   ebp:
5264e26e   esp: dbf2ff28
Aug 16 04:05:35 epia kernel: ds: 007b   es: 007b   ss: 0068
Aug 16 04:05:35 epia kernel: Stack: a8eeb915 ac5f96d2 a6a7fa48 07747a07
2e8a8f29 0b278443 f4d0058f 5ddb9729
Aug 16 04:05:35 epia kernel:        e5192a07 f5a4118b 0c192206 1735c0fb
f5e9cf9a f49cf89e a781aef5 8ed4bd64
Aug 16 04:05:35 epia kernel:        3a730230 b41b1fcf f03ef9a4 a23392c2
ee21f54a 1136953c c5eb4177 59fc2579
Aug 16 04:05:36 epia kernel: Call Trace:
Aug 16 04:05:36 epia kernel:  <c0103675> show_stack_log_lvl+0x85/0x90
<c010380b> show_registers+0x14b/0x1c0
Aug 16 04:05:36 epia kernel:  <c01039e2> die+0x162/0x240  <c010f7d1>
do_page_fault+0x441/0x524
Aug 16 04:05:36 epia kernel:  <c010308f> error_code+0x4f/0x60
Aug 16 04:05:36 epia kernel: Code:  Bad EIP value.


>>EIP; 4e2aad0b <phys_startup_32+4e1aad0b/c0000000>   <=====

>>ebx; 93bf9812 <phys_startup_32+93af9812/c0000000>
>>esi; 881a4646 <phys_startup_32+880a4646/c0000000>
>>edi; 28462d61 <phys_startup_32+28362d61/c0000000>
>>ebp; 5264e26e <phys_startup_32+5254e26e/c0000000>
>>esp; dbf2ff28 <pg0+1badef28/3fbad400>

Trace; c0103675 <show_stack_log_lvl+85/90>
Trace; c01039e2 <die+162/240>
Trace; c010308f <error_code+4f/60>

Aug 16 04:05:36 epia kernel: EIP:
[phys_startup_32+1310371083/-1073741824] 0x4e2aad0b SS:ESP 0068:dbf2ff28
Aug 16 04:05:36 epia kernel: EIP: [<4e2aad0b>] 0x4e2aad0b SS:ESP
0068:dbf2ff28
