Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314389AbSEMTof>; Mon, 13 May 2002 15:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314392AbSEMToe>; Mon, 13 May 2002 15:44:34 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:28433 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S314389AbSEMTod>; Mon, 13 May 2002 15:44:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15584.6160.11925.565003@iris.hendrikweg.doorn>
Date: Mon, 13 May 2002 21:46:24 +0200
To: linux-kernel@vger.kernel.org
From: Kees Bakker <rnews@altium.nl>
Subject: Q. Is initrd/cramfs usable on 2.5.x?
X-Mailer: VM 6.96 under Emacs 20.7.2
Reply-To: Kees Bakker <kees.bakker@xs4all.nl>
Organisation: The Tardis
X-Bill: Go away
X-Attribution: kb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you think initrd+cramfs should be usable on 2.5.x kernels? I keep
getting "wrong magic". BTW. I applied a small patch to init/do_mount.c
(which is also used by Debian in their 2.4.x kernels) so that it sees
CRAMFS_MAGIC.

Unfortunately I can't give a complete log of the boot messages because
booting stops with a panic. I wrote down the last couple of lines.

RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 1016 blocks [1 disk] into ram disk...done.
Freeing initrd memory: 1016k freed
cramfs: wrong magic
Kernel panic: VFS: Unable to mout root fs on 03:02

After putting some debug printk I could see that in cramfs_fill_super() it
indeed fails to see a correct CRAMFS_MAGIC. But the loading seems to have
succeeded.

Since there were quite a few changes since 2.5.0 I am not really able to
compare with my working initrd+cramfs on 2.4.17.

I am nuts to even try this, or should it work? (Both can be true.)
-- 
