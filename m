Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbUL2X7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbUL2X7y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 18:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbUL2X7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 18:59:54 -0500
Received: from chello083144090118.chello.pl ([83.144.90.118]:16645 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S261448AbUL2X7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 18:59:45 -0500
From: =?iso-8859-2?q?Pawe=B3_Sikora?= <pluto@pld-linux.org>
Subject: [oops] # rmmod snd_nm256
Date: Thu, 30 Dec 2004 00:59:42 +0100
User-Agent: KMail/1.7.2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412300059.42982.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# rmmod snd_nm256
Oops: 0000 [#1]
Modules linked in: snd_pcm_oss snd_seq_oss snd_seq_midi_event snd_seq
snd_seq_device snd_mixer_oss snd_nm256 snd_ac97_codec snd_pcm snd_timer
snd_page_alloc snd soundcore md5 ipv6 thermal processor fan battery ac
button 8139too mii pcmcia yenta_socket pcmcia_core intel_agp agpgart
pcspkr ircomm_tty ircomm irtty_sir sir_dev irda crc_ccitt psmouse i8k
ext3 mbcache jbd ide_disk piix ide_core
CPU:    0
EIP:    0060:[<d0be8add>]    Not tainted VLI
EFLAGS: 00010282   (2.6.10)
EIP is at snd_nm256_ac97_ready+0x2d/0x60 [snd_nm256]
eax: d0baca04   ebx: 00000009   ecx: 00000002   edx: 00000001
esi: cefe1c40   edi: cefe0800   ebp: cd9cdde0   esp: cd9cddd0
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 3806, threadinfo=cd9cc000 task=cf7080e0)
Stack: 00000a04 00000002 00000600 cefe1c40 cd9cde00 d0be8b97 cefe1c40
00000002
       9f9f0002 00000002 ce9b6e00 00009f9f cd9cde20 d0c47148 ce9b6e00
00000002
       00009f9f ce9b6e00 ce9b6e00 00002fff cd9cde3c d0c4a61d ce9b6e00
00000002
Call Trace:
 [<c01040f5>] show_stack+0x75/0x90
 [<c010424b>] show_registers+0x11b/0x180
 [<c01043f4>] die+0xb4/0x130
 [<c0113c3d>] do_page_fault+0x2dd/0x67b
 [<c0103d7b>] error_code+0x2b/0x30
 [<d0be8b97>] snd_nm256_ac97_write+0x27/0x70 [snd_nm256]
 [<d0c47148>] snd_ac97_write+0x48/0x70 [snd_ac97_codec]
 [<d0c4a61d>] snd_ac97_powerdown+0x6d/0x80 [snd_ac97_codec]
 [<d0c481b0>] snd_ac97_dev_free+0x10/0x20 [snd_ac97_codec]
 [<d0bcebcb>] snd_device_free+0x7b/0xb0 [snd]
 [<d0bcee0e>] snd_device_free_all+0x5e/0x70 [snd]
 [<d0bcab60>] snd_card_free+0x120/0x220 [snd]
 [<d0be9603>] snd_nm256_remove+0x13/0x30 [snd_nm256]
 [<c01a74e3>] pci_device_remove+0x33/0x40
 [<c01fef63>] device_release_driver+0x63/0x70
 [<c01fef8d>] driver_detach+0x1d/0x30
 [<c01ff36b>] bus_remove_driver+0x3b/0x80
 [<c01ff8cd>] driver_unregister+0xd/0x20
 [<c01a76e0>] pci_unregister_driver+0x10/0x20
 [<d0be962d>] alsa_card_nm256_exit+0xd/0x11 [snd_nm256]
 [<c012b8ea>] sys_delete_module+0x13a/0x170
 [<c0102c97>] syscall_call+0x7/0xb
Code: e5 57 56 53 51 bb 09 00 00 00 8b 75 08 8b 46 3c 89 45 f0 66 8b 7e
40 8d b4 26 00 00 00 00 8b 56 04 8b 45 f0 01 d0 ba 01 00 00 00 <66> 8b
00 66 85 c7 74 14 68 bc 8d 06 00 e8 11 a4 5b ef 58 89 d8
 Segmentation fault


-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)
