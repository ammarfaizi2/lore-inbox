Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266796AbUHQWIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266796AbUHQWIZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 18:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266810AbUHQWIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 18:08:25 -0400
Received: from as1-2-5.han.s.bonet.se ([194.236.155.59]:35335 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S266796AbUHQWIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 18:08:22 -0400
Date: Wed, 18 Aug 2004 00:08:18 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Subject: Oops modprobing i830 with 2.6.8.1
Message-ID: <20040817220816.GA14343@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just upgraded from 2.6.7 to 2.6.8.1 and experience the oops message 
below when i830 is modprobed.

Any ideas what might be wrong?

Regards,
David

PS
Not subscribed, please CC me on any replies

Oops message
============
[drm:i830_probe] *ERROR* Cannot initialize the agpgart module.
inter_module_unregister: no entry for 'drm'------------[ cut here ]------------
kernel BUG at kernel/intermodule.c:104!
invalid operand: 0000 [#1]
PREEMPT 
Modules linked in: i830 snd_pcm_oss snd_mixer_oss snd_intel8x0 
snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart 
snd_rawmidi snd rtc hw_random thermal processor fan button battery ac 
uhci_hcd ehci_hcd usbcore nvram
CPU:    0
EIP:    0060:[<c01277e6>]    Not tainted
EFLAGS: 00010282   (2.6.8.1) 
EIP is at inter_module_unregister+0x9b/0xe4
eax: 0000002e   ebx: d07bb7ef   ecx: c02cea90   edx: 00000282 
esi: 00000000   edi: 00000000   ebp: c02d00a0   esp: ce08bf14
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 1362, threadinfo=ce08a000 task=cec44840)
Stack: c029e5a0 d07bb7ef ffffffff 00000000 00000000 00000000 d07b5ed1 d07bb7ef 
       d07bb7ef d07bf020 d07bf020 cf60c800 d07bf69c d07b238a d07bb5e1 d07be720 
       d07bf020 00000000 00000000 00000010 cf60cc00 ce08a000 d07bee00 c02d0260 
Call Trace:
 [<d07b5ed1>] i830_stub_register+0xb9/0x1c8 [i830]
 [<d07b238a>] i830_probe+0xe0/0x27f [i830]
 [<c01b949a>] pci_find_device+0x2f/0x33
 [<d0709047>] drm_init+0x47/0x66 [i830]
 [<c012dbd1>] sys_init_module+0x117/0x22f 
 [<c0105f47>] syscall_call+0x7/0xb
Code: 0f 0b 68 00 c5 db 29 c0 eb de e8 b4 4f 16 00 eb be 8b 45 04
