Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265331AbUGMPPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUGMPPq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 11:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265315AbUGMPPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 11:15:45 -0400
Received: from mail.aei.ca ([206.123.6.14]:38119 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S265331AbUGMPPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 11:15:35 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Shane Shrybman <shrybman@aei.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1089731816.2530.16.camel@mars>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 11:16:56 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more alsa xrun debug messages with SB Live and onboard via
soundcards, v4l was in use too.

2.6.7-mm7, UP, XP 2500, aic7xxx scsi.

Tried to edit out a lot of the duplicates, the first one appeared very
frequently.

Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 0
ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0p
 [<e08ed360>] snd_pcm_period_elapsed+0x2f0/0x3c0 [snd_pcm]
 [<e0915b58>] gcc2_compiled.+0x18/0x20 [snd_emu10k1]
 [<e091415f>] gcc2_compiled.+0xef/0x2e0 [snd_emu10k1]
 [<c0107b51>] handle_IRQ_event+0x31/0x60
 [<c0107ea3>] do_IRQ+0xb3/0x150
 [<c010662c>] common_interrupt+0x18/0x20
ALSA sound/pci/via82xx.c:731: invalid via82xx_cur_ptr, using last valid
pointer
There is already a security framework initialized, register_security
failed.
selinux_register_security:  Registering secondary module realtime
Realtime LSM initialized (all groups, mlock=1)
ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0p
 [<e08ed360>] snd_pcm_period_elapsed+0x2f0/0x3c0 [snd_pcm]
 [<e0915b58>] gcc2_compiled.+0x18/0x20 [snd_emu10k1]
 [<e091415f>] gcc2_compiled.+0xef/0x2e0 [snd_emu10k1]
 [<c0107b51>] handle_IRQ_event+0x31/0x60
 [<c0107ea3>] do_IRQ+0xb3/0x150
 [<c0104030>] default_idle+0x0/0x30
 [<c010662c>] common_interrupt+0x18/0x20
 [<c0104030>] default_idle+0x0/0x30
 [<c0104053>] default_idle+0x23/0x30
 [<c01040de>] cpu_idle+0x2e/0x40
 [<c0100387>] rest_init+0x57/0x60
 [<c041c73c>] start_kernel+0x18c/0x1a0
ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0c
 [<e08ed360>] snd_pcm_period_elapsed+0x2f0/0x3c0 [snd_pcm]
 [<c0120a27>] __mod_timer+0x157/0x170
 [<e0915b70>] snd_emu10k1_pcm_ac97adc_interrupt+0x10/0x20 [snd_emu10k1]
 [<e09141a7>] gcc2_compiled.+0x137/0x2e0 [snd_emu10k1]
 [<c0107b51>] handle_IRQ_event+0x31/0x60
 [<c0107ea3>] do_IRQ+0xb3/0x150
 [<c0104030>] default_idle+0x0/0x30
 [<c010662c>] common_interrupt+0x18/0x20
 [<c0104030>] default_idle+0x0/0x30
 [<c0104053>] default_idle+0x23/0x30
 [<c01040de>] cpu_idle+0x2e/0x40
 [<c0100387>] rest_init+0x57/0x60
 [<c041c73c>] start_kernel+0x18c/0x1a0
ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0p
 [<e08ed360>] snd_pcm_period_elapsed+0x2f0/0x3c0 [snd_pcm]
 [<e0915b58>] gcc2_compiled.+0x18/0x20 [snd_emu10k1]
 [<e091415f>] gcc2_compiled.+0xef/0x2e0 [snd_emu10k1]
 [<c0107b51>] handle_IRQ_event+0x31/0x60
 [<c0107ea3>] do_IRQ+0xb3/0x150
 [<c010662c>] common_interrupt+0x18/0x20

ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0p
 [<e08ed360>] snd_pcm_period_elapsed+0x2f0/0x3c0 [snd_pcm]
 [<e0915b58>] gcc2_compiled.+0x18/0x20 [snd_emu10k1]
 [<e091415f>] gcc2_compiled.+0xef/0x2e0 [snd_emu10k1]
 [<c0107b51>] handle_IRQ_event+0x31/0x60
 [<c0107ea3>] do_IRQ+0xb3/0x150
 [<c010662c>] common_interrupt+0x18/0x20
 [<c01d08e4>] fast_clear_page+0x24/0x60
 [<c01d0a66>] mmx_clear_page+0x26/0x30
 [<c013ee13>] do_anonymous_page+0x83/0x180
 [<c013ef61>] do_no_page+0x51/0x320
 [<c011549f>] pte_alloc_one+0x2f/0x40
 [<c013f36d>] handle_mm_fault+0x6d/0x140
 [<c013dfac>] get_user_pages+0x22c/0x3c0
 [<c013f4e9>] make_pages_present+0x69/0x90
 [<c0140d04>] do_mmap_pgoff+0x564/0x650
 [<c010bc46>] sys_mmap2+0x66/0xa0
 [<c0105c6d>] sysenter_past_esp+0x52/0x71


ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0p
 [<e08ed360>] snd_pcm_period_elapsed+0x2f0/0x3c0 [snd_pcm]
 [<e0915b58>] gcc2_compiled.+0x18/0x20 [snd_emu10k1]
 [<e091415f>] gcc2_compiled.+0xef/0x2e0 [snd_emu10k1]
 [<c0107b51>] handle_IRQ_event+0x31/0x60
 [<c0107ea3>] do_IRQ+0xb3/0x150
 [<c0104030>] default_idle+0x0/0x30
 [<c010662c>] common_interrupt+0x18/0x20
 [<c0104030>] default_idle+0x0/0x30
 [<c0104053>] default_idle+0x23/0x30
 [<c01040de>] cpu_idle+0x2e/0x40
 [<c0100387>] rest_init+0x57/0x60
 [<c041c73c>] start_kernel+0x18c/0x1a0
ALSA sound/pci/via82xx.c:731: invalid via82xx_cur_ptr, using last valid
pointer
ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0p
 [<e08ed360>] snd_pcm_period_elapsed+0x2f0/0x3c0 [snd_pcm]
 [<e0915b58>] gcc2_compiled.+0x18/0x20 [snd_emu10k1]
 [<e091415f>] gcc2_compiled.+0xef/0x2e0 [snd_emu10k1]
 [<c0107b51>] handle_IRQ_event+0x31/0x60
 [<c0107ea3>] do_IRQ+0xb3/0x150
 [<c0104030>] default_idle+0x0/0x30
 [<c010662c>] common_interrupt+0x18/0x20
 [<c0104030>] default_idle+0x0/0x30
 [<c0104053>] default_idle+0x23/0x30
 [<c01040de>] cpu_idle+0x2e/0x40
 [<c0100387>] rest_init+0x57/0x60
 [<c041c73c>] start_kernel+0x18c/0x1a0
ALSA sound/pci/via82xx.c:731: invalid via82xx_cur_ptr, using last valid
pointer
ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0p
 [<e08ed360>] snd_pcm_period_elapsed+0x2f0/0x3c0 [snd_pcm]
 [<e0915b58>] gcc2_compiled.+0x18/0x20 [snd_emu10k1]
 [<e091415f>] gcc2_compiled.+0xef/0x2e0 [snd_emu10k1]
 [<c0107b51>] handle_IRQ_event+0x31/0x60
 [<c0107ea3>] do_IRQ+0xb3/0x150
 [<c0104030>] default_idle+0x0/0x30
 [<c010662c>] common_interrupt+0x18/0x20
 [<c0104030>] default_idle+0x0/0x30
 [<c0104053>] default_idle+0x23/0x30
 [<c01040de>] cpu_idle+0x2e/0x40
 [<c0100387>] rest_init+0x57/0x60
 [<c041c73c>] start_kernel+0x18c/0x1a0
ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0p
 [<e08ed360>] snd_pcm_period_elapsed+0x2f0/0x3c0 [snd_pcm]
 [<e0915b58>] gcc2_compiled.+0x18/0x20 [snd_emu10k1]
 [<e091415f>] gcc2_compiled.+0xef/0x2e0 [snd_emu10k1]
 [<c0107b51>] handle_IRQ_event+0x31/0x60
 [<c0107ea3>] do_IRQ+0xb3/0x150
 [<c0104030>] default_idle+0x0/0x30
 [<c010662c>] common_interrupt+0x18/0x20
 [<c0104030>] default_idle+0x0/0x30
 [<c0104053>] default_idle+0x23/0x30
 [<c01040de>] cpu_idle+0x2e/0x40
 [<c0100387>] rest_init+0x57/0x60
 [<c041c73c>] start_kernel+0x18c/0x1a0
ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0p
 [<e08ed360>] snd_pcm_period_elapsed+0x2f0/0x3c0 [snd_pcm]
 [<e0915b58>] gcc2_compiled.+0x18/0x20 [snd_emu10k1]
 [<e091415f>] gcc2_compiled.+0xef/0x2e0 [snd_emu10k1]
 [<c0107b51>] handle_IRQ_event+0x31/0x60
 [<c0107ea3>] do_IRQ+0xb3/0x150
 [<c010662c>] common_interrupt+0x18/0x20
ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0p
 [<e08ed360>] snd_pcm_period_elapsed+0x2f0/0x3c0 [snd_pcm]
 [<e0915b58>] gcc2_compiled.+0x18/0x20 [snd_emu10k1]
 [<e091415f>] gcc2_compiled.+0xef/0x2e0 [snd_emu10k1]
 [<c0107b51>] handle_IRQ_event+0x31/0x60
 [<c0107ea3>] do_IRQ+0xb3/0x150
 [<c0104030>] default_idle+0x0/0x30
 [<c010662c>] common_interrupt+0x18/0x20
 [<c0104030>] default_idle+0x0/0x30
 [<c0104053>] default_idle+0x23/0x30
 [<c01040de>] cpu_idle+0x2e/0x40
 [<c0100387>] rest_init+0x57/0x60
 [<c041c73c>] start_kernel+0x18c/0x1a0

ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0p
 [<e08ed360>] snd_pcm_period_elapsed+0x2f0/0x3c0 [snd_pcm]
 [<e0915b58>] gcc2_compiled.+0x18/0x20 [snd_emu10k1]
 [<e091415f>] gcc2_compiled.+0xef/0x2e0 [snd_emu10k1]
 [<c0107b51>] handle_IRQ_event+0x31/0x60
 [<c0107ea3>] do_IRQ+0xb3/0x150
 [<c0104030>] default_idle+0x0/0x30
 [<c010662c>] common_interrupt+0x18/0x20
 [<c0104030>] default_idle+0x0/0x30
 [<c0104053>] default_idle+0x23/0x30
 [<c01040de>] cpu_idle+0x2e/0x40
 [<c0100387>] rest_init+0x57/0x60
 [<c041c73c>] start_kernel+0x18c/0x1a0


ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0c
 [<e08ed360>] snd_pcm_period_elapsed+0x2f0/0x3c0 [snd_pcm]
 [<c01169f0>] try_to_wake_up+0x20/0xb0
 [<e0915b70>] snd_emu10k1_pcm_ac97adc_interrupt+0x10/0x20 [snd_emu10k1]
 [<e09141a7>] gcc2_compiled.+0x137/0x2e0 [snd_emu10k1]
 [<c0107b51>] handle_IRQ_event+0x31/0x60
 [<c0107ea3>] do_IRQ+0xb3/0x150
 [<c010662c>] common_interrupt+0x18/0x20
 [<c01d0dca>] __copy_to_user_ll+0x4a/0x70
 [<c01d0e8f>] copy_to_user+0x2f/0x40
 [<c028fb9c>] memcpy_toiovec+0x2c/0x60
 [<c02e34ed>] unix_stream_recvmsg+0x24d/0x3d0
 [<c028a63b>] sock_aio_read+0x11b/0x130
 [<c013505e>] free_pages+0x2e/0x30
 [<c014bb1a>] do_sync_read+0x7a/0xb0
 [<c014bc14>] vfs_read+0xc4/0xf0
 [<c014be11>] sys_read+0x31/0x50
 [<c0105c6d>] sysenter_past_esp+0x52/0x71


ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0c
 [<e08ed360>] snd_pcm_period_elapsed+0x2f0/0x3c0 [snd_pcm]
 [<c0116a1f>] try_to_wake_up+0x4f/0xb0
 [<e0915b70>] snd_emu10k1_pcm_ac97adc_interrupt+0x10/0x20 [snd_emu10k1]
 [<e09141a7>] gcc2_compiled.+0x137/0x2e0 [snd_emu10k1]
 [<c0107b51>] handle_IRQ_event+0x31/0x60
 [<c0107ea3>] do_IRQ+0xb3/0x150
 [<c010662c>] common_interrupt+0x18/0x20
 [<c02e32c1>] unix_stream_recvmsg+0x21/0x3d0
 [<c01bc656>] selinux_socket_recvmsg+0x16/0x20
 [<c028a63b>] sock_aio_read+0x11b/0x130
 [<c014bb1a>] do_sync_read+0x7a/0xb0
 [<c014bc14>] vfs_read+0xc4/0xf0
 [<c014be11>] sys_read+0x31/0x50
 [<c0105c6d>] sysenter_past_esp+0x52/0x71

ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0c
 [<e08ed360>] snd_pcm_period_elapsed+0x2f0/0x3c0 [snd_pcm]
 [<c0122ca0>] send_group_sig_info+0x20/0x40
 [<e0915b70>] snd_emu10k1_pcm_ac97adc_interrupt+0x10/0x20 [snd_emu10k1]
 [<e09141a7>] gcc2_compiled.+0x137/0x2e0 [snd_emu10k1]
 [<c0107b51>] handle_IRQ_event+0x31/0x60
 [<c0107ea3>] do_IRQ+0xb3/0x150
 [<c010662c>] common_interrupt+0x18/0x20
 [<c013d024>] blk_queue_bounce+0x4/0x50
 [<c0220416>] __make_request+0x46/0x4d0
 [<c02209d2>] generic_make_request+0x132/0x150
 [<c01182d0>] autoremove_wake_function+0x0/0x40
 [<c0220a9b>] submit_bio+0xab/0xc0
 [<c0150508>] bio_alloc+0x128/0x1b0
 [<c014fea8>] submit_bh+0xd8/0x100
 [<c014e1d2>] __bread_slow+0x42/0x80
 [<c014e465>] __bread+0x25/0x30
 [<c0180094>] ext3_get_branch+0x64/0xf0
 [<c0180646>] ext3_get_block_handle+0x96/0x2b0
 [<c0150242>] alloc_buffer_head+0x12/0x50
 [<c01808c0>] ext3_get_block+0x60/0x70
 [<c014eb13>] __block_prepare_write+0x133/0x380
 [<c018d75e>] new_handle+0xe/0x50
 [<c014f481>] block_prepare_write+0x21/0x40
 [<c0180860>] ext3_get_block+0x0/0x70
 [<c0180d29>] ext3_prepare_write+0x59/0x110
 [<c0180860>] ext3_get_block+0x0/0x70
 [<c0132dc8>] generic_file_aio_write_nolock+0x6e8/0xa80
 [<c01ce5ba>] radix_tree_gang_lookup_tag+0x4a/0x60
 [<c01b7aea>] avc_has_perm_noaudit+0x12a/0x1c0
 [<c01b8f49>] inode_has_perm+0x69/0x80
 [<c0133253>] generic_file_aio_write+0x63/0x80
 [<c017eb4b>] ext3_file_write+0x2b/0xc0
 [<c014bcba>] do_sync_write+0x7a/0xb0
 [<c014bda5>] vfs_write+0xb5/0xf0
 [<c014be61>] sys_write+0x31/0x50
 [<c0105c6d>] sysenter_past_esp+0x52/0x71

ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0p
 [<e08ed360>] snd_pcm_period_elapsed+0x2f0/0x3c0 [snd_pcm]
 [<e0915b58>] gcc2_compiled.+0x18/0x20 [snd_emu10k1]
 [<e091415f>] gcc2_compiled.+0xef/0x2e0 [snd_emu10k1]
 [<c0107b51>] handle_IRQ_event+0x31/0x60
 [<c0107ea3>] do_IRQ+0xb3/0x150
 [<c010662c>] common_interrupt+0x18/0x20
 [<c01107d1>] get_offset_pmtmr+0x31/0x860
 [<c010b478>] do_gettimeofday+0x18/0xb0
 [<c011d1cc>] sys_gettimeofday+0x1c/0x60
 [<c0105c6d>] sysenter_past_esp+0x52/0x71

ALSA sound/pci/via82xx.c:731: invalid via82xx_cur_ptr, using last valid
pointer

Regards,

Shane


