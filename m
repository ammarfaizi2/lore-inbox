Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVC1MJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVC1MJG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 07:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVC1MJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 07:09:06 -0500
Received: from smtp05.web.de ([217.72.192.209]:25559 "EHLO smtp05.web.de")
	by vger.kernel.org with ESMTP id S261559AbVC1MIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 07:08:43 -0500
Subject: Kernel OOOPS in 2.6.11.6
From: Ali Akcaagac <aliakc@web.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 28 Mar 2005 13:09:01 +0200
Message-Id: <1112008141.17962.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

And happy easter to you all. Just got this while trying to delete some
files on my system.

:  printing eip:
: c021f089
: *pde = 00000000
: Oops: 0000 [#1]
: PREEMPT 
: Modules linked in: snd_seq_midi snd_emu10k1_synth snd_emux_synth
snd_seq_virmidi snd_seq_midi_event snd_seq_midi_emul snd_seq snd_emu10k1
snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer
snd_page_alloc snd_util_mem snd_hwdep snd soundcore parport_pc lp
parport 8139too mii crc32
: CPU:    0
: EIP:    0060:[linvfs_open+89/160]    Not tainted VLI
: EFLAGS: 00010282   (2.6.11.6) 
: EIP is at linvfs_open+0x59/0xa0
: eax: 00000000   ebx: c77ac06c   ecx: 00000001   edx: c021f030
: esi: 00000000   edi: c77ac050   ebp: dffe41a0   esp: c2d95f14
: ds: 007b   es: 007b   ss: 0068
: Process mc (pid: 17862, threadinfo=c2d94000 task=d18d2a80)
: Stack: c01561a9 dffe41a0 d73504c0 00000000 c77ac06c c015446b c77ac06c
d73504c0 
:        00000001 ffffffe9 00008000 00008000 dc364000 c2d94000 c015426c
cbcdff54 
:        dffe41a0 00008000 c2d95f60 cbcdff54 dffe41a0 bfffeef0 0d00ad72
00300001 
: Call Trace:
:  [get_empty_filp+89/208] get_empty_filp+0x59/0xd0
:  [dentry_open+491/672] dentry_open+0x1eb/0x2a0
:  [filp_open+92/112] filp_open+0x5c/0x70
:  [get_unused_fd+123/224] get_unused_fd+0x7b/0xe0
:  [sys_open+73/144] sys_open+0x49/0x90
:  [syscall_call+7/11] syscall_call+0x7/0xb
: Code: 5b 3c b8 01 00 00 00 e8 c6 42 ef ff b8 00 e0 ff ff 21 e0 8b 40
08 a8 08 75 4d 85 f6 7c 0a 7f 32 81 fb ff ff ff 7f 77 2a 8b 47 14 <8b>
50 08 c7 44 24 04 00 00 00 00 89 04 24 ff 52 04 8b 5c 24 08 


