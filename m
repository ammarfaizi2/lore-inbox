Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261737AbSKHJxp>; Fri, 8 Nov 2002 04:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261748AbSKHJxp>; Fri, 8 Nov 2002 04:53:45 -0500
Received: from FORT-POINT-STATION.MIT.EDU ([18.7.7.76]:49821 "EHLO
	fort-point-station.mit.edu") by vger.kernel.org with ESMTP
	id <S261737AbSKHJxo>; Fri, 8 Nov 2002 04:53:44 -0500
Date: Fri, 8 Nov 2002 05:00:25 -0500
From: Alex <akhripin@MIT.EDU>
To: linux-kernel@vger.kernel.org
Subject: [bug] sleeping function called from illegal context
Message-ID: <20021108100025.GR4729@dodecahedron.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following error logged:
(Not sure if the two are connected in some way)
The problem seems to be somewhere in xfs.

Linux <snip> 2.5.46 #1 Wed Nov 6 02:10:38 EST 2002 i686 AMD Duron(TM)Processor AuthenticAMD GNU/Linux

The kernel is configured preemptible, with xfs builtin with no extra xfs
options.

Regards,
Alex Khripin

hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04Aborted Command 
Debug: sleeping function called from illegal context at mm/slab.c:1304
Call Trace:
 [<c013a6d4>] kmem_flagcheck+0x64/0x70
 [<c013ad86>] kmalloc+0x56/0xb0
 [<c01bf8de>] svc_export_lookup+0xfe/0x2c0
 [<c01bfbc9>] exp_get_by_name+0x39/0x70
 [<c01580fb>] link_path_walk+0x53b/0x790
 [<c01bfc35>] exp_parent+0x35/0x90
 [<c01c048d>] exp_rootfh+0x6d/0x190
 [<c021935b>] xfs_bmapi+0x106b/0x1440
 [<c0218598>] xfs_bmapi+0x2a8/0x1440
 [<c0385717>] ip_map_lookup+0x27/0x290
 [<c013bb8c>] cache_alloc_debugcheck_after+0x9c/0xb0
 [<c01b8e5e>] write_getfs+0x12e/0x1d0
 [<c01b897e>] fs_write+0x3e/0x40
 [<c016f057>] sys_nfsservctl+0xd7/0x140
 [<c010ac23>] syscall_call+0x7/0xb

