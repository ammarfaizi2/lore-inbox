Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVA1Rog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVA1Rog (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 12:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVA1Roc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 12:44:32 -0500
Received: from mail1.kontent.de ([81.88.34.36]:43475 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261498AbVA1Rmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 12:42:40 -0500
From: Oliver Neukum <oliver@neukum.org>
To: axboe@suse.de
Subject: Ooops unmounting a defect DVD
Date: Fri, 28 Jan 2005 18:42:44 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501281842.44881.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got this oops unmounting by "eject" a defect DVD on a genuine
SCSI drive.

Jan 27 23:30:03 oenone kernel: Buffer I/O error on device sr0, logical block 1972790
Jan 27 23:30:03 oenone kernel: dc395x: eh_abort: (pid#733021) target=<01-0> cmd=dfc99c40
Jan 27 23:30:03 oenone kernel: dc395x: eh_abort: Command not found<6>dc395x: eh_bus_reset: (pid#733021) target=<01-0> cmd=dfc99c40
Jan 27 23:30:03 oenone kernel: dc395x: doing_srb_done: pids 
Jan 27 23:30:13 oenone kernel: dc395x: Target 01:  Sync: 48ns Offset 8 (20.8 MB/s)
Jan 27 23:30:24 oenone kernel: dc395x: sg_update_list: sg_to_virt failed
Jan 27 23:30:24 oenone kernel: SCSI error : <0 0 1 0> return code = 0x8000002
Jan 27 23:30:24 oenone kernel: sr0: Current: sense key=0x4
Jan 27 23:30:24 oenone kernel:     ASC=0x15 ASCQ=0x1
Jan 27 23:30:24 oenone kernel: Info fld=0x1e1a37
Jan 27 23:30:24 oenone kernel: end_request: I/O error, dev sr0, sector 7891164
Jan 27 23:30:24 oenone kernel: Buffer I/O error on device sr0, logical block 1972791
Jan 27 23:30:24 oenone kernel: dc395x: eh_abort: (pid#733885) target=<01-0> cmd=dfc99940
Jan 27 23:30:24 oenone kernel: dc395x: eh_abort: Command not found<6>dc395x: eh_bus_reset: (pid#733885) target=<01-0> cmd=dfc99940
Jan 27 23:30:24 oenone kernel: dc395x: doing_srb_done: pids 
Jan 27 23:30:34 oenone kernel: dc395x: Target 01:  Sync: 48ns Offset 8 (20.8 MB/s)
Jan 27 23:30:44 oenone kernel: dc395x: sg_update_list: sg_to_virt failed
Jan 27 23:30:44 oenone kernel: SCSI error : <0 0 1 0> return code = 0x8000002
Jan 27 23:30:44 oenone kernel: sr0: Current: sense key=0x4
Jan 27 23:30:44 oenone kernel:     ASC=0x15 ASCQ=0x1
Jan 27 23:30:44 oenone kernel: Info fld=0x1e1a38
Jan 27 23:30:44 oenone kernel: end_request: I/O error, dev sr0, sector 7891168
Jan 27 23:30:44 oenone kernel: Buffer I/O error on device sr0, logical block 1972792
Jan 27 23:30:44 oenone kernel: dc395x: eh_abort: (pid#734783) target=<01-0> cmd=dfc99c40
Jan 27 23:30:44 oenone kernel: dc395x: eh_abort: Command not found<6>dc395x: eh_bus_reset: (pid#734783) target=<01-0> cmd=dfc99c40
Jan 27 23:30:44 oenone kernel: dc395x: doing_srb_done: pids 
Jan 27 23:30:54 oenone kernel: dc395x: Target 01:  Sync: 48ns Offset 8 (20.8 MB/s)
Jan 27 23:31:05 oenone kernel: dc395x: sg_update_list: sg_to_virt failed
Jan 27 23:31:05 oenone kernel: SCSI error : <0 0 1 0> return code = 0x8000002
Jan 27 23:31:05 oenone kernel: sr0: Current: sense key=0x4
Jan 27 23:31:05 oenone kernel:     ASC=0x15 ASCQ=0x1
Jan 27 23:31:05 oenone kernel: Info fld=0x1e1a39
Jan 27 23:31:05 oenone kernel: end_request: I/O error, dev sr0, sector 7891172
Jan 27 23:31:05 oenone kernel: Buffer I/O error on device sr0, logical block 1972793
Jan 27 23:31:05 oenone kernel: dc395x: eh_abort: (pid#735658) target=<01-0> cmd=dfc99940
Jan 27 23:31:05 oenone kernel: dc395x: eh_abort: Command not found<6>dc395x: eh_bus_reset: (pid#735658) target=<01-0> cmd=dfc99940
Jan 27 23:31:05 oenone kernel: dc395x: doing_srb_done: pids 
Jan 27 23:31:15 oenone kernel: dc395x: Target 01:  Sync: 48ns Offset 8 (20.8 MB/s)
Jan 27 23:31:15 oenone kernel: scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 1 lun 0
Jan 27 23:31:15 oenone kernel: scsi0 (1:0): rejecting I/O to offline device
Jan 27 23:31:15 oenone kernel: scsi0 (1:0): rejecting I/O to offline device
Jan 27 23:31:15 oenone kernel: Buffer I/O error on device sr0, logical block 1972794
Jan 27 23:31:15 oenone kernel: scsi0 (1:0): rejecting I/O to offline device
Jan 27 23:31:15 oenone kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000018
Jan 27 23:31:15 oenone kernel:  printing eip:
Jan 27 23:31:15 oenone kernel: c02d183e
Jan 27 23:31:15 oenone kernel: *pde = 00000000
Jan 27 23:31:15 oenone kernel: Oops: 0000 [#1]
Jan 27 23:31:15 oenone kernel: Modules linked in: paride usb_storage snd_intel8x0 snd_ac97_codec tuner tvaudio msp3400 bttv video_buf v4l2_common btcx_risc videodev usbserial nvram ipt_TOS ipt_LOG ipt_limit ipt_TCPMSS ipt_MASQUERADE ipt_pkttype ipt_state ipt_REJECT iptable_mangle iptable_filter ip6table_mangle ip_nat_ftp iptable_nat ip_conntrack_ftp ip_conntrack ip_tables ip6table_filter ip6_tables ipv6 usblp st
Jan 27 23:31:15 oenone kernel: CPU:    0
Jan 27 23:31:15 oenone kernel: EIP:    0060:[<c02d183e>]    Not tainted VLI
Jan 27 23:31:15 oenone kernel: EFLAGS: 00010297   (2.6.11-rc1) 
Jan 27 23:31:15 oenone kernel: EIP is at cdrom_release+0x1e/0x110
Jan 27 23:31:15 oenone kernel: eax: 00000018   ebx: 00000018   ecx: c02ba400   edx: 00000000
Jan 27 23:31:15 oenone kernel: esi: cee35ea4   edi: dfc3d540   ebp: 00000000   esp: d4a51f28
Jan 27 23:31:15 oenone kernel: ds: 007b   es: 007b   ss: 0068
Jan 27 23:31:15 oenone kernel: Process umount (pid: 13824, threadinfo=d4a50000 task=d4205020)
Jan 27 23:31:15 oenone kernel: Stack: 00000000 cee35e40 00000000 cee35ea4 dfc3d540 00000000 c02ba415 cee35e40 
Jan 27 23:31:15 oenone kernel:        c0159bc5 d6c17800 c049db00 00000000 d4a50000 c0158063 00000000 d4a51f6c 
Jan 27 23:31:15 oenone kernel:        c016bc27 c5c937c4 c14d4a00 00000296 00000000 ded98040 00000001 00000001 
Jan 27 23:31:15 oenone kernel: Call Trace:
Jan 27 23:31:15 oenone kernel:  [<c02ba415>] sr_block_release+0x15/0x60
Jan 27 23:31:15 oenone kernel:  [<c0159bc5>] blkdev_put+0xa5/0x120
Jan 27 23:31:15 oenone kernel:  [<c0158063>] deactivate_super+0x43/0x60
Jan 27 23:31:15 oenone kernel:  [<c016bc27>] sys_umount+0x57/0x80
Jan 27 23:31:15 oenone kernel:  [<c0147c32>] do_munmap+0xf2/0x130
Jan 27 23:31:15 oenone kernel:  [<c016bc67>] sys_oldumount+0x17/0x20
Jan 27 23:31:15 oenone kernel:  [<c0102ead>] sysenter_past_esp+0x52/0x75
Jan 27 23:31:15 oenone kernel: Code: 39 97 e4 ff eb c9 8d b4 26 00 00 00 00 83 ec 18 83 3d 48 d9 5a c0 01 89 5c 24 08 89 6c 24 14 89 74 24 0c 89 7c 24 10 89 c3 89 d5 <8b> 38 0f 84 b0 00 00 00 8b 43 20 85 c0 7e 04 48 89 43 20 85 c0 
Jan 27 23:44:58 oenone -- MARK --

	Regards
		Oliver

