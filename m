Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUBVEN6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 23:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbUBVEN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 23:13:58 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:56286 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261672AbUBVENx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 23:13:53 -0500
Subject: 2.4.25 and xfs compile errors
From: R Dicaire <rdicair@comcast.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1077423230.1589.8.camel@ws.rdb.linux-help.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Feb 2004 23:13:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to compile 2.4.25, I get the following:

ld -m elf_i386 -T /usr/src/linux-2.4.25/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/ide/idedriver.o drivers/cdrom/driver.o
drivers/pci/driver.o drivers/video/video.o drivers/media/media.o
drivers/md/mddev.o \
        net/network.o \
        /usr/src/linux-2.4.25/arch/i386/lib/lib.a
/usr/src/linux-2.4.25/lib/lib.a
/usr/src/linux-2.4.25/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
fs/fs.o(.text+0x6fa94): In function `xfs_bmap_add_attrfork_local':
: undefined reference to `__constant_c_and_count_memset'
fs/fs.o(.text+0x72d2b): In function `xfs_bmap_alloc':
: undefined reference to `xfs_do_div'
fs/fs.o(.text+0x74506): In function `xfs_bmap_del_extent':
: undefined reference to `xfs_do_div'
fs/fs.o(.text+0x74519): In function `xfs_bmap_del_extent':
: undefined reference to `xfs_do_div'
fs/fs.o(.text+0x752e3): In function `xfs_bmap_worst_indlen':
: undefined reference to `xfs_do_div'
fs/fs.o(.text+0x78afe): In function `xfs_getbmap':
: undefined reference to `__constant_copy_to_user'
make: *** [vmlinux] Error 1
----------------------------------------------------------------------
System info:

Slackware 9.1 kernel 2.4.23-xfs

gcc -v
Reading specs from /usr/lib/gcc-lib/i486-slackware-linux/3.2.3/specs
Configured with: ../gcc-3.2.3/configure --prefix=/usr --enable-shared
--enable-threads=posix --enable-__cxa_atexit --disable-checking
--with-gnu-ld --verbose --target=i486-slackware-linux
--host=i486-slackware-linux
Thread model: posix
gcc version 3.2.3

Am I missing something, not sure but those undefined references usually
mean some lib or something doesn't support the features trying to be
compiled, any help would be greatly appreciated, thanks.

Please CC rdicair@comcast.net as I'm not subscribed to this list,
thanks.

