Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268151AbRGWIoF>; Mon, 23 Jul 2001 04:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268154AbRGWInz>; Mon, 23 Jul 2001 04:43:55 -0400
Received: from [212.17.18.2] ([212.17.18.2]:8196 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id <S268151AbRGWInp> convert rfc822-to-8bit;
	Mon, 23 Jul 2001 04:43:45 -0400
Message-Id: <200107230844.f6N8ieq13189@gw.ac-sw.com>
Content-Type: text/plain; charset=US-ASCII
From: Stepan Kalichkin <step@ac-sw.com>
Organization: NGTS
To: linux-kernel@vger.kernel.org
Subject: Problem with configure VMWare modules with 2.4.7 kernel
Date: Mon, 23 Jul 2001 15:44:26 +0700
X-Mailer: KMail [version 1.2.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi all

When I started vmware-config.pl I've get strange error when vmmon is compiled


Building the vmmon module.

make: Entering directory `/tmp/vmware-config4/vmmon-only'
make[1]: Entering directory `/tmp/vmware-config4/vmmon-only'
make[2]: Entering directory `/tmp/vmware-config4/vmmon-only/driver-2.4.7'
make[2]: Leaving directory `/tmp/vmware-config4/vmmon-only/driver-2.4.7'
make[2]: Entering directory `/tmp/vmware-config4/vmmon-only/driver-2.4.7'
In file included from /lib/modules/2.4.7/build/include/linux/highmem.h:5,
                 from /lib/modules/2.4.7/build/include/linux/pagemap.h:16,
                 from /lib/modules/2.4.7/build/include/linux/locks.h:8,
                 from 
/lib/modules/2.4.7/build/include/linux/devfs_fs_kernel.h:6,
                 from /lib/modules/2.4.7/build/include/linux/miscdevice.h:4,
                 from ../linux/driver.h:10,
                 from .././linux/driver.c:58:
/lib/modules/2.4.7/build/include/asm/pgalloc.h: In function `get_pgd_slow':
/lib/modules/2.4.7/build/include/asm/pgalloc.h:56: `PAGE_OFFSET' undeclared 
(first use in this function)
/lib/modules/2.4.7/build/include/asm/pgalloc.h:56: (Each undeclared 
identifier is reported only once
/lib/modules/2.4.7/build/include/asm/pgalloc.h:56: for each function it 
appears in.)/lib/modules/2.4.7/build/include/asm/pgalloc.h: In function 
`pte_alloc_one':
/lib/modules/2.4.7/build/include/asm/pgalloc.h:103: `PAGE_SIZE' undeclared 
(first use in this function)
In file included from /lib/modules/2.4.7/build/include/linux/pagemap.h:16,
                 from /lib/modules/2.4.7/build/include/linux/locks.h:8,
                 from 
/lib/modules/2.4.7/build/include/linux/devfs_fs_kernel.h:6,
                 from /lib/modules/2.4.7/build/include/linux/miscdevice.h:4,
                 from ../linux/driver.h:10,
                 from .././linux/driver.c:58:
/lib/modules/2.4.7/build/include/linux/highmem.h: In function 
`clear_user_highpage':/lib/modules/2.4.7/build/include/linux/highmem.h:48: 
`PAGE_SIZE' undeclared (first use in this function)
/lib/modules/2.4.7/build/include/linux/highmem.h: In function 
`clear_highpage':
/lib/modules/2.4.7/build/include/linux/highmem.h:54: `PAGE_SIZE' undeclared 
(first use in this function)
/lib/modules/2.4.7/build/include/linux/highmem.h: In function 
`memclear_highpage':
/lib/modules/2.4.7/build/include/linux/highmem.h:62: `PAGE_SIZE' undeclared 
(first use in this function)
/lib/modules/2.4.7/build/include/linux/highmem.h: In function 
`memclear_highpage_flush':
/lib/modules/2.4.7/build/include/linux/highmem.h:76: `PAGE_SIZE' undeclared 
(first use in this function)
/lib/modules/2.4.7/build/include/linux/highmem.h: In function 
`copy_user_highpage':
/lib/modules/2.4.7/build/include/linux/highmem.h:90: `PAGE_SIZE' undeclared 
(first use in this function)
/lib/modules/2.4.7/build/include/linux/highmem.h: In function `copy_highpage':
/lib/modules/2.4.7/build/include/linux/highmem.h:101: `PAGE_SIZE' undeclared 
(first
use in this function)
.././linux/driver.c: In function `LinuxDriver_Ioctl':
.././linux/driver.c:928: structure has no member named `dumpable'
make[2]: *** [driver.o] Error 1
make[2]: Leaving directory `/tmp/vmware-config4/vmmon-only/driver-2.4.7'
make[1]: *** [driver] Error 2
make[1]: Leaving directory `/tmp/vmware-config4/vmmon-only'
make: *** [auto-build] Error 2
make: Leaving directory `/tmp/vmware-config4/vmmon-only'
Unable to build the vmmon module.


but I did't found any `PAGE_SIZE' or `PAGE_OFFSET' string in 
thats files position. That is strange.

What's happening???
