Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbVIEPno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbVIEPno (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 11:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbVIEPno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 11:43:44 -0400
Received: from pythagoras.zen.co.uk ([212.23.3.140]:20715 "EHLO
	pythagoras.zen.co.uk") by vger.kernel.org with ESMTP
	id S1751231AbVIEPnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 11:43:43 -0400
Message-Id: <200509051543.j85FhWDS008418@StraightRunning.com>
From: "Colin Harrison" <colin.harrison@virgin.net>
To: <linux-kernel@vger.kernel.org>
Subject: kernel BUG at net/ipv4/tcp.c:775!  with 2.6.13-git5
Date: Mon, 5 Sep 2005 16:43:44 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Copyright: Copyright (c) 2005 Colin Harrison
X-Domain: StraightRunning.com
X-Admin: colin@straightrunning.com
X-Originating-Pythagoras-IP: [62.3.107.196]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm getting the following BUG report with 2.6.13-git5:-

 ------------[ cut here ]------------
kernel BUG at net/ipv4/tcp.c:775!
invalid operand: 0000 [#5]
PREEMPT
Modules linked in: raw ipv6 snd_seq_oss snd_seq_midi_event snd_seq
snd_seq_devic
e snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm
snd
_timer snd_page_alloc snd soundcore parport_pc lp parport floppy natsemi
nls_iso
8859_15 ntfs mga_vid fusion intel_agp agpgart hw_random uhci_hcd usbcore
sd_mod
aic7xxx scsi_transport_spi
CPU:    0
EIP:    0060:[<c0266a08>]    Not tainted VLI
EFLAGS: 00010206   (2.6.13-git5)
EIP is at tcp_sendmsg+0x8c4/0xab3
eax: 00001000   ebx: 00001000   ecx: 00000000   edx: 00000001
esi: d2e09700   edi: 0000015c   ebp: d4f67380   esp: d3f97d68
ds: 007b   es: 007b   ss: 0068
Process httpd (pid: 5952, threadinfo=d3f97000 task=d6b84030)
Stack: ea055778 0000008f d6b84030 d6b8415c d3f97000 ffffffff 00001000
00000000
       00000001 00000000 d293e1b5 000000b5 084329a4 0000015c 00001e80
00004000
       00004000 00000040 00000003 d3f97f4c 00000000 000080d2 00000000
e2c638a0
Call Trace:
 [<c0281e34>] inet_sendmsg+0x47/0x5f
 [<c0241e30>] sock_sendmsg+0xc9/0xeb
 [<c013fbf8>] do_no_page+0x6b/0x36d
 [<c013f0a5>] do_wp_page+0x214/0x361
 [<c013574c>] buffered_rmqueue+0x107/0x1e9
 [<c0127dad>] autoremove_wake_function+0x0/0x43
 [<c0135c04>] __alloc_pages+0x313/0x3c6
 [<c02422cb>] sock_readv_writev+0x69/0x8e
 [<c0242368>] sock_writev+0x37/0x3e
 [<c0242331>] sock_writev+0x0/0x3e
 [<c014dfd1>] do_readv_writev+0x29a/0x2c2
 [<c01104eb>] do_page_fault+0x1a2/0x54a
 [<c014e08b>] vfs_writev+0x48/0x4d
 [<c014e16e>] sys_writev+0x41/0x9d
 [<c01029a3>] sysenter_past_esp+0x54/0x75
Code: 01 f8 3d ff 0f 00 00 0f 87 ee fc ff ff 8b 4c 24 1c ff 41 08 89 8e fc
00 00
 00 e9 dc fc ff ff 8b 44 24 18 85 c0 0f 84 d0 fb ff ff <0f> 0b 07 03 e0 72
2b c0
 e9 c3 fb ff ff 31 c9 8b 54 24 2c 89 e8

Any more details required?
I'll build a debug version and see if i get a better trace.

Colin Harrison

