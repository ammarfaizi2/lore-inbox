Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266764AbUHCU23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266764AbUHCU23 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 16:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUHCU23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 16:28:29 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:4500 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S266764AbUHCU2W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 16:28:22 -0400
From: Duncan Sands <baldrick@free.fr>
To: linux-kernel@vger.kernel.org
Subject: Oops at bttv_risc_packed (2.6.8-rc1)
Date: Tue, 3 Aug 2004 21:23:42 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408032123.42078.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unable to handle kernel paging request at virtual address d3f8c000
 printing eip:
e0a1f25e
*pde = 0004e067
*pte = 13f8c000
Oops: 0002 [#1]
DEBUG_PAGEALLOC
Modules linked in: radeon binfmt_misc usblp speedtch snd_via82xx snd_mpu401_uart ehci_hcd uhci_hcd usbcore snd_bt87x s
nd_cs46xx snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd snd_page_alloc gameport tuner tvaudio bttv video_bu
f i2c_algo_bit v4l2_common btcx_risc i2c_core videodev rtc
CPU:    0
EIP:    0060:[pg0+543072862/1069322240]    Not tainted
EFLAGS: 00010202   (2.6.8-rc1)
EIP is at bttv_risc_packed+0x15e/0x180 [bttv]
eax: 14000008   ebx: d3f8c000   ecx: d42cb800   edx: 00000008
esi: 00000008   edi: 000000ff   ebp: d5367e44   esp: d5367e20
ds: 007b   es: 007b   ss: 0068
Process xawtv (pid: 3920, threadinfo=d5367000 task=d5a17a00)
Stack: 00000246 000003af 0000039c d42ca000 db549fc4 e0a31e00 00000240 00000c00
       db549ef8 d5367ea4 e0a20735 00000c00 00000c00 00000c00 00000120 db549f1c
       c1713bf8 d5367e84 e08c2528 d5367000 4084e000 00000000 db549ef8 db549f1c
Call Trace:
 [show_stack+122/144] show_stack+0x7a/0x90
 [show_registers+333/416] show_registers+0x14d/0x1a0
 [die+227/544] die+0xe3/0x220
 [do_page_fault+661/1364] do_page_fault+0x295/0x554
 [error_code+45/56] error_code+0x2d/0x38
 [pg0+543078197/1069322240] bttv_buffer_risc+0x4b5/0x5b0 [bttv]
 [pg0+543037493/1069322240] bttv_prepare_buffer+0xf5/0x1a0 [bttv]
 [pg0+543037845/1069322240] buffer_prepare+0x35/0x40 [bttv]
 [pg0+541648564/1069322240] videobuf_read_zerocopy+0x64/0x220 [video_buf]
 [pg0+541649738/1069322240] videobuf_read_one+0x2da/0x300 [video_buf]
 [pg0+543048579/1069322240] bttv_read+0xd3/0x120 [bttv]
 [vfs_read+162/240] vfs_read+0xa2/0xf0
 [sys_read+53/96] sys_read+0x35/0x60
 [syscall_call+7/11] syscall_call+0x7/0xb
Code: 89 03 8b 41 08 83 c3 04 89 03 eb 99 8b 41 0c e9 73 ff ff ff
