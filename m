Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWDJP0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWDJP0n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 11:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWDJP0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 11:26:43 -0400
Received: from sa12.bezeqint.net ([192.115.104.27]:11457 "EHLO
	sa12.bezeqint.net") by vger.kernel.org with ESMTP id S1750839AbWDJP0n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 11:26:43 -0400
From: Shlomi Fish <shlomif@iglu.org.il>
To: linux-kernel@vger.kernel.org
Subject: Two OOPSes in ALSA with kernel-2.6.17-rc1
Date: Mon, 10 Apr 2006 18:23:54 +0300
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604101823.54600.shlomif@iglu.org.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

(Please CC me on the replies)

I recently received these two OOPSes with kernel-2.6.17-rc1. They happened 
while mpg123 was playing a WAV file and I invoked KDE (along with artsd).

My soundcard is snd_intel8x0.

Let me know if you need any other information.

Regards,

	Shlomi Fish

BUG: unable to handle kernel NULL pointer dereference at virtual address 
00000098
 printing eip:
e09c4d2c
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in: binfmt_misc autofs4 ipv6 snd_seq_dummy snd_seq_oss 
snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss 
snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd 
soundcore 8139too mii af_packet floppy ide_cd cdrom loop nls_cp1255 nls_cp862 
vfat fat hw_random usbhid video thermal processor fan button battery ac 
ehci_hcd uhci_hcd usbcore
CPU:    1
EIP:    0060:[<e09c4d2c>]    Not tainted VLI
EFLAGS: 00210282   (2.6.17-rc1 #1) 
EIP is at snd_pcm_mmap_status_nopage+0x17/0x4e [snd_pcm]
eax: 00000000   ebx: d3257f58   ecx: ffffffff   edx: b7f8d000
esi: 00000000   edi: 00000000   ebp: d3257f1c   esp: d3257f18
ds: 007b   es: 007b   ss: 0068
Process artsd (pid: 24484, threadinfo=d3256000 task=dfc69580)
Stack: <0>d7cb1e34 d3257f68 c013ec2a df939d84 b7f8d000 d3257f58 00000e34 
d33dbb7c 
       00200246 dc4bf580 00000000 00000000 bf8d461c d3257f68 00000002 d3256000 
       00000002 d1c79af4 d1c79ac0 df939d84 d3257fb4 c0111d85 d1c79ac0 df939d84 
Call Trace:
 <c0103996> show_stack_log_lvl+0x8b/0x95   <c0103af5> 
show_registers+0x155/0x1c6
 <c0103e3d> die+0x16e/0x1f3   <c0111fc6> do_page_fault+0x458/0x53e
 <c01033fb> error_code+0x4f/0x54   <c013ec2a> __handle_mm_fault+0x246/0x6cd
 <c0111d85> do_page_fault+0x217/0x53e   <c01033fb> error_code+0x4f/0x54
Code: e8 98 69 79 df 83 c4 10 85 c0 ba 00 00 00 00 0f 49 c2 c9 c3 55 89 e5 53 
8b 5d 10 8b 45 08 8b 40 50 83 c9 ff 85 c0 74 35 8b 40 5c <8b> 88 98 00 00 00 
81 c1 00 00 00 40 c1 e9 0c c1 e1 05 03 0d 40 
 <1>BUG: unable to handle kernel NULL pointer dereference at virtual address 
000000a0
 printing eip:
e09c43f8
*pde = 00000000
Oops: 0002 [#2]
PREEMPT SMP 
Modules linked in: binfmt_misc autofs4 ipv6 snd_seq_dummy snd_seq_oss 
snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss 
snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd 
soundcore 8139too mii af_packet floppy ide_cd cdrom loop nls_cp1255 nls_cp862 
vfat fat hw_random usbhid video thermal processor fan button battery ac 
ehci_hcd uhci_hcd usbcore
CPU:    1
EIP:    0060:[<e09c43f8>]    Not tainted VLI
EFLAGS: 00210282   (2.6.17-rc1 #1) 
EIP is at snd_pcm_mmap_data_close+0xc/0x15 [snd_pcm]
eax: 00000000   ebx: dfd674ec   ecx: 00000000   edx: d30dff94
esi: dfd67ee4   edi: d1c79ac0   ebp: d3257dd8   esp: d3257dd8
ds: 007b   es: 007b   ss: 0068
Process artsd (pid: 24484, threadinfo=d3256000 task=dfc69580)
Stack: <0>d3257dec c013fc26 dfd674ec c140b0a0 dfd674ec d3257e08 c0140086 
000001e7 
       c140b0a0 d1c79ac0 d1c79af4 dfc69580 d3257e1c c0117094 d1c79ac0 d1c79ac0 
       d1c79af4 d3257e38 c011a558 d1c79ac0 dfc69a14 d3256000 dfc69580 dfc69580 
Call Trace:
 <c0103996> show_stack_log_lvl+0x8b/0x95   <c0103af5> 
show_registers+0x155/0x1c6
 <c0103e3d> die+0x16e/0x1f3   <c0111fc6> do_page_fault+0x458/0x53e
 <c01033fb> error_code+0x4f/0x54   <c013fc26> remove_vma+0x1b/0x3d
 <c0140086> exit_mmap+0xe1/0x100   <c0117094> mmput+0x20/0x7e
 <c011a558> exit_mm+0xfb/0x104   <c011b24d> do_exit+0x1a7/0x766
 <c0103eba> die+0x1eb/0x1f3   <c0111fc6> do_page_fault+0x458/0x53e
 <c01033fb> error_code+0x4f/0x54   <c013ec2a> __handle_mm_fault+0x246/0x6cd
 <c0111d85> do_page_fault+0x217/0x53e   <c01033fb> error_code+0x4f/0x54
Code: c3 8e df 5a 59 e9 33 f2 ff ff 66 4a 0f 85 6f f2 ff ff 51 e8 bd 44 83 df 
59 e9 63 f2 ff ff 90 55 89 e5 8b 45 08 8b 40 50 8b 40 5c <f0> ff 88 a0 00 00 
00 5d c3 55 89 e5 53 89 c2 8b 58 5c 8b 03 85 
 <1>Fixing recursive fault but reboot is needed!

---------------------------------------------------------------------
Shlomi Fish      shlomif@iglu.org.il
Homepage:        http://www.shlomifish.org/

95% of the programmers consider 95% of the code they did not write, in the
bottom 5%.
