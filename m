Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131275AbRDNIpl>; Sat, 14 Apr 2001 04:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131307AbRDNIpV>; Sat, 14 Apr 2001 04:45:21 -0400
Received: from quechua.inka.de ([212.227.14.2]:23404 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S131275AbRDNIpT>;
	Sat, 14 Apr 2001 04:45:19 -0400
From: Bernd Eckenfels <W1012@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] tmpfs and loop
In-Reply-To: <01041321112600.23961@oscar>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.36 (i686))
Message-Id: <E14oLgG-0007vf-00@sites.inka.de>
Date: Sat, 14 Apr 2001 10:45:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <01041321112600.23961@oscar> you wrote:
> oscar% sudo mount /tmp/disk /snap -oloop -text2
> ioctl: LOOP_SET_FD: Invalid argument

are you sure you have a working loop device? Try to verify it in a non tmpfs
filesystem.

> stat64("/dev/loop0", {st_mode=S_IFBLK|0660, st_rdev=makedev(7, 0), ...}) = 0
> open("/dev/loop0", O_RDONLY|O_LARGEFILE) = 3
> ioctl(3, 0x4c03, 0xbffff7fc)            = -1 ENXIO (No such device or address)

otherwise try this by hand with losetup.

> close(3)                                = 0
> open("/tmp/disk", O_RDWR|O_LARGEFILE)   = 3
> open("/dev/loop0", O_RDWR|O_LARGEFILE)  = 4
> mlockall(MCL_CURRENT|MCL_FUTURE)        = 0
> ioctl(4, 0x4c00, 0x3)                   = -1 EINVAL (Invalid argument)
> write(2, "ioctl: LOOP_SET_FD: Invalid argu"..., 37ioctl: LOOP_SET_FD: Invalid argument

Greetings
Bernd
