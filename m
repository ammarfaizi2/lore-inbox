Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbSJNLsv>; Mon, 14 Oct 2002 07:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbSJNLsv>; Mon, 14 Oct 2002 07:48:51 -0400
Received: from netlx009.civ.utwente.nl ([130.89.1.91]:63966 "EHLO
	netlx009.civ.utwente.nl") by vger.kernel.org with ESMTP
	id <S261593AbSJNLsu>; Mon, 14 Oct 2002 07:48:50 -0400
From: caligula@cam029208.student.utwente.nl
To: linux-kernel@vger.kernel.org
Subject: 2.5.42:  Debug: sleeping function called from illegal context at mm/slab.c:1374
Date: Mon, 14 Oct 2002 11:56:09 GMT
Reply-To: caligula@cam029208.student.utwente.nl
Message-ID: <3daaaf03.911341@cam029208.student.utwente.nl>
X-Mailer: Forte Free Agent 1.21/32.243
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ave people

When using xmms with oss output I found this message in my dmesg.
Kernel has alsa sound with oss emulation.

Full dmesg/kernelconfig/lspci can be found at
cam029208.student.utwente.nl/~caligula/kernel/

ALSA device list:
  #0: VIA 82C686A/B at 0xdc00, irq 10

Debug: sleeping function called from illegal context at mm/slab.c:1374
Call Trace:
 [<c0115042>] __might_sleep+0x52/0x60
 [<c012f8b1>] kmalloc+0x61/0x200
 [<c01f72b6>] snd_pci_hack_alloc_consistent+0x56/0xc0
 [<c01f3264>] __snd_kmalloc+0x14/0x80
 [<c01f32e0>] snd_hidden_kmalloc+0x10/0x20
 [<c022584d>] build_via_table+0x9d/0x1c0
 [<c022584d>] build_via_table+0x9d/0x1c0
 [<c0225dac>] snd_via82xx_setup_periods+0x2c/0x120
 [<c0226191>] snd_via82xx_playback_prepare+0xb1/0xc0
 [<c02093f7>] snd_pcm_prepare+0x127/0x230
 [<c020b97f>] snd_pcm_playback_ioctl1+0x3af/0x3c0
 [<c012ae5e>] find_get_page+0x1e/0x40
 [<c012bb83>] filemap_nopage+0x103/0x280
 [<c01327b9>] __alloc_pages+0x79/0x250
 [<c020be07>] snd_pcm_kernel_playback_ioctl+0x27/0x30
 [<c01fdab6>] snd_pcm_oss_prepare+0x16/0x60
 [<c01fdb38>] snd_pcm_oss_make_ready+0x38/0x50
 [<c01fdefa>] snd_pcm_oss_write1+0x3a/0x160
 [<c020005b>] snd_pcm_oss_write+0x6b/0xa0
 [<c013d8aa>] vfs_write+0xba/0x150
 [<c013d9a8>] sys_write+0x28/0x40
 [<c010716f>] syscall_call+0x7/0xb


