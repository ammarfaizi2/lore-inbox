Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266901AbUIJAY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266901AbUIJAY2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 20:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbUIJAWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 20:22:48 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:25993 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S266218AbUIJAWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 20:22:02 -0400
Message-ID: <4140F3A7.8040103@blueyonder.co.uk>
Date: Fri, 10 Sep 2004 01:21:59 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: linux-2.6.9-rc1-bk16 Still cdrom/DVD oops
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Sep 2004 00:22:24.0919 (UTC) FILETIME=[3F171A70:01C496CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sep 10 01:15:05 barrabas automount[10389]: attempting to mount entry 
/media/dvd
Sep 10 01:15:08 barrabas kernel: asb100 1-002d: starting device update...
Sep 10 01:15:08 barrabas kernel: asb100 1-002d: ... device update complete
Sep 10 01:15:11 barrabas kernel: ISO 9660 Extensions: RRIP_1991A
Sep 10 01:15:11 barrabas kernel: Unable to handle kernel paging request 
at virtual address d0f3cef4
Sep 10 01:15:11 barrabas kernel:  printing eip:
Sep 10 01:15:11 barrabas kernel: c01459a1
Sep 10 01:15:11 barrabas kernel: *pde = 00043067
Sep 10 01:15:11 barrabas kernel: *pte = 10f3c000
Sep 10 01:15:11 barrabas kernel: Oops: 0000 [#2]
Sep 10 01:15:11 barrabas kernel: PREEMPT DEBUG_PAGEALLOC
Sep 10 01:15:11 barrabas kernel: Modules linked in: nvidia parport_pc lp 
parport sg st sd_mod sr_mod scsi_mod snd_seq_oss snd_seq_midi_event 
usbhid ub usblp
 snd_seq thermal processor snd_pcm_oss snd_mixer_oss fan sk98lin button 
ipv6 eeprom snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc 
gameport sn
d_mpu401_uart snd_rawmidi snd_seq_device snd soundcore asb100 i2c_sensor 
ohci1394 ieee1394 ehci_hcd ohci_hcd nvidia_agp agpgart evdev usbcore 
forcedeth vfat
 fat dm_mod
Sep 10 01:15:11 barrabas kernel: CPU:    0
Sep 10 01:15:11 barrabas kernel: EIP:    
0060:[cache_free_debugcheck+385/640]    Tainted: P   VLI
Sep 10 01:15:11 barrabas kernel: EIP:    0060:[<c01459a1>]    Tainted: 
P   VLI
Sep 10 01:15:11 barrabas kernel: EFLAGS: 00010002   (2.6.9-rc1-bk16)
Sep 10 01:15:11 barrabas kernel: EIP is at cache_free_debugcheck+0x181/0x280
Sep 10 01:15:11 barrabas automount[11981]: mount(generic): failed to 
mount /dev/dvd (type auto) on /media/dvd
Sep 10 01:15:11 barrabas kernel: eax: d0f3cef4   ebx: 80052c00   ecx: 
c01cd040   edx: d0f3c000
Sep 10 01:15:11 barrabas kernel: esi: dffef640   edi: c9d69d00   ebp: 
d418bd24   esp: d418bcfc
Sep 10 01:15:11 barrabas automount[10389]: attempting to mount entry 
/media/dvd
Sep 10 01:15:11 barrabas kernel: ds: 007b   es: 007b   ss: 0068
Sep 10 01:15:11 barrabas kernel: Process mount (pid: 11982, 
threadinfo=d418a000 task=d249bab0)
Sep 10 01:15:11 barrabas kernel: Stack: c011e658 00000000 ffffffdd 
c04b9221 10f3c000 c01cd040 d0f3c000 dffef640
Sep 10 01:15:11 barrabas kernel:        c14d9f78 d0f3cef8 d418bd3c 
c014664a 00000282 d0f3cef8 d0f3cfe6 00000000
Sep 10 01:15:11 barrabas kernel:        d418bd90 c01cd040 c0377bcc 
00000041 c015b2c0 d0f3cef8 c3d1beb8 00000029
Sep 10 01:15:11 barrabas kernel: Call Trace:
Sep 10 01:15:11 barrabas kernel:  [show_stack+166/176] show_stack+0xa6/0xb0
Sep 10 01:15:11 barrabas kernel:  [<c0106e06>] show_stack+0xa6/0xb0
Sep 10 01:15:11 barrabas kernel:  [show_registers+333/448] 
show_registers+0x14d/0x1c0
Sep 10 01:15:11 barrabas kernel:  [<c0106f7d>] show_registers+0x14d/0x1c0
Sep 10 01:15:11 barrabas kernel:  [die+240/384] die+0xf0/0x180
Sep 10 01:15:11 barrabas kernel:  [<c0107170>] die+0xf0/0x180
Sep 10 01:15:11 barrabas kernel:  [do_page_fault+1047/1467] 
do_page_fault+0x417/0x5bb
Sep 10 01:15:11 barrabas kernel:  [<c0118f47>] do_page_fault+0x417/0x5bb
Sep 10 01:15:11 barrabas kernel:  [error_code+45/56] error_code+0x2d/0x38
Sep 10 01:15:11 barrabas kernel:  [<c01069e5>] error_code+0x2d/0x38
Sep 10 01:15:11 barrabas kernel:  [kfree+74/144] kfree+0x4a/0x90
Sep 10 01:15:11 barrabas kernel:  [<c014664a>] kfree+0x4a/0x90
Sep 10 01:15:11 barrabas kernel:  
[parse_rock_ridge_inode_internal+1424/1696] 
parse_rock_ridge_inode_internal+0x590/0x6a0
Sep 10 01:15:11 barrabas kernel:  [<c01cd040>] 
parse_rock_ridge_inode_internal+0x590/0x6a0
Sep 10 01:15:11 barrabas kernel:  [parse_rock_ridge_inode+24/80] 
parse_rock_ridge_inode+0x18/0x50
Sep 10 01:15:11 barrabas kernel:  [<c01cd318>] 
parse_rock_ridge_inode+0x18/0x50
Sep 10 01:15:11 barrabas kernel:  [isofs_read_inode+809/1072] 
isofs_read_inode+0x329/0x430
Sep 10 01:15:11 barrabas kernel:  [<c01cbd69>] isofs_read_inode+0x329/0x430
Sep 10 01:15:11 barrabas kernel:  [isofs_iget+86/112] isofs_iget+0x56/0x70
Sep 10 01:15:11 barrabas kernel:  [<c01cbf26>] isofs_iget+0x56/0x70
Sep 10 01:15:11 barrabas kernel:  [isofs_fill_super+1252/1632] 
isofs_fill_super+0x4e4/0x660
Sep 10 01:15:11 barrabas kernel:  [<c01cb284>] isofs_fill_super+0x4e4/0x660
Sep 10 01:15:11 barrabas kernel:  [get_sb_bdev+194/288] 
get_sb_bdev+0xc2/0x120
Sep 10 01:15:11 barrabas kernel:  [<c0160cf2>] get_sb_bdev+0xc2/0x120
Sep 10 01:15:11 barrabas kernel:  [isofs_get_sb+26/32] 
isofs_get_sb+0x1a/0x20
Sep 10 01:15:11 barrabas kernel:  [<c01cbf5a>] isofs_get_sb+0x1a/0x20
Sep 10 01:15:11 barrabas kernel:  [do_kern_mount+148/352] 
do_kern_mount+0x94/0x160
Sep 10 01:15:11 barrabas kernel:  [<c0160f64>] do_kern_mount+0x94/0x160
Sep 10 01:15:11 barrabas kernel:  [do_new_mount+100/176] 
do_new_mount+0x64/0xb0
Sep 10 01:15:11 barrabas kernel:  [<c01771a4>] do_new_mount+0x64/0xb0
Sep 10 01:15:11 barrabas kernel:  [do_mount+403/448] do_mount+0x193/0x1c0
Sep 10 01:15:11 barrabas kernel:  [<c0177913>] do_mount+0x193/0x1c0
Sep 10 01:15:11 barrabas kernel:  [sys_mount+136/272] sys_mount+0x88/0x110
Sep 10 01:15:11 barrabas kernel:  [<c0177cb8>] sys_mount+0x88/0x110
Sep 10 01:15:11 barrabas kernel:  [sysenter_past_esp+82/113] 
sysenter_past_esp+0x52/0x71
Sep 10 01:15:11 barrabas kernel:  [<c0105f89>] sysenter_past_esp+0x52/0x71
Sep 10 01:15:11 barrabas kernel: Code: 38 eb a1 8d b4 26 00 00 00 00 8b 
55 f0 89 f0 e8 16 e5 ff ff 8b 55 ec 89 10 8b 5e 38 e9 57 ff ff ff 8b 55 
f0 89 f0 e8
8f e4 ff ff <81> 38 a5 c2 0f 17 0f 84 8b 00 00 00 b9 14 f2 35 c0 89 f2 b8 27
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====

