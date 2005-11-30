Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751522AbVK3TlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbVK3TlE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 14:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbVK3TlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 14:41:04 -0500
Received: from outbound04.telus.net ([199.185.220.223]:63419 "EHLO
	priv-edtnes28.telusplanet.net") by vger.kernel.org with ESMTP
	id S1751522AbVK3TlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 14:41:02 -0500
Message-ID: <438E0187.2060107@telusplanet.net>
Date: Wed, 30 Nov 2005 12:46:15 -0700
From: Bob Gill <gillb4@telusplanet.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: Merely a warning to my fellow Nvidia travellers running 2.6.15-rc3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This error message is merely a warning to my fellow Nvidia travellers.  
Posts have already been sent to people who have the source code to fix 
this, and this message is merely information for Nvidia users.  If you 
are an Nvidia user trying to use 2.6.15-rc3 with the 7667 driver, beware 
that the following can occur:
Nov 30 11:55:25 localhost kernel: ------------[ cut here ]------------
Nov 30 11:55:25 localhost kernel: PREEMPT
Nov 30 11:55:25 localhost kernel: Modules linked in: nvidia microcode 
imm snd_emu10k1_synth snd_emux_synth snd_seq_oss raw1394 snd_pcm_oss 
snd_mixer_oss snd_seq_virmidi snd_seq_midi_emul snd_seq_midi 
snd_seq_midi_event snd_seq_dummy snd_seq 8250_pnp 8250 serial_core rtc 
tuner bttv video_buf i2c_algo_bit v4l2_common btcx_risc tveeprom 
videodev snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm 
snd_timer snd_ac97_bus snd_page_alloc snd_util_mem snd_hwdep snd 
soundcore i2c_sis96x i2c_core sis_agp agpgart usblp ohci_hcd usbcore 
sis900 mii ohci1394 sr_mod sd_mod sbp2 scsi_mod ieee1394
Nov 30 11:55:25 localhost kernel: CPU:    0
Nov 30 11:55:25 localhost kernel: EIP:    
0060:[page_remove_rmap+50/60]    Tainted: P      VLI
Nov 30 11:55:25 localhost kernel: EFLAGS: 00210286   (2.6.15-rc3)
Nov 30 11:55:25 localhost kernel: EIP is at page_remove_rmap+0x32/0x3c
Nov 30 11:55:25 localhost kernel: eax: ffffffff   ebx: e3a30e98   ecx: 
c1439200   edx: c1439200
Nov 30 11:55:25 localhost kernel: esi: b7fa6000   edi: c1439200   ebp: 
e85d1e38   esp: e85d1d98
Nov 30 11:55:25 localhost kernel: ds: 007b   es: 007b   ss: 0068
Nov 30 11:55:25 localhost kernel: Process engine (pid: 6745, 
threadinfo=e85d0000 task=e2c6b030)
Nov 30 11:55:25 localhost kernel: Stack: b7fa6000 e3a30e98 c0144dbf 
c1439200 b7fa6000 21c90067 21c90067 00000000
Nov 30 11:55:25 localhost kernel:        ffffffff e2cf0500 b7faa000 
e3a6db7c b7faa000 e85d1e38 c0144f46 c03b5cec
Nov 30 11:55:25 localhost kernel:        e22a5ac4 e3a6db7c b7fa6000 
b7faa000 e85d1e38 00000000 b7fa9fff e3a6db7c
Nov 30 11:55:25 localhost kernel: Call Trace:
Nov 30 11:55:25 localhost kernel:  [zap_pte_range+362/560] 
zap_pte_range+0x16a/0x230
Nov 30 11:55:25 localhost kernel:  [unmap_page_range+193/290] 
unmap_page_range+0xc1/0x122
Nov 30 11:55:25 localhost kernel:  [unmap_vmas+236/456] 
unmap_vmas+0xec/0x1c8
Nov 30 11:55:25 localhost kernel:  [exit_mmap+120/263] exit_mmap+0x78/0x107
Nov 30 11:55:25 localhost kernel:  [mmput+55/160] mmput+0x37/0xa0
Nov 30 11:55:25 localhost kernel:  [do_exit+237/1075] do_exit+0xed/0x433
Nov 30 11:55:25 localhost kernel:  [do_group_exit+56/167] 
do_group_exit+0x38/0xa7
Nov 30 11:55:25 localhost kernel:  [get_signal_to_deliver+516/772] 
get_signal_to_deliver+0x204/0x304
Nov 30 11:55:25 localhost kernel:  [do_signal+145/277] do_signal+0x91/0x115
Nov 30 11:55:25 localhost kernel:  [ide_end_request+114/144] 
ide_end_request+0x72/0x90
Nov 30 11:55:25 localhost kernel:  [elv_queue_empty+42/44] 
elv_queue_empty+0x2a/0x2c
Nov 30 11:55:25 localhost kernel:  [ide_do_request+119/896] 
ide_do_request+0x77/0x380
Nov 30 11:55:25 localhost kernel:  [ide_intr+325/394] ide_intr+0x145/0x18a
Nov 30 11:55:25 localhost kernel:  [schedule+824/1553] schedule+0x338/0x611
Nov 30 11:55:25 localhost kernel:  [work_resched+5/22] work_resched+0x5/0x16
Nov 30 11:55:25 localhost kernel:  [__do_IRQ+184/241] __do_IRQ+0xb8/0xf1
Nov 30 11:55:25 localhost kernel:  [do_notify_resume+53/57] 
do_notify_resume+0x35/0x39
Nov 30 11:55:25 localhost kernel:  [work_notifysig+19/25] 
work_notifysig+0x13/0x19
Nov 30 11:55:25 localhost kernel: Code: 83 42 08 ff 0f 98 c0 84 c0 74 1c 
8b 42 08 83 c0 01 78 18 c7 44 24 04 ff ff ff ff c7 04 24 10 00 00 00 e8 
dd 00 ff ff 83 c4 08 c3 <0f> 0b e6 01 c5 33 2e c0 eb de 55 57 56 53 83 
ec 1c 8b 5c 24 34
Nov 30 11:55:25 localhost kernel:  <1>Fixing recursive fault but reboot 
is needed!
Nov 30 11:55:25 localhost kernel:  [schedule+1548/1553] schedule+0x60c/0x611
Nov 30 11:55:25 localhost kernel:  [work_notifysig+19/25] 
work_notifysig+0x13/0x19
Nov 30 11:55:25 localhost kernel:  [try_to_unmap_one+10/494] 
try_to_unmap_one+0xa/0x1ee
Nov 30 11:55:25 localhost kernel:  [do_exit+958/1075] do_exit+0x3be/0x433
Nov 30 11:55:25 localhost kernel:  [printk+23/27] printk+0x17/0x1b
Nov 30 11:55:25 localhost kernel:  [do_invalid_op+0/195] 
do_invalid_op+0x0/0xc3
Nov 30 11:55:25 localhost kernel:  [do_divide_error+0/195] 
do_divide_error+0x0/0xc3
Nov 30 11:55:25 localhost kernel:  [do_invalid_op+174/195] 
do_invalid_op+0xae/0xc3
Nov 30 11:55:25 localhost kernel:  [page_remove_rmap+50/60] 
page_remove_rmap+0x32/0x3c
Nov 30 11:55:25 localhost kernel:  [pg0+954584061/1069696000] 
_nv002168rm+0x1d/0x2c [nvidia]
Nov 30 11:55:25 localhost kernel:  [activate_task+109/128] 
activate_task+0x6d/0x80
Nov 30 11:55:25 localhost kernel:  [bad_range+52/73] bad_range+0x34/0x49
Nov 30 11:55:25 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
Nov 30 11:55:25 localhost kernel:  [page_remove_rmap+50/60] 
page_remove_rmap+0x32/0x3c
Nov 30 11:55:25 localhost kernel:  [zap_pte_range+362/560] 
zap_pte_range+0x16a/0x230
Nov 30 11:55:25 localhost kernel:  [unmap_page_range+193/290] 
unmap_page_range+0xc1/0x122
Nov 30 11:55:25 localhost kernel:  [unmap_vmas+236/456] 
unmap_vmas+0xec/0x1c8
Nov 30 11:55:25 localhost kernel:  [exit_mmap+120/263] exit_mmap+0x78/0x107
Nov 30 11:55:25 localhost kernel:  [mmput+55/160] mmput+0x37/0xa0
Nov 30 11:55:25 localhost kernel:  [do_exit+237/1075] do_exit+0xed/0x433
Nov 30 11:55:25 localhost kernel:  [do_group_exit+56/167] 
do_group_exit+0x38/0xa7
Nov 30 11:55:25 localhost kernel:  [get_signal_to_deliver+516/772] 
get_signal_to_deliver+0x204/0x304
Nov 30 11:55:25 localhost kernel:  [do_signal+145/277] do_signal+0x91/0x115
Nov 30 11:55:25 localhost kernel:  [ide_end_request+114/144] 
ide_end_request+0x72/0x90
Nov 30 11:55:25 localhost kernel:  [elv_queue_empty+42/44] 
elv_queue_empty+0x2a/0x2c
Nov 30 11:55:25 localhost kernel:  [ide_do_request+119/896] 
ide_do_request+0x77/0x380
Nov 30 11:55:25 localhost kernel:  [ide_intr+325/394] ide_intr+0x145/0x18a
Nov 30 11:55:25 localhost kernel:  [schedule+824/1553] schedule+0x338/0x611
Nov 30 11:55:25 localhost kernel:  [work_resched+5/22] work_resched+0x5/0x16
Nov 30 11:55:25 localhost kernel:  [__do_IRQ+184/241] __do_IRQ+0xb8/0xf1
Nov 30 11:55:25 localhost kernel:  [do_notify_resume+53/57] 
do_notify_resume+0x35/0x39
Nov 30 11:55:25 localhost kernel:  [work_notifysig+19/25] 
work_notifysig+0x13/0x19

.............as a result, its best to stick with with 2.6.15-rc2-git5 
till a new driver comes out.

Thanks,
Bob
