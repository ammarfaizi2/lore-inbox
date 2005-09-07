Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbVIGREr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbVIGREr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbVIGREr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:04:47 -0400
Received: from asteria.debian.or.at ([86.59.5.130]:23525 "EHLO
	asteria.debian.or.at") by vger.kernel.org with ESMTP
	id S1750887AbVIGREq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:04:46 -0400
Date: Wed, 7 Sep 2005 19:04:45 +0200
From: Peter Palfrader <peter@palfrader.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Oops in 2.6.13 (__tcp_push_pending_frames)
Message-ID: <20050907170445.GB11805@opium.palfrader.org>
Mail-Followup-To: Peter Palfrader <peter@palfrader.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-PGP: 1024D/94C09C7F 5B00 C96D 5D54 AEE1 206B  AF84 DE7A AF6E 94C0 9C7F
X-Request-PGP: http://www.palfrader.org/keys/94C09C7F.asc
X-Accept-Language: de, en
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got the following Oops on a pristine 2.6.13:

[17179929.236000] Unable to handle kernel NULL pointer dereference at virtual address 00000001
[17179929.236000]  printing eip:
[17179929.236000] 00000001
[17179929.236000] *pde = 00000000
[17179929.236000] Oops: 0000 [#1]
[17179929.236000] SMP 
[17179929.236000] Modules linked in: lp autofs4 ipv6 ide_cd cdrom pcspkr analog parport_pc parport floppy tsdev evdev snd_via82xx usbhid gameport snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore ehci_hcd uhci_hcd usbcore dm_mod sg unix
[17179929.236000] CPU:    0
[17179929.236000] EIP:    0060:[<00000001>]    Not tainted VLI
[17179929.236000] EFLAGS: 00010292   (2.6.13-came32) 
[17179929.236000] EIP is at 0x1
[17179929.236000] eax: 00000000   ebx: 000005a8   ecx: 00000001   edx: 00003aa5
[17179929.236000] esi: 7ed44989   edi: 000004b0   ebp: 00000028   esp: db031dac
[17179929.236000] ds: 007b   es: 007b   ss: 0068
[17179929.236000] Process rsync (pid: 5606, threadinfo=db030000 task=c1764060)
[17179929.236000] Stack: dc1aa800 dc1aa800 00001000 cad5ece0 c0423ec4 dc1aa800 000005a8 00000000 
[17179929.236000]        00000000 dc1aa800 c0418593 dc1aa800 dc1aa800 000005a8 00000000 00000000 
[17179929.236000]        c041e37e dc1aa800 00000000 00000004 cc723100 bff8c440 00000000 00001000 
[17179929.236000] Call Trace:
[17179929.236000]  [<c0423ec4>] __tcp_push_pending_frames+0x24/0xa0
[17179929.236000]  [<c0418593>] tcp_sendmsg+0x323/0xb10
[17179929.236000]  [<c041e37e>] tcp_clean_rtx_queue+0x4ce/0x500
[17179929.236000]  [<c041e850>] tcp_ack+0x1d0/0x300
[17179929.236000]  [<c0436fab>] inet_sendmsg+0x3b/0x50
[17179929.236000]  [<c03eb7e4>] sock_aio_write+0xe4/0x110
[17179929.236000]  [<c013e524>] __alloc_pages+0x2a4/0x400
[17179929.236000]  [<c0156524>] do_sync_write+0xb4/0x100
[17179929.236000]  [<c0168ada>] poll_freewait+0x3a/0x50
[17179929.236000]  [<c012f0c0>] autoremove_wake_function+0x0/0x40
[17179929.236000]  [<c01566ab>] vfs_write+0x13b/0x150
[17179929.236000]  [<c015676d>] sys_write+0x3d/0x70
[17179929.236000]  [<c0102c79>] syscall_call+0x7/0xb
[17179929.236000] Code:  Bad EIP value.
[17179929.236000]  

Let me know if there is anything else that you need.


Cheers,
Peter
