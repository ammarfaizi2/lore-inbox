Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUIHPqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUIHPqR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 11:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268298AbUIHPqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 11:46:17 -0400
Received: from smtp-out1.blueyonder.co.uk ([195.188.213.4]:11012 "EHLO
	smtp-out1.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S265222AbUIHPp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 11:45:59 -0400
Message-ID: <413F2935.4020009@blueyonder.co.uk>
Date: Wed, 08 Sep 2004 16:45:57 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: -bk15 oops on mounting cdrom
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Sep 2004 15:46:22.0656 (UTC) FILETIME=[FDBAF400:01C495BA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sep  8 16:09:31 barrabas automount[10868]: attempting to mount entry 
/media/cdrom
Sep  8 16:09:32 barrabas kernel: ISO 9660 Extensions: Microsoft Joliet 
Level 3
Sep  8 16:09:32 barrabas kernel: ISO 9660 Extensions: RRIP_1991A
Sep  8 16:09:32 barrabas kernel: Unable to handle kernel paging request 
at virtual address d1ebbef4
Sep  8 16:09:32 barrabas kernel:  printing eip:
Sep  8 16:09:32 barrabas kernel: c01458c1
Sep  8 16:09:32 barrabas kernel: *pde = 00047067
Sep  8 16:09:32 barrabas kernel: *pte = 11ebb000
Sep  8 16:09:32 barrabas kernel: Oops: 0000 [#2]
Sep  8 16:09:32 barrabas kernel: PREEMPT DEBUG_PAGEALLOC
Sep  8 16:09:32 barrabas kernel: Modules linked in: nls_iso8859_1 nvidia 
parport_pc lp parport sg st sd_mod sr_mod scsi_mod thermal snd_seq_oss 
snd_seq_midi
_event snd_seq snd_pcm_oss snd_mixer_oss sk98lin snd_intel8x0 processor 
ub usblp fan usbhid snd_ac97_codec snd_pcm snd_timer snd_page_alloc 
gameport snd_mpu
401_uart snd_rawmidi snd_seq_device snd button ipv6 soundcore ohci1394 
ieee1394 ehci_hcd nvidia_agp agpgart ohci_hcd evdev usbcore forcedeth 
vfat fat dm_mod
Sep  8 16:09:32 barrabas kernel: CPU:    0
Sep  8 16:09:32 barrabas kernel: EIP:    
0060:[cache_free_debugcheck+385/640]    Tainted: P   VLI
Sep  8 16:09:32 barrabas kernel: EIP:    0060:[<c01458c1>]    Tainted: 
P   VLI
Sep  8 16:09:32 barrabas kernel: EFLAGS: 00010002   (2.6.9-rc1-bk15)
Sep  8 16:09:32 barrabas kernel: EIP is at cache_free_debugcheck+0x181/0x280
Sep  8 16:09:32 barrabas kernel: eax: d1ebbef4   ebx: 80052c00   ecx: 
c01ccf40   edx: d1ebb000
Sep  8 16:09:32 barrabas kernel: esi: dffef640   edi: dcbad9bc   ebp: 
c2221d24   esp: c2221cfc
Sep  8 16:09:32 barrabas kernel: ds: 007b   es: 007b   ss: 0068
Sep  8 16:09:32 barrabas automount[17138]: mount(generic): failed to 
mount /dev/cdrom (type auto) on /media/cdrom
Sep  8 16:09:32 barrabas kernel: Process mount (pid: 17139, 
threadinfo=c2220000 task=ca818ab0)
Sep  8 16:09:32 barrabas kernel: Stack: c011e668 00000000 ffffffdd 
c04b9221 11ebb000 c01ccf40 d1ebb000 dffef640
Sep  8 16:09:32 barrabas kernel:        c14d9f78 d1ebbef8 c2221d3c 
c014656a 00000282 d1ebbef8 d1ebbfe5 00000000
Sep  8 16:09:32 barrabas kernel:        c2221d90 c01ccf40 c03776a1 
00000041 c015b1e0 d1ebbef8 db45deb8 0000000c
Sep  8 16:09:32 barrabas kernel: Call Trace:
Sep  8 16:09:32 barrabas kernel:  [show_stack+166/176] show_stack+0xa6/0xb0
Sep  8 16:09:32 barrabas kernel:  [<c0106dc6>] show_stack+0xa6/0xb0
Sep  8 16:09:32 barrabas kernel:  [show_registers+333/448] 
show_registers+0x14d/0x1c0
Sep  8 16:09:32 barrabas kernel:  [<c0106f3d>] show_registers+0x14d/0x1c0
Sep  8 16:09:32 barrabas kernel:  [die+240/384] die+0xf0/0x180
Sep  8 16:09:32 barrabas kernel:  [<c0107130>] die+0xf0/0x180
Sep  8 16:09:32 barrabas automount[10868]: attempting to mount entry 
/media/cdrom
Sep  8 16:09:32 barrabas kernel:  [do_page_fault+1047/1467] 
do_page_fault+0x417/0x5bb
Sep  8 16:09:32 barrabas kernel:  [<c0118f47>] do_page_fault+0x417/0x5bb
Sep  8 16:09:32 barrabas kernel:  [error_code+45/56] error_code+0x2d/0x38
Sep  8 16:09:32 barrabas kernel:  [<c01069a5>] error_code+0x2d/0x38
Sep  8 16:09:32 barrabas kernel:  [kfree+74/144] kfree+0x4a/0x90
Sep  8 16:09:32 barrabas kernel:  [<c014656a>] kfree+0x4a/0x90
Sep  8 16:09:32 barrabas kernel:  
[parse_rock_ridge_inode_internal+1424/1696] 
parse_rock_ridge_inode_internal+0x590/0x6a0
Sep  8 16:09:32 barrabas kernel:  [<c01ccf40>] 
parse_rock_ridge_inode_internal+0x590/0x6a0
Sep  8 16:09:32 barrabas kernel:  [parse_rock_ridge_inode+24/80] 
parse_rock_ridge_inode+0x18/0x50
Sep  8 16:09:32 barrabas kernel:  [<c01cd218>] 
parse_rock_ridge_inode+0x18/0x50
Sep  8 16:09:32 barrabas kernel:  [isofs_read_inode+809/1072] 
isofs_read_inode+0x329/0x430
Sep  8 16:09:32 barrabas kernel:  [<c01cbc69>] isofs_read_inode+0x329/0x430
Sep  8 16:09:32 barrabas kernel:  [isofs_iget+86/112] isofs_iget+0x56/0x70
Sep  8 16:09:32 barrabas kernel:  [<c01cbe26>] isofs_iget+0x56/0x70
Sep  8 16:09:32 barrabas kernel:  [isofs_fill_super+1252/1632] 
isofs_fill_super+0x4e4/0x660
Sep  8 16:09:32 barrabas kernel:  [<c01cb184>] isofs_fill_super+0x4e4/0x660
Sep  8 16:09:32 barrabas kernel:  [get_sb_bdev+194/288] 
get_sb_bdev+0xc2/0x120
Sep  8 16:09:32 barrabas kernel:  [<c0160c72>] get_sb_bdev+0xc2/0x120
Sep  8 16:09:32 barrabas kernel:  [isofs_get_sb+26/32] 
isofs_get_sb+0x1a/0x20
Sep  8 16:09:32 barrabas kernel:  [<c01cbe5a>] isofs_get_sb+0x1a/0x20
Sep  8 16:09:32 barrabas kernel:  [do_kern_mount+148/352] 
do_kern_mount+0x94/0x160
Sep  8 16:09:32 barrabas kernel:  [<c0160ee4>] do_kern_mount+0x94/0x160
Sep  8 16:09:32 barrabas kernel:  [do_new_mount+100/176] 
do_new_mount+0x64/0xb0
Sep  8 16:09:32 barrabas kernel:  [<c01770c4>] do_new_mount+0x64/0xb0
Sep  8 16:09:32 barrabas kernel:  [do_mount+403/448] do_mount+0x193/0x1c0
Sep  8 16:09:32 barrabas kernel:  [<c0177833>] do_mount+0x193/0x1c0
Sep  8 16:09:32 barrabas kernel:  [sys_mount+136/272] sys_mount+0x88/0x110
Sep  8 16:09:32 barrabas kernel:  [<c0177bd8>] sys_mount+0x88/0x110
Sep  8 16:09:32 barrabas kernel:  [sysenter_past_esp+82/113] 
sysenter_past_esp+0x52/0x71
Sep  8 16:09:32 barrabas kernel:  [<c0105f49>] sysenter_past_esp+0x52/0x71
Sep  8 16:09:32 barrabas kernel: Code: 38 eb a1 8d b4 26 00 00 00 00 8b 
55 f0 89 f0 e8 16 e5 ff ff 8b 55 ec 89 10 8b 5e 38 e9 57 ff ff ff 8b 55 
f0 89 f0 e8
8f e4 ff ff <81> 38 a5 c2 0f 17 0f 84 8b 00 00 00 b9 4c ee 35 c0 89 f2 b8 67

Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====

