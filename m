Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933405AbWF0LRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933405AbWF0LRb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 07:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933406AbWF0LRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 07:17:31 -0400
Received: from tornado.reub.net ([202.89.145.182]:57309 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S933405AbWF0LR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 07:17:29 -0400
Message-ID: <44A113CB.8050508@reub.net>
Date: Tue, 27 Jun 2006 23:17:31 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060623)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Neil Brown <neilb@suse.de>
Subject: Re: 2.6.17-mm3
References: <20060627015211.ce480da6.akpm@osdl.org>
In-Reply-To: <20060627015211.ce480da6.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/06/2006 8:52 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm3/
> 
> 
> - Added the x86 Geode development tree to the -mm lineup, as git-geode.patch
>   (Jordan Crouse).
> 
> - The locking validator patches are back, in a reworked series.

Hrm:

md: sdc6 has different UUID to sdc7
md: sdc5 has different UUID to sdc7
md: sdc3 has different UUID to sdc7
md: sdc2 has different UUID to sdc7
md:  adding sda7 ...
md: sda6 has different UUID to sdc7
md: sda5 has different UUID to sdc7
md: sda3 has different UUID to sdc7
md: sda2 has different UUID to sdc7
md: created md4
md: bind<sda7>
md: bind<sdc7>
md: running: <sdc7><sda7>
md: kicking non-fresh sda7 from array!
md: unbind<sda7>
md: export_rdev(sda7)
BUG: warning at fs/block_dev.c:1109/__blkdev_put()

Call Trace:
  [<ffffffff802c00b2>] __blkdev_put+0x9c/0x1bb
  [<ffffffff802c01df>] blkdev_put_partition+0xe/0x10
  [<ffffffff8041f174>] unlock_rdev+0x49/0x50
  [<ffffffff8041f1fb>] export_rdev+0x80/0x90
  [<ffffffff80285919>] printk+0x67/0x69
  [<ffffffff8041f2c2>] kick_rdev_from_array+0x19/0x27
  [<ffffffff8042126c>] do_md_run+0x11c/0x7b8
  [<ffffffff8041fc35>] bind_rdev_to_array+0x1f5/0x210
  [<ffffffff8041fe6b>] mddev_find+0x82/0x1dd
  [<ffffffff8042012f>] md_probe+0x169/0x17a
  [<ffffffff80421bf4>] autorun_devices+0x2ec/0x379
  [<ffffffff8033b5da>] selinux_capable+0x24/0x29
  [<ffffffff804247c5>] md_ioctl+0x135/0x154f
  [<ffffffff8033ace3>] avc_has_perm+0x49/0x5b
  [<ffffffff80350c72>] blkdev_driver_ioctl+0x62/0x80
  [<ffffffff80351386>] blkdev_ioctl+0x6f6/0x75a
  [<ffffffff8023f584>] wake_up_inode+0x18/0x24
  [<ffffffff8033b463>] inode_has_perm+0x62/0x71
  [<ffffffff802c0982>] blkdev_open+0x0/0x61
  [<ffffffff802c09ae>] blkdev_open+0x2c/0x61
  [<ffffffff8033b51c>] file_has_perm+0xaa/0xb9
  [<ffffffff802bfa32>] block_ioctl+0x1b/0x1f
  [<ffffffff8024328a>] do_ioctl+0x2a/0x8f
  [<ffffffff802316eb>] vfs_ioctl+0x27b/0x2a0
  [<ffffffff8024e7ca>] sys_ioctl+0x5f/0x82
  [<ffffffff8022f97d>] sys_fcntl+0x33d/0x34f
  [<ffffffff8025ff7a>] system_call+0x7e/0x83

BUG: warning at fs/block_dev.c:1128/__blkdev_put()

Call Trace:
  [<ffffffff80357be8>] kobject_put+0x19/0x21
  [<ffffffff802c0194>] __blkdev_put+0x17e/0x1bb
  [<ffffffff802c01df>] blkdev_put_partition+0xe/0x10
  [<ffffffff8041f174>] unlock_rdev+0x49/0x50
  [<ffffffff8041f1fb>] export_rdev+0x80/0x90
  [<ffffffff80285919>] printk+0x67/0x69
  [<ffffffff8041f2c2>] kick_rdev_from_array+0x19/0x27
  [<ffffffff8042126c>] do_md_run+0x11c/0x7b8
  [<ffffffff8041fc35>] bind_rdev_to_array+0x1f5/0x210
  [<ffffffff8041fe6b>] mddev_find+0x82/0x1dd
  [<ffffffff8042012f>] md_probe+0x169/0x17a
  [<ffffffff80421bf4>] autorun_devices+0x2ec/0x379
  [<ffffffff8033b5da>] selinux_capable+0x24/0x29
  [<ffffffff804247c5>] md_ioctl+0x135/0x154f
  [<ffffffff8033ace3>] avc_has_perm+0x49/0x5b
  [<ffffffff80350c72>] blkdev_driver_ioctl+0x62/0x80
  [<ffffffff80351386>] blkdev_ioctl+0x6f6/0x75a
  [<ffffffff8023f584>] wake_up_inode+0x18/0x24
  [<ffffffff8033b463>] inode_has_perm+0x62/0x71
  [<ffffffff802c0982>] blkdev_open+0x0/0x61
  [<ffffffff802c09ae>] blkdev_open+0x2c/0x61
  [<ffffffff8033b51c>] file_has_perm+0xaa/0xb9
  [<ffffffff802bfa32>] block_ioctl+0x1b/0x1f
  [<ffffffff8024328a>] do_ioctl+0x2a/0x8f
  [<ffffffff802316eb>] vfs_ioctl+0x27b/0x2a0
  [<ffffffff8024e7ca>] sys_ioctl+0x5f/0x82
  [<ffffffff8022f97d>] sys_fcntl+0x33d/0x34f
  [<ffffffff8025ff7a>] system_call+0x7e/0x83

raid1: raid set md4 active with 1 out of 2 mirrors
md4: bitmap initialized from disk: read 4/4 pages, set 80 bits, status: 0
created bitmap (61 pages) for device md4
md: considering sdc6 ...
md:  adding sdc6 ...
md: sdc5 has different UUID to sdc6
md: sdc3 has different UUID to sdc6
md: sdc2 has different UUID to sdc6
md:  adding sda6 ...
md: sda5 has different UUID to sdc6
md: sda3 has different UUID to sdc6
md: sda2 has different UUID to sdc6
md: created md3
md: bind<sda6>
md: bind<sdc6>
md: running: <sdc6><sda6>
md: kicking non-fresh sda6 from array!
md: unbind<sda6>
md: export_rdev(sda6)
BUG: warning at fs/block_dev.c:1109/__blkdev_put()

Call Trace:
  [<ffffffff802c00b2>] __blkdev_put+0x9c/0x1bb
  [<ffffffff802c01df>] blkdev_put_partition+0xe/0x10
  [<ffffffff8041f174>] unlock_rdev+0x49/0x50
  [<ffffffff8041f1fb>] export_rdev+0x80/0x90
  [<ffffffff80285919>] printk+0x67/0x69
  [<ffffffff8041f2c2>] kick_rdev_from_array+0x19/0x27
  [<ffffffff8042126c>] do_md_run+0x11c/0x7b8
  [<ffffffff8041fc35>] bind_rdev_to_array+0x1f5/0x210
  [<ffffffff8041fe6b>] mddev_find+0x82/0x1dd
  [<ffffffff8042012f>] md_probe+0x169/0x17a
  [<ffffffff80421bf4>] autorun_devices+0x2ec/0x379
  [<ffffffff8033b5da>] selinux_capable+0x24/0x29
  [<ffffffff804247c5>] md_ioctl+0x135/0x154f
  [<ffffffff8033ace3>] avc_has_perm+0x49/0x5b
  [<ffffffff80350c72>] blkdev_driver_ioctl+0x62/0x80
  [<ffffffff80351386>] blkdev_ioctl+0x6f6/0x75a
  [<ffffffff8023f584>] wake_up_inode+0x18/0x24
  [<ffffffff8033b463>] inode_has_perm+0x62/0x71
  [<ffffffff802c0982>] blkdev_open+0x0/0x61
  [<ffffffff802c09ae>] blkdev_open+0x2c/0x61
  [<ffffffff8033b51c>] file_has_perm+0xaa/0xb9
  [<ffffffff802bfa32>] block_ioctl+0x1b/0x1f
  [<ffffffff8024328a>] do_ioctl+0x2a/0x8f
  [<ffffffff802316eb>] vfs_ioctl+0x27b/0x2a0
  [<ffffffff8024e7ca>] sys_ioctl+0x5f/0x82
  [<ffffffff8022f97d>] sys_fcntl+0x33d/0x34f
  [<ffffffff8025ff7a>] system_call+0x7e/0x83

BUG: warning at fs/block_dev.c:1128/__blkdev_put()

Call Trace:
  [<ffffffff80357be8>] kobject_put+0x19/0x21
  [<ffffffff802c0194>] __blkdev_put+0x17e/0x1bb
  [<ffffffff802c01df>] blkdev_put_partition+0xe/0x10
  [<ffffffff8041f174>] unlock_rdev+0x49/0x50
  [<ffffffff8041f1fb>] export_rdev+0x80/0x90
  [<ffffffff80285919>] printk+0x67/0x69
  [<ffffffff8041f2c2>] kick_rdev_from_array+0x19/0x27
  [<ffffffff8042126c>] do_md_run+0x11c/0x7b8
  [<ffffffff8041fc35>] bind_rdev_to_array+0x1f5/0x210
  [<ffffffff8041fe6b>] mddev_find+0x82/0x1dd
  [<ffffffff8042012f>] md_probe+0x169/0x17a
  [<ffffffff80421bf4>] autorun_devices+0x2ec/0x379
  [<ffffffff8033b5da>] selinux_capable+0x24/0x29
  [<ffffffff804247c5>] md_ioctl+0x135/0x154f
  [<ffffffff8033ace3>] avc_has_perm+0x49/0x5b
  [<ffffffff80350c72>] blkdev_driver_ioctl+0x62/0x80
  [<ffffffff80351386>] blkdev_ioctl+0x6f6/0x75a
  [<ffffffff8023f584>] wake_up_inode+0x18/0x24
  [<ffffffff8033b463>] inode_has_perm+0x62/0x71
  [<ffffffff802c0982>] blkdev_open+0x0/0x61
  [<ffffffff802c09ae>] blkdev_open+0x2c/0x61
  [<ffffffff8033b51c>] file_has_perm+0xaa/0xb9
  [<ffffffff802bfa32>] block_ioctl+0x1b/0x1f
  [<ffffffff8024328a>] do_ioctl+0x2a/0x8f
  [<ffffffff802316eb>] vfs_ioctl+0x27b/0x2a0
  [<ffffffff8024e7ca>] sys_ioctl+0x5f/0x82
  [<ffffffff8022f97d>] sys_fcntl+0x33d/0x34f
  [<ffffffff8025ff7a>] system_call+0x7e/0x83

raid1: raid set md3 active with 1 out of 2 mirrors
md3: bitmap initialized from disk: read 1/1 pages, set 1 bits, status: 0
created bitmap (13 pages) for device md3
md: considering sdc5 ...
md:  adding sdc5 ...
md: sdc3 has different UUID to sdc5
md: sdc2 has different UUID to sdc5
md:  adding sda5 ...
md: sda3 has different UUID to sdc5
md: sda2 has different UUID to sdc5
md: created md2
md: bind<sda5>
md: bind<sdc5>
md: running: <sdc5><sda5>
md: kicking non-fresh sda5 from array!
md: unbind<sda5>
md: export_rdev(sda5)
BUG: warning at fs/block_dev.c:1109/__blkdev_put()

Call Trace:
  [<ffffffff802c00b2>] __blkdev_put+0x9c/0x1bb
  [<ffffffff802c01df>] blkdev_put_partition+0xe/0x10
  [<ffffffff8041f174>] unlock_rdev+0x49/0x50
  [<ffffffff8041f1fb>] export_rdev+0x80/0x90
  [<ffffffff80285919>] printk+0x67/0x69
  [<ffffffff8041f2c2>] kick_rdev_from_array+0x19/0x27
  [<ffffffff8042126c>] do_md_run+0x11c/0x7b8
  [<ffffffff8041fc35>] bind_rdev_to_array+0x1f5/0x210
  [<ffffffff8041fe6b>] mddev_find+0x82/0x1dd
  [<ffffffff8042012f>] md_probe+0x169/0x17a
  [<ffffffff80421bf4>] autorun_devices+0x2ec/0x379
  [<ffffffff8033b5da>] selinux_capable+0x24/0x29
  [<ffffffff804247c5>] md_ioctl+0x135/0x154f
  [<ffffffff8033ace3>] avc_has_perm+0x49/0x5b
  [<ffffffff80350c72>] blkdev_driver_ioctl+0x62/0x80
  [<ffffffff80351386>] blkdev_ioctl+0x6f6/0x75a
  [<ffffffff8023f584>] wake_up_inode+0x18/0x24
  [<ffffffff8033b463>] inode_has_perm+0x62/0x71
  [<ffffffff802c0982>] blkdev_open+0x0/0x61
  [<ffffffff802c09ae>] blkdev_open+0x2c/0x61
  [<ffffffff8033b51c>] file_has_perm+0xaa/0xb9
  [<ffffffff802bfa32>] block_ioctl+0x1b/0x1f
  [<ffffffff8024328a>] do_ioctl+0x2a/0x8f
  [<ffffffff802316eb>] vfs_ioctl+0x27b/0x2a0
  [<ffffffff8024e7ca>] sys_ioctl+0x5f/0x82
  [<ffffffff8022f97d>] sys_fcntl+0x33d/0x34f
  [<ffffffff8025ff7a>] system_call+0x7e/0x83

BUG: warning at fs/block_dev.c:1128/__blkdev_put()

Call Trace:
  [<ffffffff80357be8>] kobject_put+0x19/0x21
  [<ffffffff802c0194>] __blkdev_put+0x17e/0x1bb
  [<ffffffff802c01df>] blkdev_put_partition+0xe/0x10
  [<ffffffff8041f174>] unlock_rdev+0x49/0x50
  [<ffffffff8041f1fb>] export_rdev+0x80/0x90
  [<ffffffff80285919>] printk+0x67/0x69
  [<ffffffff8041f2c2>] kick_rdev_from_array+0x19/0x27
  [<ffffffff8042126c>] do_md_run+0x11c/0x7b8
  [<ffffffff8041fc35>] bind_rdev_to_array+0x1f5/0x210
  [<ffffffff8041fe6b>] mddev_find+0x82/0x1dd
  [<ffffffff8042012f>] md_probe+0x169/0x17a
  [<ffffffff80421bf4>] autorun_devices+0x2ec/0x379
  [<ffffffff8033b5da>] selinux_capable+0x24/0x29
  [<ffffffff804247c5>] md_ioctl+0x135/0x154f
  [<ffffffff8033ace3>] avc_has_perm+0x49/0x5b
  [<ffffffff80350c72>] blkdev_driver_ioctl+0x62/0x80
  [<ffffffff80351386>] blkdev_ioctl+0x6f6/0x75a
  [<ffffffff8023f584>] wake_up_inode+0x18/0x24
  [<ffffffff8033b463>] inode_has_perm+0x62/0x71
  [<ffffffff802c0982>] blkdev_open+0x0/0x61
  [<ffffffff802c09ae>] blkdev_open+0x2c/0x61
  [<ffffffff8033b51c>] file_has_perm+0xaa/0xb9
  [<ffffffff802bfa32>] block_ioctl+0x1b/0x1f
  [<ffffffff8024328a>] do_ioctl+0x2a/0x8f
  [<ffffffff802316eb>] vfs_ioctl+0x27b/0x2a0
  [<ffffffff8024e7ca>] sys_ioctl+0x5f/0x82
  [<ffffffff8022f97d>] sys_fcntl+0x33d/0x34f
  [<ffffffff8025ff7a>] system_call+0x7e/0x83

raid1: raid set md2 active with 1 out of 2 mirrors
md2: bitmap initialized from disk: read 10/10 pages, set 4842 bits, status: 0
created bitmap (150 pages) for device md2
md: considering sdc3 ...
md:  adding sdc3 ...
md: sdc2 has different UUID to sdc3
md:  adding sda3 ...
md: sda2 has different UUID to sdc3
md: created md1
md: bind<sda3>
md: bind<sdc3>
md: running: <sdc3><sda3>
md: kicking non-fresh sda3 from array!
md: unbind<sda3>
md: export_rdev(sda3)
BUG: warning at fs/block_dev.c:1109/__blkdev_put()

Call Trace:
  [<ffffffff802c00b2>] __blkdev_put+0x9c/0x1bb
  [<ffffffff802c01df>] blkdev_put_partition+0xe/0x10
  [<ffffffff8041f174>] unlock_rdev+0x49/0x50
  [<ffffffff8041f1fb>] export_rdev+0x80/0x90
  [<ffffffff80285919>] printk+0x67/0x69
  [<ffffffff8041f2c2>] kick_rdev_from_array+0x19/0x27
  [<ffffffff8042126c>] do_md_run+0x11c/0x7b8
  [<ffffffff8041fc35>] bind_rdev_to_array+0x1f5/0x210
  [<ffffffff8041fe6b>] mddev_find+0x82/0x1dd
  [<ffffffff8042012f>] md_probe+0x169/0x17a
  [<ffffffff80421bf4>] autorun_devices+0x2ec/0x379
  [<ffffffff8033b5da>] selinux_capable+0x24/0x29
  [<ffffffff804247c5>] md_ioctl+0x135/0x154f
  [<ffffffff8033ace3>] avc_has_perm+0x49/0x5b
  [<ffffffff80350c72>] blkdev_driver_ioctl+0x62/0x80
  [<ffffffff80351386>] blkdev_ioctl+0x6f6/0x75a
  [<ffffffff8023f584>] wake_up_inode+0x18/0x24
  [<ffffffff8033b463>] inode_has_perm+0x62/0x71
  [<ffffffff802c0982>] blkdev_open+0x0/0x61
  [<ffffffff802c09ae>] blkdev_open+0x2c/0x61
  [<ffffffff8033b51c>] file_has_perm+0xaa/0xb9
  [<ffffffff802bfa32>] block_ioctl+0x1b/0x1f
  [<ffffffff8024328a>] do_ioctl+0x2a/0x8f
  [<ffffffff802316eb>] vfs_ioctl+0x27b/0x2a0
  [<ffffffff8024e7ca>] sys_ioctl+0x5f/0x82
  [<ffffffff8022f97d>] sys_fcntl+0x33d/0x34f
  [<ffffffff8025ff7a>] system_call+0x7e/0x83

BUG: warning at fs/block_dev.c:1128/__blkdev_put()

Call Trace:
  [<ffffffff80357be8>] kobject_put+0x19/0x21
  [<ffffffff802c0194>] __blkdev_put+0x17e/0x1bb
  [<ffffffff802c01df>] blkdev_put_partition+0xe/0x10
  [<ffffffff8041f174>] unlock_rdev+0x49/0x50
  [<ffffffff8041f1fb>] export_rdev+0x80/0x90
  [<ffffffff80285919>] printk+0x67/0x69
  [<ffffffff8041f2c2>] kick_rdev_from_array+0x19/0x27
  [<ffffffff8042126c>] do_md_run+0x11c/0x7b8
  [<ffffffff8041fc35>] bind_rdev_to_array+0x1f5/0x210
  [<ffffffff8041fe6b>] mddev_find+0x82/0x1dd
  [<ffffffff8042012f>] md_probe+0x169/0x17a
  [<ffffffff80421bf4>] autorun_devices+0x2ec/0x379
  [<ffffffff8033b5da>] selinux_capable+0x24/0x29
  [<ffffffff804247c5>] md_ioctl+0x135/0x154f
  [<ffffffff8033ace3>] avc_has_perm+0x49/0x5b
  [<ffffffff80350c72>] blkdev_driver_ioctl+0x62/0x80
  [<ffffffff80351386>] blkdev_ioctl+0x6f6/0x75a
  [<ffffffff8023f584>] wake_up_inode+0x18/0x24
  [<ffffffff8033b463>] inode_has_perm+0x62/0x71
  [<ffffffff802c0982>] blkdev_open+0x0/0x61
  [<ffffffff802c09ae>] blkdev_open+0x2c/0x61
  [<ffffffff8033b51c>] file_has_perm+0xaa/0xb9
  [<ffffffff802bfa32>] block_ioctl+0x1b/0x1f
  [<ffffffff8024328a>] do_ioctl+0x2a/0x8f
  [<ffffffff802316eb>] vfs_ioctl+0x27b/0x2a0
  [<ffffffff8024e7ca>] sys_ioctl+0x5f/0x82
  [<ffffffff8022f97d>] sys_fcntl+0x33d/0x34f
  [<ffffffff8025ff7a>] system_call+0x7e/0x83

raid1: raid set md1 active with 1 out of 2 mirrors
md1: bitmap initialized from disk: read 10/10 pages, set 1393 bits, status: 0
created bitmap (150 pages) for device md1
md: considering sdc2 ...
md:  adding sdc2 ...
md:  adding sda2 ...
md: created md0
md: bind<sda2>
md: bind<sdc2>
md: running: <sdc2><sda2>
md: kicking non-fresh sdc2 from array!
md: unbind<sdc2>
md: export_rdev(sdc2)
BUG: warning at fs/block_dev.c:1109/__blkdev_put()

Call Trace:
  [<ffffffff802c00b2>] __blkdev_put+0x9c/0x1bb
  [<ffffffff802c01df>] blkdev_put_partition+0xe/0x10
  [<ffffffff8041f174>] unlock_rdev+0x49/0x50
  [<ffffffff8041f1fb>] export_rdev+0x80/0x90
  [<ffffffff80285919>] printk+0x67/0x69
  [<ffffffff8041f2c2>] kick_rdev_from_array+0x19/0x27
  [<ffffffff8042126c>] do_md_run+0x11c/0x7b8
  [<ffffffff8041fc35>] bind_rdev_to_array+0x1f5/0x210
  [<ffffffff8041fe6b>] mddev_find+0x82/0x1dd
  [<ffffffff80420043>] md_probe+0x7d/0x17a
  [<ffffffff80421bf4>] autorun_devices+0x2ec/0x379
  [<ffffffff8033b5da>] selinux_capable+0x24/0x29
  [<ffffffff804247c5>] md_ioctl+0x135/0x154f
  [<ffffffff8033ace3>] avc_has_perm+0x49/0x5b
  [<ffffffff80350c72>] blkdev_driver_ioctl+0x62/0x80
  [<ffffffff80351386>] blkdev_ioctl+0x6f6/0x75a
  [<ffffffff8023f584>] wake_up_inode+0x18/0x24
  [<ffffffff8033b463>] inode_has_perm+0x62/0x71
  [<ffffffff802c0982>] blkdev_open+0x0/0x61
  [<ffffffff802c09ae>] blkdev_open+0x2c/0x61
  [<ffffffff8033b51c>] file_has_perm+0xaa/0xb9
  [<ffffffff802bfa32>] block_ioctl+0x1b/0x1f
  [<ffffffff8024328a>] do_ioctl+0x2a/0x8f
  [<ffffffff802316eb>] vfs_ioctl+0x27b/0x2a0
  [<ffffffff8024e7ca>] sys_ioctl+0x5f/0x82
  [<ffffffff8022f97d>] sys_fcntl+0x33d/0x34f
  [<ffffffff8025ff7a>] system_call+0x7e/0x83

BUG: warning at fs/block_dev.c:1128/__blkdev_put()

Call Trace:
  [<ffffffff80357be8>] kobject_put+0x19/0x21
  [<ffffffff802c0194>] __blkdev_put+0x17e/0x1bb
  [<ffffffff802c01df>] blkdev_put_partition+0xe/0x10
  [<ffffffff8041f174>] unlock_rdev+0x49/0x50
  [<ffffffff8041f1fb>] export_rdev+0x80/0x90
  [<ffffffff80285919>] printk+0x67/0x69
  [<ffffffff8041f2c2>] kick_rdev_from_array+0x19/0x27
  [<ffffffff8042126c>] do_md_run+0x11c/0x7b8
  [<ffffffff8041fc35>] bind_rdev_to_array+0x1f5/0x210
  [<ffffffff8041fe6b>] mddev_find+0x82/0x1dd
  [<ffffffff80420043>] md_probe+0x7d/0x17a
  [<ffffffff80421bf4>] autorun_devices+0x2ec/0x379
  [<ffffffff8033b5da>] selinux_capable+0x24/0x29
  [<ffffffff804247c5>] md_ioctl+0x135/0x154f
  [<ffffffff8033ace3>] avc_has_perm+0x49/0x5b
  [<ffffffff80350c72>] blkdev_driver_ioctl+0x62/0x80
  [<ffffffff80351386>] blkdev_ioctl+0x6f6/0x75a
  [<ffffffff8023f584>] wake_up_inode+0x18/0x24
  [<ffffffff8033b463>] inode_has_perm+0x62/0x71
  [<ffffffff802c0982>] blkdev_open+0x0/0x61
  [<ffffffff802c09ae>] blkdev_open+0x2c/0x61
  [<ffffffff8033b51c>] file_has_perm+0xaa/0xb9
  [<ffffffff802bfa32>] block_ioctl+0x1b/0x1f
  [<ffffffff8024328a>] do_ioctl+0x2a/0x8f
  [<ffffffff802316eb>] vfs_ioctl+0x27b/0x2a0
  [<ffffffff8024e7ca>] sys_ioctl+0x5f/0x82
  [<ffffffff8022f97d>] sys_fcntl+0x33d/0x34f
  [<ffffffff8025ff7a>] system_call+0x7e/0x83

raid1: raid set md0 active with 1 out of 2 mirrors
md0: bitmap initialized from disk: read 12/12 pages, set 867 bits, status: 0
created bitmap (187 pages) for device md0
md: ... autorun DONE.
Creating root device.
Mounting root filesystem.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Setting up other filesystems.
Setting up new root fs
no fstab.sys, mounting internal defaults
Switching to new root and running init.
unmounting old /dev
unmounting old /proc
unmounting old /proc/bus/usb
ERROR unmounting old /proc/bus/usb: No such file or directory
forcing unmount of /proc/bus/usb
unmounting old /sys
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1151406506.484:2): selinux=0 auid=4294967295
INIT: version 2.86 booting

Which results in this:

[root@tornado ~]# cat /proc/mdstat
Personalities : [raid1]
md1 : active raid1 sdc3[1]
       4891712 blocks [2/1] [_U]
       bitmap: 31/150 pages [124KB], 16KB chunk

md2 : active raid1 sdc5[1]
       4891648 blocks [2/1] [_U]
       bitmap: 45/150 pages [180KB], 16KB chunk

md3 : active raid1 sdc6[1]
       104320 blocks [2/1] [_U]
       bitmap: 1/13 pages [4KB], 4KB chunk

md4 : active raid1 sdc7[1]
       497856 blocks [2/1] [_U]
       bitmap: 18/61 pages [72KB], 4KB chunk

md6 : active raid1 sdc10[1] sda10[0]
       20008832 blocks [2/2] [UU]

md5 : active raid1 sdc11[1] sda11[2](F)
       20008832 blocks [2/1] [_U]

md0 : active raid1 sda2[0]
       24410688 blocks [2/1] [U_]
       bitmap: 54/187 pages [216KB], 64KB chunk

unused devices: <none>
[root@tornado ~]#

cc'ing NeilB in this.......

The arrays were ok before booting into -mm3.

-mm3 is still unusable, mail is still jamming up in the queue, but I'll mention 
that in another post.

Reuben
