Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbULRRIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbULRRIe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 12:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbULRRId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 12:08:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:5268 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261198AbULRRHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 12:07:41 -0500
Subject: [BUG] 2.6.10-rc3 snd-powermac crash
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 18 Dec 2004 18:07:28 +0100
Message-Id: <1103389648.5967.7.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi !

I get that regulary with latest kernel when using Alsa. Can't tell if it's new
as I used dmasound so far, just wanted to give Alsa a try...

Ben.

Oops: kernel access of bad area, sig: 11 [#1]
NIP: 00000000 LR: C278B664 SP: BA901DB0 REGS: ba901d00 TRAP: 0400    Not tainted
MSR: 40009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = bf4ef2a0[4821] 'gtkpbbuttons' THREAD: ba900000
Last syscall: 4
GPR00: 00000000 BA901DB0 BF4EF2A0 C2231000 00000FD7 00000000 00000000 C2550000
GPR08: C2231000 C2550000 00000001 00000000 00000001 1002317C 100C0000 100A0000
GPR16: 00000000 0022E480 00004002 00000000 00000000 00000800 BF384460 BB52A260
GPR24: 00000000 00000FD8 00000000 00000000 BAAE36AC BAAE3690 BAAE3620 00000800
NIP [00000000] 0x0
LR [c278b664] rate_transfer+0x80/0x88 [snd_pcm_oss]
Call trace:
 [c278b664] rate_transfer+0x80/0x88 [snd_pcm_oss]
 [c278853c] snd_pcm_plug_write_transfer+0xd4/0x14c [snd_pcm_oss]
 [c2783520] snd_pcm_oss_write2+0xb0/0x128 [snd_pcm_oss]
 [c27837b8] snd_pcm_oss_write1+0x220/0x26c [snd_pcm_oss]
 [c2785fec] snd_pcm_oss_write+0x64/0xb4 [snd_pcm_oss]
 [8005c620] vfs_write+0xdc/0x128
 [8005c750] sys_write+0x50/0x94
 [800042e0] ret_from_syscall+0x0/0x44
benh@gaston:~$


-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

