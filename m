Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVB0PAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVB0PAt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 10:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVB0PAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 10:00:48 -0500
Received: from abo-131-24-69.mtz.modulonet.fr ([85.69.24.131]:46209 "EHLO
	gw.reolight.net") by vger.kernel.org with ESMTP id S261398AbVB0PAj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 10:00:39 -0500
Message-ID: <4221E08D.7000403@reolight.net>
Date: Sun, 27 Feb 2005 16:00:29 +0100
From: Auzanneau Gregory <greg@reolight.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: fr, fr-fr, en, en-gb, en-us
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kernel BUG at drivers/media/video/video-buf.c:226!
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Starting VideoLan on 2.6.8 with a bttv Pinnacle Studio Pro segfaults kernel.

Here the debug lines to diagnose the source of the problem.

------------[ cut here ]------------
kernel BUG at drivers/media/video/video-buf.c:226!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: thermal fan button processor ac battery af_packet
uhci_hcd oh
ci_hcd ehci_hcd usbcore 8139cp snd_bt87x tuner tda9887 msp3400 bttv
video_buf i2
c_algo_bit v4l2_common btcx_risc videodev snd_via82xx snd_ac97_codec
snd_pcm_oss
 snd_mixer_oss snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart
snd_raw
midi snd_seq_device snd soundcore pci_hotplug amd_k7_agp agpgart floppy
pcspkr r
tc evdev 8139too mii parport_pc parport dm_mod capability commoncap
i2c_viapro i
2c_isa lm80 eeprom via686a i2c_sensor i2c_core ide_cd cdrom xfs ext2
ext3 jbd mb
cache ide_generic via82cxxx hpt366 ide_disk ide_core unix font vesafb
cfbcopyare
a cfbimgblt cfbfillrect
CPU:    0
EIP:    0060:[<f0b35605>]    Not tainted
EFLAGS: 00210246   (2.6.8-2-k7)
EIP is at videobuf_dma_pci_sync+0x25/0x60 [video_buf]
eax: 00000000   ebx: effc0a64   ecx: effc0aac   edx: e84cfee0
esi: 00000000   edi: efde6610   ebp: e8635ec0   esp: e84cff00
ds: 007b   es: 007b   ss: 0068
Process vlc (pid: 3416, threadinfo=e84ce000 task=e858ee90)
Stack: efde6600 00000000 efde6610 00000000 f0b365a4 ef843800 effc0a64
00000001
       e757480c e7574808 00000001 001b0000 efde6600 00000000 e8635ec0
00007fff
       f0b65102 e8635ec0 efde6610 42f68008 00007fff e84cffac 00000000
00000000
Call Trace:
 [<f0b365a4>] videobuf_read_one+0xa4/0x240 [video_buf]
 [<f0b65102>] bttv_read+0x102/0x140 [bttv]
 [<c015352b>] vfs_read+0xdb/0x140
 [<c01537d1>] sys_read+0x51/0x80
 [<c0106107>] syscall_call+0x7/0xb
Code: 0f 0b e2 00 80 72 b3 f0 eb ec c7 44 24 08 12 11 72 19 89 44

Thank you all for the good work with linux, keep up with it ! :)

-- 
Auzanneau Grégory
GPG 0x99137BEE
