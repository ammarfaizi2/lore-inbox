Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbVISQQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbVISQQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 12:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbVISQQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 12:16:26 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:41913 "HELO
	briare1.heliogroup.fr") by vger.kernel.org with SMTP
	id S932486AbVISQQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 12:16:25 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel 2.6.13 oops on removed CDROM
Date: Mon, 19 Sep 2005 16:13:30 GMT
Message-ID: <05DGL2I12@briare1.heliogroup.fr>
X-Mailer: Pliant 94
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've hot removed the CDROM from my laptop (probably not very wise), but
I think it raised a bug in the kernel since after the expected IDE errors,
I also get an unexpected 'oops' when Pliant calls 'mount' kernel function.

<4>hdc: status error: status=0x00 { }
<4>ide: failed opcode was: unknown
<4>hdc: status error: status=0x00 { }
<4>ide: failed opcode was: unknown
<4>hdc: status error: status=0x00 { }
<4>ide: failed opcode was: unknown
<4>hdc: status error: status=0x00 { }
<4>ide: failed opcode was: unknown
<4>hdc: ATAPI reset complete
<4>hdc: status error: status=0x00 { }
<4>ide: failed opcode was: unknown
<4>hdc: status error: status=0x00 { }
<4>ide: failed opcode was: unknown
<4>hdc: status error: status=0x00 { }
<4>ide: failed opcode was: unknown
<4>hdc: status error: status=0x00 { }
<4>ide: failed opcode was: unknown
<4>hdc: status error: status=0x00 { }
<4>ide: failed opcode was: unknown
<4>hdc: ATAPI reset complete
<4>hdc: status error: status=0x00 { }
<4>ide: failed opcode was: unknown
<4>hdc: status error: status=0x00 { }
<4>ide: failed opcode was: unknown
<4>hdc: status error: status=0x00 { }
<4>ide: failed opcode was: unknown
<4>hdc: status error: status=0x00 { }
<4>ide: failed opcode was: unknown
<4>hdc: ATAPI reset complete
<4>hdc: status error: status=0x00 { }
<4>ide: failed opcode was: unknown
<3>getblk(): invalid block size 0 requested
<3>hardsect size: 38400
<4> [<c014d970>] __getblk_slow+0x120/0x130
<4> [<c014dc38>] __getblk+0x48/0x50
<4> [<c014dc75>] __bread+0x5/0x20
<4> [<f8935b8a>] isofs_fill_super+0x12a/0x500 [isofs]
<4> [<c01a016d>] sys_semtimedop+0xed/0x490
<4> [<c0151c80>] get_sb_bdev+0xd0/0x110
<4> [<f8936a7c>] isofs_get_sb+0x1c/0x30 [isofs]
<4> [<f8935a60>] isofs_fill_super+0x0/0x500 [isofs]
<4> [<c0151e7d>] do_kern_mount+0x4d/0xc0
<4> [<c016510a>] do_new_mount+0x8a/0xc0
<4> [<c01656bc>] do_mount+0x13c/0x180
<4> [<c0165519>] copy_mount_options+0x59/0xc0
<4> [<c0165a1a>] sys_mount+0x7a/0xc0
<4> [<c0102e99>] syscall_call+0x7/0xb
<1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
<1> printing eip:
<4>c014dc77
<1>*pde = 00000000
<1>Oops: 0000 [#1]
<4>Modules linked in: isofs ide_cd cdrom ppp_async crc_ccitt ppp_generic slhc rfcomm l2cap hci_usb bluetooth snd_intel8x0 usb_storage usblp ohci_hcd nls_cp437 msdos fat ehci_hcd sd_mod sg scsi_mod snd_usb_audio snd_hwdep snd_usb_lib snd_rawmidi snd_seq_device usbmouse usbkbd uhci_hcd usbcore snd_pcm_oss snd_mixer_oss snd_ac97_codec snd_pcm snd_page_alloc snd_timer snd soundcore
<4>CPU:    0
<4>EIP:    0060:[<c014dc77>]    Not tainted VLI
<4>EFLAGS: 00010282   (2.6.13) 
<4>EIP is at __bread+0x7/0x20
<4>eax: 00000000   ebx: 00008000   ecx: c02cb06c   edx: 00000000
<4>esi: 00000000   edi: c0aaecb4   ebp: 00000010   esp: e1213e38
<4>ds: 007b   es: 007b   ss: 0068
<4>Process pliant (pid: 6500, threadinfo=e1212000 task=c723ea60)
<4>Stack: f8935b8a 00000000 00000000 00000000 00000000 00000064 c0aaec80 00000000 
<4>       00000000 00000000 00000000 00000000 d5530600 6e79796e 75006e6e 00000000 
<4>       c01a016d 00000000 00000000 00000000 e1213e00 ffffffff ffffffff 00009600 
<4>Call Trace:
<4> [<f8935b8a>] isofs_fill_super+0x12a/0x500 [isofs]
<4> [<c01a016d>] sys_semtimedop+0xed/0x490
<4> [<c0151c80>] get_sb_bdev+0xd0/0x110
<4> [<f8936a7c>] isofs_get_sb+0x1c/0x30 [isofs]
<4> [<f8935a60>] isofs_fill_super+0x0/0x500 [isofs]
<4> [<c0151e7d>] do_kern_mount+0x4d/0xc0
<4> [<c016510a>] do_new_mount+0x8a/0xc0
<4> [<c01656bc>] do_mount+0x13c/0x180
<4> [<c0165519>] copy_mount_options+0x59/0xc0
<4> [<c0165a1a>] sys_mount+0x7a/0xc0
<4> [<c0102e99>] syscall_call+0x7/0xb
<4>Code: e1 ba 01 00 00 00 b8 02 00 00 00 e8 54 1c 00 00 8b 04 24 85 c0 74 05 e8 38 fd ff ff 58 c3 8d b6 00 00 00 00 e8 7b ff ff ff 89 c2 <8b> 00 a8 01 74 03 89 d0 c3 89 d0 e8 99 fd ff ff 89 c2 eb f2 90 
<4> 

