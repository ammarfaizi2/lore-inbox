Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264312AbTE0W2T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 18:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264325AbTE0W2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 18:28:19 -0400
Received: from smtp.terra.es ([213.4.129.129]:14189 "EHLO tsmtp3.ldap.isp")
	by vger.kernel.org with ESMTP id S264312AbTE0W2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 18:28:05 -0400
Date: Tue, 27 May 2003 23:03:00 +0200
From: Arador <grundig@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: 2.5.70: "slab corruption" and "
Message-Id: <20030527230300.11f3dc5b.grundig@teleline.es>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__27_May_2003_23:03:00_+0200_08a4e440"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Tue__27_May_2003_23:03:00_+0200_08a4e440
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi, while booting 2.5.70 i got this:

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Adding 530104k swap on /dev/hda6.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda5, internal journal
Slab corruption: start=cfbfae08, expend=cfbfaf7f, problemat=cfbfaf48
Last user: [<c01913bd>](proc_destroy_inode+0x1d/0x30)
Data: ********************************************************************************************************************************************************************************************************************************************************************************************************************************BC 0B 76 CF ***************************************************A5 
Next: 71 F0 2C .BD 13 19 C0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
slab error in check_poison_obj(): cache `proc_inode_cache': object was modified after freeing
Call Trace:
 [<c014580b>] check_poison_obj+0x15b/0x1b0
 [<c01477dc>] kmem_cache_alloc+0x13c/0x180
 [<c019133e>] proc_alloc_inode+0x1e/0x80
 [<c019133e>] proc_alloc_inode+0x1e/0x80
 [<c017bf0e>] alloc_inode+0x1e/0x150
 [<c017cb0c>] new_inode+0x1c/0xd0
 [<c01934fa>] proc_pid_make_inode+0x1a/0xd0
 [<c0193d81>] proc_pident_lookup+0x101/0x230
 [<c017a5fe>] d_alloc+0x1e/0x250
 [<c0194112>] proc_pid_lookup+0xa2/0x270
 [<c01917a7>] proc_root_lookup+0x27/0x120
 [<c016ebb4>] real_lookup+0xd4/0x100
 [<c016f079>] do_lookup+0x99/0xb0
 [<c016f1c8>] link_path_walk+0x138/0xb20
 [<c01477dc>] kmem_cache_alloc+0x13c/0x180
 [<c0170140>] __user_walk+0x40/0x60
 [<c016a0be>] vfs_stat+0x1e/0x60
 [<c016a74b>] sys_stat64+0x1b/0x40
 [<c0109b1f>] syscall_call+0x7/0xb



The warning happened during the init scripts and didn't happen again:
May 27 21:49:04 estel kernel: Adding 530104k swap on /dev/hda6.  Priority:-1 extents:1
May 27 21:49:04 estel kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda5, internal journal
May 27 21:49:05 estel kernel: Slab corruption: start=cfbfae08, expend=cfbfaf7f, 



machine is SMP p3 2x800 256 ram UDMA100 ide disks. config.gz attached



BTW, i also get zillions of 
PPP: VJ decompression error
(78 times in 1 hour through a serial 56k modem)


did't happened with plain .69 or .69-mm8
Also, apparently the ppp link seems to work without problems.


Diego Calleja


--Multipart_Tue__27_May_2003_23:03:00_+0200_08a4e440
Content-Type: application/octet-stream;
 name=".config.gz"
Content-Disposition: attachment;
 filename=".config.gz"
Content-Transfer-Encoding: base64

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
fYKHuImapoLEjJTzB3fMknNAWgAA

--Multipart_Tue__27_May_2003_23:03:00_+0200_08a4e440--
