Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVACC3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVACC3j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 21:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVACC3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 21:29:38 -0500
Received: from hs-grafik.net ([80.237.205.72]:27586 "EHLO
	ds80-237-205-72.dedicated.hosteurope.de") by vger.kernel.org
	with ESMTP id S261281AbVACC3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 21:29:21 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: This time? Bug in Reiser4 or usb or hardware flaw?
Date: Mon, 3 Jan 2005 03:29:16 +0100
User-Agent: KMail/1.7.1
X-Need-Girlfriend: always
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501030329.16836@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while copying larger amounts (15GB) of data from a ext2 to a reiser4 partition 
on a usb hdd, everything failed and I had to reboot. Dunno if its reiser4 or 
usb thats failing here, though. The kernel was not going to see the external 
hdd again.
Heres dmesg output:

drivers/usb/input/hid-core.c: input irq status -71 received
SCSI error : <2 0 0 0> return code = 0x70000
[Several times]
end_request: I/O error, dev sda, sector 9747239
drivers/usb/input/hid-core.c: input irq status -71 received
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 9747247
[Several times]
end_request: I/O error, dev sda, sector 9747551
drivers/usb/input/hid-core.c: input irq status -71 received
SCSI error : <2 0 0 0> return code = 0x70000
[and so on until:]
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10442831
drivers/usb/input/hid-core.c: input irq status -71 received
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 278048163
reiser4[cp(15674)]: key_warning (fs/reiser4/plugin/object.c:97)[nikita-717]:
WARNING: Error for inode 67002 (-5)
reiser4[cp(15674)]: write_sd_by_inode_common (fs/reiser4/plugin/object.c:480)
[nikita-2221]:
WARNING: Failed to save sd for 67002: -5
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 278048163
reiser4[cp(15674)]: key_warning (fs/reiser4/plugin/object.c:97)[nikita-717]:
WARNING: Error for inode 67002 (-5)
reiser4[cp(15674)]: write_sd_by_inode_common (fs/reiser4/plugin/object.c:480)
[nikita-2221]:
WARNING: Failed to save sd for 67002: -5
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 278048163
reiser4[cp(15674)]: key_warning (fs/reiser4/plugin/object.c:97)[nikita-717]:
WARNING: Error for inode 67002 (-5)
reiser4[cp(15674)]: write_sd_by_inode_common (fs/reiser4/plugin/object.c:480)
[nikita-2221]:
WARNING: Failed to save sd for 67002: -5
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 278048163
reiser4[cp(15674)]: key_warning (fs/reiser4/plugin/object.c:97)[nikita-717]:
WARNING: Error for inode 65574 (-5)
reiser4[cp(15674)]: write_sd_by_inode_common (fs/reiser4/plugin/object.c:480)
[nikita-2221]:
WARNING: Failed to save sd for 65574: -5
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 278048163
reiser4[cp(15674)]: key_warning (fs/reiser4/plugin/object.c:97)[nikita-717]:
WARNING: Error for inode 65574 (-5)
reiser4[cp(15674)]: write_sd_by_inode_common (fs/reiser4/plugin/object.c:480)
[nikita-2221]:
WARNING: Failed to save sd for 65574: -5
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 278048163
reiser4[cp(15674)]: key_warning (fs/reiser4/plugin/object.c:97)[nikita-717]:
WARNING: Error for inode 65574 (-5)
reiser4[cp(15674)]: write_sd_by_inode_common (fs/reiser4/plugin/object.c:480)
[nikita-2221]:
WARNING: Failed to save sd for 65574: -5
drivers/usb/input/hid-core.c: input irq status -71 received
drivers/usb/input/hid-core.c: input irq status -71 received
drivers/usb/input/hid-core.c: input irq status -71 received
drivers/usb/input/hid-core.c: input irq status -71 received
drivers/usb/input/hid-core.c: input irq status -71 received
drivers/usb/input/hid-core.c: input irq status -71 received
drivers/usb/input/hid-core.c: input irq status -71 received
drivers/usb/input/hid-core.c: input irq status -71 received
drivers/usb/input/hid-core.c: input irq status -71 received
drivers/usb/input/hid-core.c: input irq status -71 received
drivers/usb/input/hid-core.c: input irq status -71 received
usb 1-3: USB disconnect, address 7
usb 1-3.1: USB disconnect, address 8
usb 1-3.1.1: USB disconnect, address 10
usb 1-3.4: USB disconnect, address 9
scsi2 (0:0): rejecting I/O to device being removed
[often..]
scsi2 (0:0): rejecting I/O to device being removed
attempt to access beyond end of device
sda3: rw=1, want=267627019, limit=44949870
reiser4[khubd(129)]: reiser4_handle_error (fs/reiser4/vfs_ops.c:1433)
[foobar-42]:
reiser4 panicked cowardly: Filesystem error occured

------------[ cut here ]------------
kernel BUG at fs/reiser4/debug.c:131!
invalid operand: 0000 [#1]
PREEMPT 
Modules linked in: nls_cp437
CPU:    0
EIP:    0060:[<c017ebf9>]    Not tainted VLI
EFLAGS: 00010246   (2.6.10-rc3-mm1-jedi2-orig) 
EIP is at reiser4_do_panic+0x15/0xd3
eax: 00000000   ebx: dfc12000   ecx: ffffffff   edx: 00000000
esi: 00000000   edi: dfc12000   ebp: dfc13c54   esp: dfc13c1c
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 129, threadinfo=dfc12000 task=dfe34540)
Stack: c04378a0 c0681ac0 cb111800 c019abaf c04337b0 c0433505 00000599 c8bc3fc0 
       c0195607 d1bc3040 00000000 dfc13c94 dfc13c9c c0195622 000016b2 dfc12000 
       c018a3af c018a4a5 00000001 dfc13c9c 00000001 d96f3800 dfc13c94 00000000 
Call Trace:
 [<c019abaf>] encode_inode_size+0x0/0x17
 [<c0195607>] finish_all_fq+0x8f/0x91
 [<c0195622>] current_atom_finish_all_fq+0x19/0x5d
 [<c018a3af>] current_atom_complete_writes+0xe/0x22
 [<c018a4a5>] commit_current_atom+0xe2/0x1d7
 [<c018ad88>] try_commit_txnh+0x116/0x192
 [<c018ae2c>] commit_txnh+0x28/0x9f
 [<c0189d4e>] txn_end+0x2c/0x30
 [<c0189d5a>] txn_restart+0x8/0x15
 [<c018a5c7>] force_commit_atom_nolock+0x2d/0x3f
 [<c018a726>] txnmgr_force_commit_all+0xf9/0x116
 [<c01992d4>] writeout+0x21/0xa8
 [<c019935b>] reiser4_sync_inodes+0x0/0x9f
 [<c01993b7>] reiser4_sync_inodes+0x5c/0x9f
 [<c019935b>] reiser4_sync_inodes+0x0/0x9f
 [<c016c5b5>] sync_sb_inodes+0x19/0x1b
 [<c016c708>] sync_inodes_sb+0x6f/0x89
 [<c014e156>] fsync_super+0xa/0x88
 [<c014e1f0>] fsync_bdev+0x1c/0x43
 [<c0163951>] __invalidate_device+0x57/0x59
 [<c02c63d5>] invalidate_partition+0x2c/0x42
 [<c017be3d>] del_gendisk+0x17/0xb2
 [<c02f9be6>] sd_remove+0x17/0x50
 [<c02bdaad>] device_release_driver+0x6d/0x6f
 [<c02bdc93>] bus_remove_device+0x52/0x8e
 [<c02bcd8a>] device_del+0x5a/0x8f
 [<c02f7206>] scsi_remove_device+0x4d/0xa9
 [<c02f65f2>] scsi_forget_host+0x39/0x78
 [<c02f0a1d>] scsi_remove_host+0x8/0x5e
 [<c0323e69>] storage_disconnect+0x7b/0x90
 [<c030d1ba>] usb_unbind_interface+0x6e/0x70
 [<c02bdaad>] device_release_driver+0x6d/0x6f
 [<c02bdc93>] bus_remove_device+0x52/0x8e
 [<c02bcd8a>] device_del+0x5a/0x8f
 [<c0313fdf>] usb_disable_device+0xa0/0xd5
 [<c030f153>] usb_disconnect+0x8b/0x134
 [<c030f1d7>] usb_disconnect+0x10f/0x134
 [<c0310968>] hub_port_connect_change+0x383/0x3a2
 [<c0310bbe>] hub_events+0x237/0x36a
 [<c0310d24>] hub_thread+0x33/0x104
 [<c0128d94>] autoremove_wake_function+0x0/0x43
 [<c0102dbe>] ret_from_fork+0x6/0x14
 [<c0128d94>] autoremove_wake_function+0x0/0x43
 [<c0310cf1>] hub_thread+0x0/0x104
 [<c0101291>] kernel_thread_helper+0x5/0xb
Code: 42 70 e8 4b c0 28 00 eb 9a 8d 42 70 e8 41 c0 28 00 eb d0 90 90 90 83 ec 
0c 89 5c 24 08 8b 4c 24 10 8b 1d a0 1a 68 c0 85 db 74 1c <0f> 0b 83 00 9d 2e 
43 c0 c7 04 24 c7 cc 44 c0 c7 44 24 04 c0 1a 
 <6>note: khubd[129] exited with preempt_count 1
scsi2 (0:0): rejecting I/O to device being removed
scsi2 (0:0): rejecting I/O to device being removed
scsi2 (0:0): rejecting I/O to device being removed
Buffer I/O error on device sda1, logical block 819213
lost page write due to I/O error on sda1
scsi2 (0:0): rejecting I/O to device being removed

I had to use sysrq to reboot, reboot would just hang as would lsusb.
USB enviroment is an ICH-4 ehci, one hub and an icy-box. uhci drivers not 
compiled.

regards
Alex

-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
