Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268209AbTB1WTg>; Fri, 28 Feb 2003 17:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268215AbTB1WTd>; Fri, 28 Feb 2003 17:19:33 -0500
Received: from h-64-105-35-98.SNVACAID.covad.net ([64.105.35.98]:36482 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S268209AbTB1WTa>; Fri, 28 Feb 2003 17:19:30 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 28 Feb 2003 14:29:37 -0800
Message-Id: <200302282229.OAA10670@adam.yggdrasil.com>
To: andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Patch: 2.5.62.4 small devfs
Cc: akpm@digeo.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2003, Andrew Walrond wrote:
>[...] I want to give this another whirl, but your latest 
>patch doesn't apply cleanly against 2.5.63+ (fs/devfs/base.c fails). Any 
>chance of an update?

	I have made a new version of my small devfs patch against
linux-2.5.62.bk4.  This version fixes a bug where directory->i_sem was
held while devfs_helper ran, which caused deadlock on one system.  I
am surprised I had not noticed this problem before.  This version also
adds Documentation/filesystems/devfs/small-devfs, describing
differences between the old devfs implementation and this one. You can
retrieve the patch from the following URL.

ftp://ftp.yggdrasil.com/pub/dist/device_control/devfs/smalldevfs-2.5.62.4-v11.patch

	As before, the optional devfs_helper user level program can
be retrived from:

ftp://ftp.yggdrasil.com/pub/dist/device_control/devfs/devfs_helper-0.2.tar.gz


	My "to do" list for small devfs is now as follows.

		- Submit a patch to the -mm kernels, as Andrew has been
		  kind enough to distribute this change in his -mm kernels.
		- Remove CONFIG_DEVFS_MOUNT?
		- Explore eliminating by fs/devfs/fs.c by extending
		  dnotify and ramfs slightly.
		- Probably request integration after linux-2.7.0.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
