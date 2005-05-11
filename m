Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVEKXxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVEKXxd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 19:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVEKXxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 19:53:33 -0400
Received: from mailhost.cs.tamu.edu ([128.194.138.12]:26308 "EHLO
	pine.cs.tamu.edu") by vger.kernel.org with ESMTP id S261332AbVEKXxY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 19:53:24 -0400
Date: Wed, 11 May 2005 18:53:21 -0500 (CDT)
From: Erik Mckee <emckee@cs.tamu.edu>
X-X-Sender: emckee@sun
To: linux-kernel@vger.kernel.org
Subject: FC3 oops
Message-ID: <Pine.GSO.4.58.0505111847430.28589@sun>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following complaints on my macine.  It is Intel, 3.6 GHz
hyperthreaded processor with SATA software RAID.  Any idea what the
problem is?  It looks like USB is involved, as I was attaching my iPOD at
the time via USB

------------[ cut here ]------------
kernel BUG at include/asm/spinlock.h:136!
invalid operand: 0000 [#1]
SMP
Modules linked in: vfat fat usb_storage nls_utf8 nfsd exportfs lockd
parport_pc lp parport autofs4 i2c_dev i2c_core sunrpc md5 ipv6 video
button battery ac uhci_hcd ehci_hcd snd_intel8x0 snd_ac97_codec
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc
tg3 floppy ext3 jbd raid1 dm_mod ata_piix libata sd_mod scsi_mod
CPU:    0
EIP:    0060:[<c0300e44>]    Not tainted VLI
EFLAGS: 00210096   (2.6.11-1.14_FC3smp)
EIP is at _spin_lock+0x36/0x40
eax: 0000000e   ebx: cdc9501c   ecx: c035878c   edx: 00000000
esi: f7431b1c   edi: f72b7630   ebp: f72b763c   esp: ed7a1f54
ds: 007b   es: 007b   ss: 0068
Process gtkpod (pid: 5855, threadinfo=ed7a1000 task=c8419aa0)
Stack: c0317f5f c024c5be f72b7828 c024c5be 00200286 f5dbf4dc c23377e8
c8419aa0
       ed7a1000 00000000 c02454d7 ed7a1000 c0123e4f c8419020 c8419aa0
ed7a1000
       00000000 c012afc1 eb286904 e8872080 ed7a1000 00000000 c0123ec8
00000000
Call Trace:
 [<c024c5be>] cfq_exit_io_context+0x54/0xb3
 [<c024c5be>] cfq_exit_io_context+0x54/0xb3
 [<c02454d7>] exit_io_context+0x45/0x52
 [<c0123e4f>] do_exit+0x314/0x338
 [<c012afc1>] signal_wake_up+0x1e/0x32
 [<c0123ec8>] do_group_exit+0x29/0x90
 [<c0103f0f>] syscall_call+0x7/0xb
Code: ad de 75 13 f0 fe 0b 79 09 f3 90 80 3b 00 7e f9 eb f2 83 c4 08 5b c3
8b 44 24 0c c7 04 24 5f 7f 31 c0 89 44 24 04 e8 5e 0a e2 ff <0f> 0b 88 00
14 77 31 c0 eb cf 81 78 04 ed 1e af de 75 0f f0 81
 eip: c024c5ed
------------[ cut here ]------------
kernel BUG at include/asm/spinlock.h:136!
invalid operand: 0000 [#2]
SMP
Modules linked in: vfat fat usb_storage nls_utf8 nfsd exportfs lockd
parport_pc lp parport autofs4 i2c_dev i2c_core sunrpc md5 ipv6 video
button battery ac uhci_hcd ehci_hcd snd_intel8x0 snd_ac97_codec
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc
tg3 floppy ext3 jbd raid1 dm_mod ata_piix libata sd_mod scsi_mod
CPU:    1
EIP:    0060:[<c0300e44>]    Not tainted VLI
EFLAGS: 00210096   (2.6.11-1.14_FC3smp)
EIP is at _spin_lock+0x36/0x40
eax: 0000000e   ebx: cdc9501c   ecx: c035878c   edx: 00000000
esi: f7431b1c   edi: f72b7ee8   ebp: f72b7ef4   esp: e389ef54
ds: 007b   es: 007b   ss: 0068
Process tcsh (pid: 5737, threadinfo=e389e000 task=dcc4a020)
Stack: c0317f5f c024c5ed c2337d28 c024c5ed 00200286 d4b6faf4 c2337d28
dcc4a020
       e389e000 00000000 c02454d7 e389e000 c0123e4f f4c3ac80 c015cb42
e389efac
       f4c3ac80 fffffff7 00000000 f57e5e80 e389e000 00000000 c0123ec8
00000000
Call Trace:
 [<c024c5ed>] cfq_exit_io_context+0x83/0xb3
 [<c024c5ed>] cfq_exit_io_context+0x83/0xb3
 [<c02454d7>] exit_io_context+0x45/0x52
 [<c0123e4f>] do_exit+0x314/0x338
 [<c015cb42>] vfs_write+0xc2/0x10a
 [<c0123ec8>] do_group_exit+0x29/0x90
 [<c0103f0f>] syscall_call+0x7/0xb
Code: ad de 75 13 f0 fe 0b 79 09 f3 90 80 3b 00 7e f9 eb f2 83 c4 08 5b c3
8b 44 24 0c c7 04 24 5f 7f 31 c0 89 44 24 04 e8 5e 0a e2 ff <0f> 0b 88 00
14 77 31 c0 eb cf 81 78 04 ed 1e af de 75 0f f0 81

