Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbTKCOfd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 09:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbTKCOfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 09:35:33 -0500
Received: from 209.Red-213-97-17.pooles.rima-tde.net ([213.97.17.209]:48728
	"EHLO mailer.acaso.net") by vger.kernel.org with ESMTP
	id S262034AbTKCOf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 09:35:29 -0500
Subject: Reiserfs 3.5 disk format and kernel 2.6.0test9
From: Jorge =?ISO-8859-1?Q?P=E9rez?= "Burgos (Koke)" <koke@eresmas.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1067869986.4841.4.camel@wathlon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 03 Nov 2003 15:33:07 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I have several partitions with 3.5.x reiserfs disk format, when i boot
up with kernel 2.6.0test9, i have these errors in each partition, even
though the system seems to work well:

buffer layer error at fs/buffer.c:431
Call Trace:
 [<c01559f5>] __find_get_block_slow+0x85/0x120
 [<c0107289>] kernel_thread_helper+0x5/0xc
 [<c010a10c>] dump_stack+0x1c/0x20
 [<c01569c3>] __find_get_block+0x83/0xe0
 [<c0156603>] __getblk_slow+0x23/0xf0
 [<c0156a6f>] __getblk+0x4f/0x60
 [<c0156aff>] __bread+0x1f/0x40
 [<c02058f2>] read_super_block+0x82/0x210
 [<c0206555>] reiserfs_fill_super+0x555/0x5a0
 [<c02229b7>] snprintf+0x27/0x30
 [<c0185922>] disk_name+0x62/0xb0
 [<c015b305>] sb_set_blocksize+0x25/0x60
 [<c015ace4>] get_sb_bdev+0x124/0x160
 [<c020660f>] get_super_block+0x2f/0x60
 [<c0206000>] reiserfs_fill_super+0x0/0x5a0
 [<c015af4f>] do_kern_mount+0x5f/0xe0
 [<c01701d8>] do_add_mount+0x78/0x150
 [<c01704c4>] do_mount+0x124/0x170
 [<c0170330>] copy_mount_options+0x80/0xf0
 [<c017087f>] sys_mount+0xbf/0x140
 [<c046ec5f>] do_mount_root+0x2f/0xa0
 [<c046ed24>] mount_block_root+0x54/0x120
 [<c046ef71>] mount_root+0x41/0x70
 [<c046efcb>] prepare_namespace+0x2b/0xe0
 [<c01050d7>] init+0x37/0x160
 [<c01050a0>] init+0x0/0x160
 [<c0107289>] kernel_thread_helper+0x5/0xc
 
block=16, b_blocknr=128
b_state=0x00000019, b_size=512

...




Thx
-- 
Jorge Pérez Burgos
email:	koke@eresmas.net
mobile: +34 607940482
web:	http://www.vaijira.com


