Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268257AbRGWPG0>; Mon, 23 Jul 2001 11:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268258AbRGWPGR>; Mon, 23 Jul 2001 11:06:17 -0400
Received: from mailsorter.in.tmpw.net ([63.121.29.25]:39968 "EHLO
	mailsorter1.in.tmpw.net") by vger.kernel.org with ESMTP
	id <S268257AbRGWPGK>; Mon, 23 Jul 2001 11:06:10 -0400
Message-ID: <3AB544CBBBE7BF428DA7DBEA1B85C79C9B6DD0@nocmail.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'J.R. de Jong'" <jdejong@chem.rug.nl>, linux-kernel@vger.kernel.org
Subject: RE: modules for VMware 2.0.4 for Linux do not compile for 2.4.7
Date: Mon, 23 Jul 2001 11:05:37 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Search the archive, This has been brought up already, I believe yesterday,
and Petr Vandrovec posted a link to a fix.  Hope this helps.

B.

-----Original Message-----
From: J.R. de Jong [mailto:jdejong@chem.rug.nl]
Sent: Monday, July 23, 2001 11:00 AM
To: linux-kernel@vger.kernel.org
Subject: modules for VMware 2.0.4 for Linux do not compile for 2.4.7


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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
