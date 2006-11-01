Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946707AbWKAIZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946707AbWKAIZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 03:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946708AbWKAIZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 03:25:11 -0500
Received: from holoclan.de ([62.75.158.126]:40078 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S1946707AbWKAIZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 03:25:08 -0500
Date: Wed, 1 Nov 2006 09:23:31 +0100
From: Martin Lorenz <martin@lorenz.eu.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.18/Reiser3 - lost directory and strange warnings
Message-ID: <20061101082331.GA6438@gimli>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  panic arose about an hour ago... a whole directory tree
	was suddenly gone and every try to access it resulted in an i/o error
	the log shows this: [53933.922000] ata1: SATA link up 1.5 Gbps (SStatus
	113 SControl 300) [53933.926000] ata1.00: configured for UDMA/100
	[53934.007000] SCSI device sda: 156301488 512-byte hdwr sectors (80026
	MB) [53934.014000] sda: Write Protect is off [53934.014000] sda: Mode
	Sense: 00 3a 00 00 [53934.022000] SCSI device sda: drive cache: write
	back [54316.760000] ReiserFS: warning: is_tree_node: node level 0 does
	not match to the expected one 1 [54316.760000] ReiserFS: sda8: warning:
	vs-5150: search_by_key: invalid format found in block 2326540. Fsck?
	[54316.760000] ReiserFS: sda8: warning: zam-7001: io error in
	reiserfs_find_entry [54341.302000] ReiserFS: warning: is_tree_node: node
	level 0 does not match to the expected one 1 [54341.302000] ReiserFS:
	sda8: warning: vs-5150: search_by_key: invalid format found in block
	2326540. Fsck? [54369.880000] ReiserFS: warning: is_tree_node: node
	level 0 does not match to the expected one 1 [54369.880000] ReiserFS:
	sda8: warning: vs-5150: search_by_key: invalid format found in block
	2326540. Fsck? [54505.683000] ReiserFS: warning: is_tree_node: node
	level 0 does not match to the expected one 1 [54505.683000] ReiserFS:
	sda8: warning: vs-5150: search_by_key: invalid format found in block
	2326540. Fsck? [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

panic arose about an hour ago...
a whole directory tree was suddenly gone and every try to access it resulted
in an i/o error

the log shows this:

[53933.922000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[53933.926000] ata1.00: configured for UDMA/100
[53934.007000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[53934.014000] sda: Write Protect is off
[53934.014000] sda: Mode Sense: 00 3a 00 00
[53934.022000] SCSI device sda: drive cache: write back
[54316.760000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
[54316.760000] ReiserFS: sda8: warning: vs-5150: search_by_key: invalid format found in block 2326540. Fsck?
[54316.760000] ReiserFS: sda8: warning: zam-7001: io error in reiserfs_find_entry
[54341.302000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
[54341.302000] ReiserFS: sda8: warning: vs-5150: search_by_key: invalid format found in block 2326540. Fsck?
[54369.880000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
[54369.880000] ReiserFS: sda8: warning: vs-5150: search_by_key: invalid format found in block 2326540. Fsck?
[54505.683000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
[54505.683000] ReiserFS: sda8: warning: vs-5150: search_by_key: invalid format found in block 2326540. Fsck?

a reboot into maintainance mode and fsck of the partition brought the dir
back without data loss (pffffew!)

but I am still concerned, what has happened here?

a grep on my syslogs revealed quite a few similar warnings which I obviously
diden't notice. - attached wich a few lines of context

see http://www.lorenz.eu.org/~mlo/kernel/?C=M;O=D for more


gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="all_reiser-warnings_syslog.txt"

Nov  1 08:15:12 gimli kernel: [53933.926000] ata1.00: configured for UDMA/100
Nov  1 08:15:12 gimli kernel: [53934.007000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
Nov  1 08:15:12 gimli kernel: [53934.014000] sda: Write Protect is off
Nov  1 08:15:12 gimli kernel: [53934.014000] sda: Mode Sense: 00 3a 00 00
Nov  1 08:15:12 gimli kernel: [53934.022000] SCSI device sda: drive cache: write back
Nov  1 08:21:35 gimli kernel: [54316.760000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
Nov  1 08:21:35 gimli kernel: [54316.760000] ReiserFS: sda8: warning: vs-5150: search_by_key: invalid format found in block 2326540. Fsck?
Nov  1 08:21:35 gimli kernel: [54316.760000] ReiserFS: sda8: warning: zam-7001: io error in reiserfs_find_entry
Nov  1 08:21:59 gimli kernel: [54341.302000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
Nov  1 08:21:59 gimli kernel: [54341.302000] ReiserFS: sda8: warning: vs-5150: search_by_key: invalid format found in block 2326540. Fsck?
Nov  1 08:22:28 gimli kernel: [54369.880000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
Nov  1 08:22:28 gimli kernel: [54369.880000] ReiserFS: sda8: warning: vs-5150: search_by_key: invalid format found in block 2326540. Fsck?
Nov  1 08:24:44 gimli kernel: [54505.683000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
Nov  1 08:24:44 gimli kernel: [54505.683000] ReiserFS: sda8: warning: vs-5150: search_by_key: invalid format found in block 2326540. Fsck?
Nov  1 08:26:31 gimli kernel: [54613.550000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80
Oct 30 07:40:44 gimli kernel: [35373.594000] e1000: eth0: e1000_watchdog: NIC Link is Down
Oct 30 07:40:54 gimli kernel: [35383.310000] Disabling non-boot CPUs ...
Oct 30 07:40:54 gimli kernel: [35383.313000] Breaking affinity for irq 219
--
Oct 30 04:39:20 gimli kernel: [24489.537000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80
Oct 30 04:54:34 gimli kernel: [25403.757000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80
Oct 30 05:33:29 gimli kernel: [27738.717000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80
Oct 30 05:33:52 gimli kernel: [27761.957000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80
Oct 30 06:31:35 gimli kernel: [31224.577000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80
Oct 28 07:42:59 gimli kernel: [70038.033000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
Oct 28 07:42:59 gimli kernel: [70038.033000] ReiserFS: sda7: warning: vs-5150: search_by_key: invalid format found in block 1114212. Fsck?
Oct 28 07:42:59 gimli kernel: [70038.033000] ReiserFS: sda7: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [103 18726 0x0 SD]
Oct 28 07:42:59 gimli kernel: [70038.038000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
Oct 28 07:42:59 gimli kernel: [70038.038000] ReiserFS: sda7: warning: vs-5150: search_by_key: invalid format found in block 1114212. Fsck?
Oct 28 07:42:59 gimli kernel: [70038.038000] ReiserFS: sda7: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [103 18706 0x0 SD]
Oct 28 07:45:13 gimli kernel: [70172.340000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80
Oct 28 07:57:05 gimli kernel: [70884.560000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80
Oct 28 08:00:23 gimli kernel: [71082.140000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80
--
Oct 28 11:30:22 gimli kernel: [83680.820000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80
Oct 28 11:34:04 gimli kernel: [83903.100000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80
Oct 28 11:40:17 gimli kernel: [84276.020000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80
Oct 28 11:41:34 gimli kernel: [84352.560000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80
Oct 28 12:13:07 gimli kernel: [86246.235000] tp_smapi unloaded.
Oct 28 12:13:39 gimli kernel: [86277.620000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
Oct 28 12:13:39 gimli kernel: [86277.620000] ReiserFS: sda7: warning: vs-5150: search_by_key: invalid format found in block 1114212. Fsck?
Oct 28 12:13:39 gimli kernel: [86277.620000] ReiserFS: sda7: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [103 18706 0x0 SD]
Oct 28 12:13:39 gimli kernel: [86277.623000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
Oct 28 12:13:39 gimli kernel: [86277.623000] ReiserFS: sda7: warning: vs-5150: search_by_key: invalid format found in block 1114212. Fsck?
Oct 28 12:13:39 gimli kernel: [86277.623000] ReiserFS: sda7: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [103 18726 0x0 SD]
Oct 28 12:13:39 gimli kernel: [86277.744000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
Oct 28 12:13:39 gimli kernel: [86277.744000] ReiserFS: sda7: warning: vs-5150: search_by_key: invalid format found in block 1114212. Fsck?
Oct 28 12:13:39 gimli kernel: [86277.744000] ReiserFS: sda7: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [103 18706 0x0 SD]
Oct 28 12:13:39 gimli kernel: [86277.747000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
Oct 28 12:13:39 gimli kernel: [86277.747000] ReiserFS: sda7: warning: vs-5150: search_by_key: invalid format found in block 1114212. Fsck?
Oct 28 12:13:39 gimli kernel: [86277.747000] ReiserFS: sda7: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [103 18726 0x0 SD]
Oct 28 12:14:10 gimli kernel: [86308.509000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
Oct 28 12:14:10 gimli kernel: [86308.509000] ReiserFS: sda7: warning: vs-5150: search_by_key: invalid format found in block 1114212. Fsck?
Oct 28 12:14:10 gimli kernel: [86308.509000] ReiserFS: sda7: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [103 18706 0x0 SD]
Oct 28 12:14:14 gimli kernel: [86312.501000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
Oct 28 12:14:14 gimli kernel: [86312.501000] ReiserFS: sda7: warning: vs-5150: search_by_key: invalid format found in block 1114212. Fsck?
Oct 28 12:14:14 gimli kernel: [86312.501000] ReiserFS: sda7: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [103 18706 0x0 SD]
Oct 28 12:14:14 gimli kernel: [86312.514000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
Oct 28 12:14:14 gimli kernel: [86312.514000] ReiserFS: sda7: warning: vs-5150: search_by_key: invalid format found in block 1114212. Fsck?
Oct 28 12:14:14 gimli kernel: [86312.514000] ReiserFS: sda7: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [103 18726 0x0 SD]
Oct 28 12:14:21 gimli kernel: [86320.190000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
Oct 28 12:14:21 gimli kernel: [86320.190000] ReiserFS: sda7: warning: vs-5150: search_by_key: invalid format found in block 1114212. Fsck?
Oct 28 12:14:21 gimli kernel: [86320.190000] ReiserFS: sda7: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [103 18706 0x0 SD]
Oct 28 12:14:27 gimli kernel: [86326.168000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
Oct 28 12:14:27 gimli kernel: [86326.168000] ReiserFS: sda7: warning: vs-5150: search_by_key: invalid format found in block 1114212. Fsck?
Oct 28 12:14:27 gimli kernel: [86326.168000] ReiserFS: sda7: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [103 18706 0x0 SD]
Oct 28 12:30:16 gimli kernel: [87274.600000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80
Oct 28 12:32:42 gimli kernel: [87421.220000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80
Oct 28 12:34:05 gimli kernel: [87503.440000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80
Oct 28 12:45:24 gimli kernel: [88183.060000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80
Oct 28 12:45:44 gimli kernel: [88203.370000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
Oct 28 12:45:44 gimli kernel: [88203.370000] ReiserFS: sda7: warning: vs-5150: search_by_key: invalid format found in block 1114212. Fsck?
Oct 28 12:45:44 gimli kernel: [88203.370000] ReiserFS: sda7: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [103 18706 0x0 SD]
Oct 28 13:02:55 gimli kernel: [89234.140000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80
Oct 28 13:06:49 gimli kernel: [89467.700000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80
Oct 28 13:07:02 gimli kernel: [89481.207000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
Oct 28 13:07:02 gimli kernel: [89481.207000] ReiserFS: sda7: warning: vs-5150: search_by_key: invalid format found in block 1114212. Fsck?
Oct 28 13:07:02 gimli kernel: [89481.207000] ReiserFS: sda7: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [103 18706 0x0 SD]
Oct 28 13:07:02 gimli kernel: [89481.216000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
Oct 28 13:07:02 gimli kernel: [89481.216000] ReiserFS: sda7: warning: vs-5150: search_by_key: invalid format found in block 1114212. Fsck?
Oct 28 13:07:02 gimli kernel: [89481.216000] ReiserFS: sda7: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [103 18726 0x0 SD]
Oct 28 13:07:02 gimli kernel: [89481.378000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
Oct 28 13:07:02 gimli kernel: [89481.378000] ReiserFS: sda7: warning: vs-5150: search_by_key: invalid format found in block 1114212. Fsck?
Oct 28 13:07:02 gimli kernel: [89481.378000] ReiserFS: sda7: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [103 18706 0x0 SD]
Oct 28 13:07:02 gimli kernel: [89481.381000] ReiserFS: warning: is_tree_node: node level 0 does not match to the expected one 1
Oct 28 13:07:02 gimli kernel: [89481.381000] ReiserFS: sda7: warning: vs-5150: search_by_key: invalid format found in block 1114212. Fsck?
Oct 28 13:07:02 gimli kernel: [89481.381000] ReiserFS: sda7: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [103 18726 0x0 SD]
Oct 28 13:09:11 gimli kernel: [89609.640000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80
Oct 28 13:34:52 gimli kernel: [91151.080000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80
Oct 28 13:42:35 gimli kernel: [91613.740000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80

--Qxx1br4bt0+wmkIi--
