Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268254AbRGWPAF>; Mon, 23 Jul 2001 11:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268256AbRGWO7z>; Mon, 23 Jul 2001 10:59:55 -0400
Received: from polypc17.chem.rug.nl ([129.125.25.92]:30849 "EHLO
	polypc17.chem.rug.nl") by vger.kernel.org with ESMTP
	id <S268254AbRGWO7p>; Mon, 23 Jul 2001 10:59:45 -0400
Date: Mon, 23 Jul 2001 16:59:50 +0200 (CEST)
From: "J.R. de Jong" <jdejong@chem.rug.nl>
To: linux-kernel@vger.kernel.org
Subject: modules for VMware 2.0.4 for Linux do not compile for 2.4.7
Message-ID: <Pine.LNX.4.21.0107231645130.2210-100000@polypc17.chem.rug.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello,

First of all I'm not subscribed to this list, so I would appreciate it if
I would be cc-ed in a reply.

My question is about VMware. While the modules compiled in 2.4.6, they do
not anymore in 2.4.7. Is this because of structural changes in the kernel
source (in which case I would have to wait for a new version of VMware) or
is something just wrong?

Anyway, here is the compiler error:

------------

Building the vmmon module.

make: Entering directory `/tmp/vmware-config5/vmmon-only'
make[1]: Entering directory `/tmp/vmware-config5/vmmon-only'
make[2]: Entering directory `/tmp/vmware-config5/vmmon-only/driver-2.4.7'
make[2]: Leaving directory `/tmp/vmware-config5/vmmon-only/driver-2.4.7'
make[2]: Entering directory `/tmp/vmware-config5/vmmon-only/driver-2.4.7'
In file included from /usr/src/linux/include/linux/highmem.h:5,
                 from /usr/src/linux/include/linux/pagemap.h:16,
                 from /usr/src/linux/include/linux/locks.h:8,
                 from /usr/src/linux/include/linux/devfs_fs_kernel.h:6,
                 from /usr/src/linux/include/linux/miscdevice.h:4,
                 from ../linux/driver.h:10,
                 from .././linux/driver.c:58:
/usr/src/linux/include/asm/pgalloc.h: In function `get_pgd_slow':
/usr/src/linux/include/asm/pgalloc.h:56: `PAGE_OFFSET' undeclared (first
use in this function)
/usr/src/linux/include/asm/pgalloc.h:56: (Each undeclared identifier is
reported only once
/usr/src/linux/include/asm/pgalloc.h:56: for each function it appears in.)
/usr/src/linux/include/asm/pgalloc.h: In function `pte_alloc_one':
/usr/src/linux/include/asm/pgalloc.h:103: `PAGE_SIZE' undeclared (first
use in this function)
In file included from /usr/src/linux/include/linux/pagemap.h:16,
                 from /usr/src/linux/include/linux/locks.h:8,
                 from /usr/src/linux/include/linux/devfs_fs_kernel.h:6,
                 from /usr/src/linux/include/linux/miscdevice.h:4,
                 from ../linux/driver.h:10,
                 from .././linux/driver.c:58:
/usr/src/linux/include/linux/highmem.h: In function `bh_kmap':
/usr/src/linux/include/linux/highmem.h:21: `PAGE_MASK' undeclared (first
use in this function)
/usr/src/linux/include/linux/highmem.h:22: warning: control reaches end of
non-void function
/usr/src/linux/include/linux/highmem.h: In function `clear_user_highpage':
/usr/src/linux/include/linux/highmem.h:48: `PAGE_SIZE' undeclared (first
use in this function)
/usr/src/linux/include/linux/highmem.h: In function `clear_highpage':
/usr/src/linux/include/linux/highmem.h:54: `PAGE_SIZE' undeclared (first
use in this function)
/usr/src/linux/include/linux/highmem.h: In function `memclear_highpage':
/usr/src/linux/include/linux/highmem.h:62: `PAGE_SIZE' undeclared (first
use in this function)
/usr/src/linux/include/linux/highmem.h: In function
`memclear_highpage_flush':
/usr/src/linux/include/linux/highmem.h:76: `PAGE_SIZE' undeclared (first
use in this function)
/usr/src/linux/include/linux/highmem.h: In function `copy_user_highpage':
/usr/src/linux/include/linux/highmem.h:90: `PAGE_SIZE' undeclared (first
use in this function)
/usr/src/linux/include/linux/highmem.h: In function `copy_highpage':
/usr/src/linux/include/linux/highmem.h:101: `PAGE_SIZE' undeclared (first
use in this function)
.././linux/driver.c: In function `LinuxDriver_Ioctl':
.././linux/driver.c:928: structure has no member named `dumpable'
make[2]: *** [driver.o] Error 1
make[2]: Leaving directory `/tmp/vmware-config5/vmmon-only/driver-2.4.7'
make[1]: *** [driver] Error 2
make[1]: Leaving directory `/tmp/vmware-config5/vmmon-only'
make: *** [auto-build] Error 2
make: Leaving directory `/tmp/vmware-config5/vmmon-only'
Unable to build the vmmon module.

----------

Johan.

