Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265773AbTBGPwr>; Fri, 7 Feb 2003 10:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265880AbTBGPwr>; Fri, 7 Feb 2003 10:52:47 -0500
Received: from [213.140.2.7] ([213.140.2.7]:5896 "EHLO mail.fastweb.it")
	by vger.kernel.org with ESMTP id <S265773AbTBGPwq>;
	Fri, 7 Feb 2003 10:52:46 -0500
Subject: ramfs as root filesystem
From: Gianni Trevisti <gianni.trevisti@consulenti.fastweb.it>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Fastweb
Message-Id: <1044634111.1701.28.camel@gianni.streaming>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 07 Feb 2003 17:08:32 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm trying to mount ramfs as rootdisk in a 2.4.19 based SetTopBox:
- the filesystem is loaded using etherboot
- then using linuxrc I mount a ramfs in /ramfs, expand the STB
filesystem in it and then I should use /ramfs as my root filesystem.
I think I should modify the mount_root() function in order to
sys_chdir("/ramfs") but in that case I'm not able to unmount the initrd
ext2 filesystem, and so I loose a lot of memory!

Using kernel 2.4.0 there was a patch to perform this task, but it is not
apply anymore to the current kernel tree.

Thanks in advance for any help :-)


