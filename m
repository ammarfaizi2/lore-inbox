Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbUBHRyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 12:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263983AbUBHRyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 12:54:08 -0500
Received: from [193.170.124.123] ([193.170.124.123]:5181 "EHLO 23.cms.ac")
	by vger.kernel.org with ESMTP id S263963AbUBHRx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 12:53:58 -0500
Date: Sun, 8 Feb 2004 18:53:34 +0100
From: JG <jg@cms.ac>
To: linux-kernel@vger.kernel.org
Subject: could someone plz explain those ext3/hard disk errors
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Gentoo 1.4 ;)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__8_Feb_2004_18_53_35_+0100_1A2QSvtUXT4WwK7z"
Message-Id: <20040208175346.767881A96E1@23.cms.ac>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__8_Feb_2004_18_53_35_+0100_1A2QSvtUXT4WwK7z
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

hi,

i'm getting many many disk errors and there already died 4 hard disks (IDE, different vendors) within two months (even the newer ones). i was able to save most of the data, but now even my spare disks are full and since 1 hour the next 2 disks are showing problems.
i don't know if the mainboard, the raid controller or all disks are dying, everything else works fine but it seems very strange that 6 disks die that fast.

could someone please explain those errors? i know they are many, but i'm completely lost.

hdi = 200gb maxtor
hdj = 200gb maxtor
hdk = 120gb seagate
mainboard = elitegroup k7s5a
raidcontroller = highpoint rocketraid 404, hpt374
kernel 2.6.2

recently died 3 160gb maxtor and 1 120gb hitachi/ibm
------------
init_special_inode: bogus i_mode (76557)
init_special_inode: bogus i_mode (74557)
init_special_inode: bogus i_mode (74557)
EXT3-fs error (device hdf1): ext3_readdir: bad entry in directory #15941633: directory entry across blocks - offset=0, inode=410738721, rec_len=4124, name_len=25
Aborting journal on device hdf1.

hdi: task_out_intr: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
hdi: task_out_intr: error=0x7f { DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound AddrMarkNotFound }, LBAsect=280923064991615, high=16744319, low=8355711, sector=199145949
ide4: reset: success

hdi: drive not ready for command
ide4: reset: master: error (0x7f?)
blk: queue e7ca1800, I/O limit 4095Mb (mask 0xffffffff)
end_request: I/O error, dev hdi, sector 199145948
Buffer I/O error on device hdi2, logical block 526
lost page write due to I/O error on hdi2
end_request: I/O error, dev hdi, sector 57151695
end_request: I/O error, dev hdi, sector 199141740
Buffer I/O error on device hdi2, logical block 0
lost page write due to I/O error on hdi2
hdk: dma_timer_expiry: dma status == 0x00
hdk: DMA timeout retry
hdk: timeout waiting for DMA
hdk: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hdk: drive not ready for command
end_request: I/O error, dev hdi, sector 57151695
end_request: I/O error, dev hdi, sector 57151695
EXT3-fs error (device hdi1): ext3_readdir: directory #3571715 contains a hole at offset 0
Aborting journal on device hdi1.
end_request: I/O error, dev hdi, sector 4271
Buffer I/O error on device hdi1, logical block 526
lost page write due to I/O error on hdi1
end_request: I/O error, dev hdi, sector 63
Buffer I/O error on device hdi1, logical block 0
lost page write due to I/O error on hdi1
ext3_abort called.
EXT3-fs abort (device hdi1): ext3_journal_start: Detected aborted journal
Remounting filesystem read-only
end_request: I/O error, dev hdi, sector 57151695
EXT3-fs error (device hdi1): ext3_readdir: directory #3571715 contains a hole at offset 0
end_request: I/O error, dev hdi, sector 57151695
end_request: I/O error, dev hdi, sector 57151695

EXT3-fs error (device hdi2): ext3_readdir: directory #32769 contains a hole at offset 0
buffer layer error at fs/buffer.c:1262
Call Trace:
 [<c0150684>] mark_buffer_dirty+0x54/0x60
 [<c0192151>] ext3_commit_super+0x51/0x90
 [<c018fdb5>] ext3_handle_error+0x75/0xb0
 [<c018fe45>] ext3_error+0x55/0x60
 [<c0185c7d>] ext3_readdir+0x4cd/0x500
 [<c01ca863>] capable+0x23/0x50
 [<c014363d>] do_brk+0x15d/0x230
 [<c015f85c>] vfs_readdir+0x9c/0xa0
 [<c015fb70>] filldir64+0x0/0x150
 [<c015fd3b>] sys_getdents64+0x7b/0xc1
 [<c015fb70>] filldir64+0x0/0x150
 [<c0108f0f>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2666
Call Trace:
 [<c0152a90>] submit_bh+0x1a0/0x200
 [<c01398ab>] __set_page_dirty_nobuffers+0x7b/0x90
 [<c0152bdc>] sync_dirty_buffer+0x5c/0xc0
 [<c018fdb5>] ext3_handle_error+0x75/0xb0
 [<c018fe45>] ext3_error+0x55/0x60
 [<c0185c7d>] ext3_readdir+0x4cd/0x500
 [<c01ca863>] capable+0x23/0x50
 [<c014363d>] do_brk+0x15d/0x230
 [<c015f85c>] vfs_readdir+0x9c/0xa0
 [<c015fb70>] filldir64+0x0/0x150
 [<c015fd3b>] sys_getdents64+0x7b/0xc1
 [<c015fb70>] filldir64+0x0/0x150
 [<c0108f0f>] syscall_call+0x7/0xb

end_request: I/O error, dev hdi, sector 199141740
Buffer I/O error on device hdi2, logical block 0
lost page write due to I/O error on hdi2
ext3_abort called.
EXT3-fs abort (device hdi2): ext3_journal_start: Detected aborted journal
Remounting filesystem read-only

buffer layer error at fs/buffer.c:1262
Call Trace:
 [<c0150684>] mark_buffer_dirty+0x54/0x60
 [<c019c4a0>] journal_update_superblock+0x50/0xb0
 [<c01656f3>] destroy_inode+0x43/0x70
 [<c019c7e9>] journal_destroy+0xa9/0x190
 [<c019493e>] ext3_xattr_put_super+0x1e/0x30
 [<c01902f9>] ext3_put_super+0x29/0x190
 [<c0154296>] generic_shutdown_super+0xf6/0x110
 [<c0154bbd>] kill_block_super+0x1d/0x50
 [<c01540d8>] deactivate_super+0x48/0x80
 [<c0168a6f>] sys_umount+0x3f/0x90
 [<c0168ad7>] sys_oldumount+0x17/0x20
 [<c0108f0f>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2666
Call Trace:
 [<c0152a90>] submit_bh+0x1a0/0x200
 [<c0152bdc>] sync_dirty_buffer+0x5c/0xc0
 [<c015066b>] mark_buffer_dirty+0x3b/0x60
 [<c019c4b4>] journal_update_superblock+0x64/0xb0
 [<c01656f3>] destroy_inode+0x43/0x70
 [<c019c7e9>] journal_destroy+0xa9/0x190
 [<c019493e>] ext3_xattr_put_super+0x1e/0x30
 [<c01902f9>] ext3_put_super+0x29/0x190
 [<c0154296>] generic_shutdown_super+0xf6/0x110
 [<c0154bbd>] kill_block_super+0x1d/0x50
 [<c01540d8>] deactivate_super+0x48/0x80
 [<c0168a6f>] sys_umount+0x3f/0x90
 [<c0168ad7>] sys_oldumount+0x17/0x20
 [<c0108f0f>] syscall_call+0x7/0xb

-------
hdj: task_out_intr: status=0x51 { DriveReady SeekComplete Error }
hdj: task_out_intr: error=0x04 { DriveStatusError }
hdj: task_out_intr: status=0x58 { DriveReady SeekComplete DataRequest }
hdj: task_out_intr: status=0x51 { DriveReady SeekComplete Error }
hdj: task_out_intr: error=0x51 { UncorrectableError SectorIdNotFound AddrMarkNotFound }, LBAsect=141
284313497587, high=8421201, low=5341171, sector=4326
end_request: I/O error, dev hdj, sector 4319
Buffer I/O error on device hdj1, logical block 532
lost page write due to I/O error on hdj1
hdj: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
hdj: status error: error=0x51 { UncorrectableError SectorIdNotFound AddrMarkNotFound }, LBAsect=1412
84313497471, high=8421201, low=5341055, sector=63
end_request: I/O error, dev hdj, sector 63
Buffer I/O error on device hdj1, logical block 0
lost page write due to I/O error on hdj1
hdj: no DRQ after issuing WRITE_EXT

[...]

thx!
JG


--Signature=_Sun__8_Feb_2004_18_53_35_+0100_1A2QSvtUXT4WwK7z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAJnepU788cpz6t2kRAqTkAKCHYyRPR5KWnTIAG1vxQCjITa2uZACdFUMF
YroDDVNqBp7L/11rACP7zaM=
=2B2y
-----END PGP SIGNATURE-----

--Signature=_Sun__8_Feb_2004_18_53_35_+0100_1A2QSvtUXT4WwK7z--
