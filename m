Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265179AbTLRPEm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 10:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265205AbTLRPEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 10:04:42 -0500
Received: from postoffice9.mail.cornell.edu ([132.236.56.39]:20450 "EHLO
	postoffice9.mail.cornell.edu") by vger.kernel.org with ESMTP
	id S265179AbTLRPEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 10:04:37 -0500
Message-ID: <3FE16E52.8090105@cornell.edu>
Date: Thu, 18 Dec 2003 10:07:30 +0100
From: Knoppix User <ivg2@cornell.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: XFS trouble on 2.6.0-test11
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Congratulations on your 2.6.0 release. I hate to spoil it but I'm having 
some serious XFS trouble.
I was attempting to build an rpm of the latest kernel, when XFS crashed,
and over the next few boots ( while I was trying to fix program after 
program) completely managed
to mess up my system to the point when it no longer boots. In fact, it 
doesn't even mount
most of the time. Anyway, I managed to save the original error, so here 
it is (see below).
Any ideas as to what's wrong and how I can fix my filesystem? It's a 
miracle it actually mounted
under Knoppix so I could retrieve the error - it failed the last few 
times I tried to mount.
Apparently the recovery during mount is not doing its job, since the 
filesystem continually
corrupts everything I touch and is causing lots of damage. Note: I have 
not had any trouble
with XFS before and I have been running the 2.6.0-test11 kernel for a 
while (1-2 weeks?)

I will not be able to reply to this message for at least 24 hrs as I 
have to catch a flight very soon.
Unfortunately my computer's  not coming along, so I won't be able to 
help with any testing for a month.

Here's the error I got:

Filesystem "hda7": XFS internal error xfs_alloc_read_agf at line 2208 of 
file fs/xfs/xfs_alloc.c.  Caller 0xc01bb7ea
Call Trace:
 [<c01bbbc2>] xfs_alloc_read_agf+0xe2/0x1e0
 [<c01bb7ea>] xfs_alloc_fix_freelist+0x45a/0x470
 [<c01bb7ea>] xfs_alloc_fix_freelist+0x45a/0x470
 [<c01bb7ea>] xfs_alloc_fix_freelist+0x45a/0x470
 [<c01ff87b>] xlog_grant_log_space+0x12b/0x380
 [<c0142a5c>] cache_grow+0x17c/0x290
 [<c01bc0e3>] xfs_free_extent+0x93/0xf0
 [<c01ed116>] xfs_efd_init+0x116/0x140
 [<c020e518>] xfs_trans_get_efd+0x38/0x50
 [<c0205348>] xlog_recover_process_efi+0x188/0x200
 [<c0205415>] xlog_recover_process_efis+0x55/0xa0
 [<c0206b74>] xlog_recover_finish+0x24/0xf0
 [<c01b0ff3>] xfs_qm_newmount+0x93/0x190
 [<c01fd40c>] xfs_log_mount_finish+0x2c/0x30
 [<c020839f>] xfs_mountfs+0x8cf/0xfd0
 [<c0225710>] xfs_setsize_buftarg+0x40/0x80
 [<c01fa8fe>] xfs_ioinit+0x1e/0x40
 [<c02102df>] xfs_mount+0x33f/0x5e0
 [<c02263b4>] vfs_mount+0x34/0x40
 [<c02263b4>] vfs_mount+0x34/0x40
 [<c022619b>] linvfs_fill_super+0x9b/0x220
 [<c02373b7>] snprintf+0x27/0x30
 [<c018b262>] disk_name+0x62/0xb0
 [<c015cfb5>] sb_set_blocksize+0x25/0x60
 [<c015c954>] get_sb_bdev+0x124/0x160
 [<c022634f>] linvfs_get_sb+0x2f/0x60
 [<c0226100>] linvfs_fill_super+0x0/0x220
 [<c015cbc3>] do_kern_mount+0x63/0x110
 [<c017290a>] do_add_mount+0x6a/0x150
 [<c0172c30>] do_mount+0x150/0x1a0
 [<c0172a70>] copy_mount_options+0x80/0xf0
 [<c0172fff>] sys_mount+0xbf/0x140
 [<c0420c1f>] do_mount_root+0x2f/0xa0
 [<c0420ce4>] mount_block_root+0x54/0x120
 [<c0420f26>] mount_root+0x36/0x40
 [<c0420f75>] prepare_namespace+0x45/0x150
 [<c01050d7>] init+0x37/0x160
 [<c01050a0>] init+0x0/0x160
 [<c0109289>] kernel_thread_helper+0x5/0xc

Failed mount attempts also talk about error in  xfs_alloc_read_agf.





