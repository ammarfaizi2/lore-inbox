Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267585AbUJBWuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267585AbUJBWuM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 18:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267582AbUJBWuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 18:50:12 -0400
Received: from bay16-f38.bay16.hotmail.com ([65.54.186.88]:25747 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S267585AbUJBWuE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 18:50:04 -0400
X-Originating-IP: [64.81.213.196]
X-Originating-Email: [dinoklein@hotmail.com]
From: "Dino Klein" <dinoklein@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.9-rc3 Bug in NTFS  code
Date: Sat, 02 Oct 2004 18:49:26 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY16-F38bigPasSmz600007d7b@hotmail.com>
X-OriginalArrivalTime: 02 Oct 2004 22:50:03.0158 (UTC) FILETIME=[2771BB60:01C4A8D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

below is what I had in the logs when attempting to umount a readonly NTFS.

------------[ cut here ]------------
kernel BUG at fs/ntfs/inode.c:354!
invalid operand: 0000 [#1]
SMP
Modules linked in: ntfs ohci1394 ieee1394 via_agp snd_emu10k1 snd_rawmidi 
snd_pcm snd_timer snd_seq_device snd_ac97_codec snd_page_alloc snd_util_mem 
snd_hwdep snd soundcore hpt366 ipv6 parport_pc lp parport autofs4 sunrpc 
3c59x ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables floppy sg 
scsi_mod microcode tsdev joydev usbhid dm_mod uhci_hcd ohci_hcd ehci_hcd 
usbcore button battery asus_acpi ac ext3 jbd
CPU:    0
EIP:    0060:[<f8c7f456>]    Not tainted VLI
EFLAGS: 00010286   (2.6.9-rc3)
EIP is at ntfs_destroy_extent_inode+0x26/0x30 [ntfs]
eax: c1ef89c0   ebx: f6cdfc40   ecx: 00000000   edx: f5a3c9b0
esi: 00000002   edi: f73b5e00   ebp: f73b5e50   esp: f5affef8
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 3161, threadinfo=f5afe000 task=f72d4bf0)
Stack: f8c81cbf f6cdfcec f73b5e00 c0174734 f6cdfcec c017561c f6cdfcec 
f594aee0
       c01756b3 f594af60 f8c84912 f73b5e00 f5afe000 00000000 c0161d46 
ffffffff
       f8c8cd20 f73b5e00 f7f94200 f8c8cda0 f5afe000 c01627e7 f73b5e40 
f73b5e00
Call Trace:
[<f8c81cbf>] ntfs_clear_big_inode+0x6f/0x80 [ntfs]
[<c0174734>] clear_inode+0xf4/0x130
[<c017561c>] generic_forget_inode+0xec/0x110
[<c01756b3>] iput+0x53/0x70
[<f8c84912>] ntfs_put_super+0xf2/0x2c0 [ntfs]
[<c0161d46>] generic_shutdown_super+0x176/0x190
[<c01627e7>] kill_block_super+0x17/0x40
[<c0161afe>] deactivate_super+0x6e/0x90
[<c0177a0b>] sys_umount+0x3b/0x90
[<c01500ec>] do_munmap+0x12c/0x170
[<c0177a75>] sys_oldumount+0x15/0x20
[<c010606d>] sysenter_past_esp+0x52/0x71
Code: 26 00 00 00 00 89 c2 8b 40 58 85 c0 75 1d f0 ff 4a 1c 0f 94 c0 84 c0 
75 08 0f 0b 64 01 1d 6c c8 f8 a1 3c d4 c8 f8 e9 aa 7b 4c c7 <0f> 0b 62 01 1d 
6c c8 f8 eb d9 c7 42 1c 01 00 00 00 8d 4a 3c c7

_________________________________________________________________
Check out Election 2004 for up-to-date election news, plus voter tools and 
more! http://special.msn.com/msn/election2004.armx

