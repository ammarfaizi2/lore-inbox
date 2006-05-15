Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWEONNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWEONNK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 09:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWEONNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 09:13:10 -0400
Received: from tornado.reub.net ([202.89.145.182]:50891 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S964811AbWEONNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 09:13:09 -0400
Message-ID: <44687E48.5050107@reub.net>
Date: Tue, 16 May 2006 01:12:40 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060514)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4-mm1
References: <20060515005637.00b54560.akpm@osdl.org>
In-Reply-To: <20060515005637.00b54560.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/05/2006 7:56 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm1/
> 
> - This tree contains a large number of new bugs^H^H^H^Hpatches.

Indeed.  This is the first -mm in a fair while that has crapped itself on boot 
on my box.

NeilB - is this yours?

usbcore: registered new driver libusual
usbcore: registered new driver hiddev
input: Belkin Components Belkin OmniView KVM Switch as /class/input/input0
input: USB HID v1.00 Keyboard [Belkin Components Belkin OmniView KVM Switch] on 
usb-0000:00:1d.0-1.1
input: Belkin Components Belkin OmniView KVM Switch as /class/input/input1
input: USB HID v1.00 Mouse [Belkin Components Belkin OmniView KVM Switch] on 
usb-0000:00:1d.0-1.1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: raid1 personality registered for level 1
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
EDAC MC: Ver: 2.0.0 May 15 2006
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Freeing unused kernel memory: 208k freed
Red Hat nash version 5.0.39 starting
Mounting proc filesystem
Mounting sysfs filesystem
Creating /dev
Creating initial device nodes
Setting up hotplug.
Creating block device nodes.
Loading ide-disk.ko module
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdc11 ...
md:  adding sdc11 ...
md: sdc10 has different UUID to sdc11
md: sdc7 has different UUID to sdc11
md: sdc6 has different UUID to sdc11
md: sdc5 has different UUID to sdc11
md: sdc3 has different UUID to sdc11
md: sdc2 has different UUID to sdc11
md:  adding sda11 ...
md: sda10 has different UUID to sdc11
md: sda7 has different UUID to sdc11
md: sda6 has different UUID to sdc11
md: sda5 has different UUID to sdc11
md: sda3 has different UUID to sdc11
md: sda2 has different UUID to sdc11
md: created md5
md: bind<sda11>
md: bind<sdc11>
md: running: <sdc11><sda11>
raid1: raid set md5 active with 0 out of 2 mirrors
md: considering sdc10 ...
md:  adding sdc10 ...
md: sdc7 has different UUID to sdc10
md: sdc6 has different UUID to sdc10
md: sdc5 has different UUID to sdc10
md: sdc3 has different UUID to sdc10
md: sdc2 has different UUID to sdc10
md:  adding sda10 ...
md: sda7 has different UUID to sdc10
md: sda6 has different UUID to sdc10
md: sda5 has different UUID to sdc10
md: sda3 has different UUID to sdc10
md: sda2 has different UUID to sdc10
md: created md6
md: bind<sda10>
md: bind<sdc10>
md: running: <sdc10><sda10>
raid1: raid set md6 active with 0 out of 2 mirrors
md: considering sdc7 ...
md:  adding sdc7 ...
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
raid1: raid set md4 active with 0 out of 2 mirrors
Unable to handle kernel NULL pointer dereference at 0000000000000010 RIP:
<ffffffff8040e828>{bitmap_create+152}
PGD 3ed90067 PUD 3ed91067 PMD 0
Oops: 0000 [1] SMP
last sysfs file: /block/fd0/removable
CPU 0
Modules linked in: ide_disk
Pid: 1, comm: init Not tainted 2.6.17-rc4-mm1 #1
RIP: 0010:[<ffffffff8040e828>] <ffffffff8040e828>{bitmap_create+152}
RSP: 0000:ffff81003f603ad8  EFLAGS: 00010246
RAX: 0000000000000008 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff810037d424c0
RBP: ffff810037d423c0 R08: 0000000000005d7a R09: 0000000000000000
R10: ffff810037d423c0 R11: 0000000000000100 R12: 00000000fffffff4
R13: ffff81003ed65000 R14: 00000000000f3180 R15: ffff81003ed650d0
FS:  000000000066e890(0063) GS:ffffffff8060e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000010 CR3: 000000003ed89000 CR4: 00000000000006e0
Process init (pid: 1, threadinfo ffff81003f602000, task ffff81003f601530)
Stack: ffff810037d94fc0 ffffffff80406ee6 0000000100000001 000000013edb40c0
        ffff81003edb40c0 ffff81003ed65018 ffff810037d44f40 ffff810037d427c0
        ffff81003ed65000 ffffffff80404a16
Call Trace: <ffffffff80406ee6>{md_register_thread+167}
        <ffffffff80404a16>{run+942} <ffffffff804080c8>{do_md_run+1208}
        <ffffffff804067ae>{bind_rdev_to_array+494} 
<ffffffff8034d826>{kobject_register+51}
        <ffffffff804069c4>{mddev_find+122} <ffffffff8040865d>{autorun_devices+731}
        <ffffffff80224627>{alloc_inode+246} <ffffffff8040b445>{md_ioctl+165}
        <ffffffff802d641d>{sysfs_make_dirent+27} 
<ffffffff80259cac>{kobject_uevent+220}
        <ffffffff802d5cc4>{sysfs_add_file+118} 
<ffffffff8034690c>{blkdev_driver_ioctl+92}
        <ffffffff80346fd8>{blkdev_ioctl+1704} 
<ffffffff802b536f>{check_disk_change+31}
        <ffffffff8040c84b>{md_open+92} <ffffffff802b5df6>{blkdev_open+0}
        <ffffffff802b5df6>{blkdev_open+0} <ffffffff802b5adb>{do_open+651}
        <ffffffff802b583d>{bdget+277} <ffffffff802b5df6>{blkdev_open+0}
        <ffffffff802b5e17>{blkdev_open+33} <ffffffff8021d712>{__dentry_open+258}
        <ffffffff802b51a8>{block_ioctl+27} <ffffffff802429a1>{do_ioctl+33}
        <ffffffff8022fb0c>{vfs_ioctl+636} <ffffffff8024d8b8>{sys_ioctl+91}
        <ffffffff8025ea72>{system_call+126}

Code: 48 8b 43 10 48 8b 40 10 48 8b b8 10 01 00 00 e8 cf cd e4 ff
RIP <ffffffff8040e828>{bitmap_create+152} RSP <ffff81003f603ad8>
CR2: 0000000000000010
  <0>Kernel panic - not syncing: Attempted to kill init!
  <0>Rebooting in 60 seconds..


-rc3-mm1 doesn't have this problem, but rc4-mm1 does.  It seems like the right 
devices are found and added but no md is created for them.

Here's some output with -rc3-mm1 which is ok:

[root@tornado ~]# cat /proc/mdstat
Personalities : [raid1]
md1 : active raid1 sdc3[1] sda3[0]
       4891712 blocks [2/2] [UU]
       bitmap: 2/150 pages [8KB], 16KB chunk

md2 : active raid1 sdc5[1] sda5[0]
       4891648 blocks [2/2] [UU]
       bitmap: 19/150 pages [76KB], 16KB chunk

md3 : active raid1 sdc6[1] sda6[0]
       104320 blocks [2/2] [UU]
       bitmap: 1/13 pages [4KB], 4KB chunk

md4 : active raid1 sdc7[1] sda7[0]
       497856 blocks [2/2] [UU]
       bitmap: 3/61 pages [12KB], 4KB chunk

md6 : active raid1 sdc10[1] sda10[0]
       20008832 blocks [2/2] [UU]

md5 : active raid1 sdc11[1] sda11[0]
       20008832 blocks [2/2] [UU]

md0 : active raid1 sdc2[1] sda2[0]
       24410688 blocks [2/2] [UU]
       bitmap: 16/187 pages [64KB], 64KB chunk

unused devices: <none>
[root@tornado ~]#

Box is an x86_64 with raid-1/SATA.

Thanks,
Reuben
