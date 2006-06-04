Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751302AbWFDJoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWFDJoM (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 05:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWFDJoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 05:44:12 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:44767 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1751302AbWFDJoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 05:44:12 -0400
Message-ID: <4482AB6A.9010105@dgreaves.com>
Date: Sun, 04 Jun 2006 10:44:10 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: 2.6.17-rc3: XFS internal error xlog_clear_stale_blocks(1)
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

vanilla 2.6.17-rc3

mounting onto an lvm2 ontop of raid5 on top of sata

Filesystem "dm-0": Disabling barriers, not supported by the underlying
device
XFS mounting filesystem dm-0
Filesystem "dm-0": XFS internal error xlog_clear_stale_blocks(1) at line
1225 of file fs/xfs/xfs_log_recover.c.  Caller 0xb01fca2f
 <b01fb8d9> xlog_find_tail+0xa39/0xeb0   <b01fca2f> xlog_recover+0x2f/0x2f0
 <b01fca2f> xlog_recover+0x2f/0x2f0   <b01f5566> xfs_log_mount+0x256/0x650
 <b01fec19> xfs_mountfs+0xd09/0x1260   <b021b199>
xfs_mountfs_check_barriers+0x39/0x120
 <b0207cef> xfs_mount+0xa2f/0xbf0   <b021c130> xfs_fs_fill_super+0xa0/0x250
 <b0237e8b> snprintf+0x2b/0x30   <b0198095> disk_name+0xd5/0xf0
 <b016644f> sb_set_blocksize+0x1f/0x50   <b0165407> get_sb_bdev+0x117/0x155
 <b021b6ff> xfs_fs_get_sb+0x2f/0x40   <b021c090> xfs_fs_fill_super+0x0/0x250
 <b0164882> do_kern_mount+0x52/0xe0   <b017cd1d> do_mount+0x29d/0x770
 <b016eb8e> do_path_lookup+0x10e/0x270   <b016c35a> getname+0xda/0x100
 <b014219e> __alloc_pages+0x5e/0x2f0   <b01426e4> __get_free_pages+0x34/0x60
 <b017b824> copy_mount_options+0x44/0x140   <b017d28d> sys_mount+0x9d/0xe0
 <b010304b> syscall_call+0x7/0xb
XFS: failed to locate log tail
XFS: log mount/recovery failed: error 990
XFS: log mount failed


Anything else I can do?
(is it worth trying -rc5?)

I'm building 2.6.16.19 and I'll try that shortly...

David

-- 

