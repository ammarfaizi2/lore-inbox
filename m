Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281873AbRLCIvi>; Mon, 3 Dec 2001 03:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282966AbRLCIua>; Mon, 3 Dec 2001 03:50:30 -0500
Received: from mx1.sac.fedex.com ([199.81.208.10]:40205 "EHLO
	mx1.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S284715AbRLCDdI>; Sun, 2 Dec 2001 22:33:08 -0500
Date: Mon, 3 Dec 2001 11:32:50 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Chua <jchua@fedex.com>
Subject: lvm can't compile on 2.5.1-pre5
Message-ID: <Pine.LNX.4.42.0112031129110.24046-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 12/03/2001
 11:33:04 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 12/03/2001
 11:33:06 AM,
	Serialize complete at 12/03/2001 11:33:06 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Got the following error compiling the kernel (with lvm_1.0.1-rc4 patch)

make[2]: Entering directory `/v6/src/251p5/linux/drivers/md'
gcc -D__KERNEL__ -I/v6/src/251p5/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i586 -DMODULE -DMODVERSIONS -include
/v6/src/251p5/linux/include/linux/modversions.h   -c -o lvm.o lvm.c
lvm.c: In function `lvm_init':
lvm.c:458: `gendisk_head' undeclared (first use in this function)
lvm.c:458: (Each undeclared identifier is reported only once
lvm.c:458: for each function it appears in.)
lvm.c:476: warning: passing arg 2 of `blk_queue_make_request_Rbb362cea'
from incompatible pointer type
lvm.c: In function `lvm_cleanup':
lvm.c:513: `gendisk_head' undeclared (first use in this function)
lvm.c:526: `hardsect_size' undeclared (first use in this function)
lvm.c: In function `lvm_user_bmap':
lvm.c:1117: structure has no member named `b_rdev'
lvm.c:1119: structure has no member named `b_rsector'
lvm.c:1125: structure has no member named `b_rdev'
lvm.c:1125: structure has no member named `b_rdev'
lvm.c:1125: structure has no member named `b_rdev'
lvm.c:1125: structure has no member named `b_rdev'
lvm.c:1126: structure has no member named `b_rsector'
lvm.c:1126: structure has no member named `b_rsector'
lvm.c:1126: structure has no member named `b_rsector'
lvm.c:1126: structure has no member named `b_rsector'
lvm.c: In function `lvm_map':
lvm.c:1195: structure has no member named `b_rdev'
lvm.c:1199: structure has no member named `b_rsector'
lvm.c:1319: structure has no member named `b_rdev'
lvm.c:1320: structure has no member named `b_rsector'
lvm.c: In function `lvm_geninit':
lvm.c:2783: `hardsect_size' undeclared (first use in this function)
lvm.c: In function `_queue_io':
lvm.c:2792: structure has no member named `b_reqnext'
lvm.c:2793: structure has no member named `b_reqnext'
lvm.c: In function `_flush_io':
lvm.c:2818: structure has no member named `b_reqnext'
lvm.c:2819: structure has no member named `b_reqnext'
lvm.c:2821: warning: passing arg 1 of `generic_make_request_R9c6b6d2d'
makes pointer from integer without a cast
lvm.c:2821: too many arguments to function `generic_make_request_R9c6b6d2d'
make[2]: *** [lvm.o] Error 1
make[2]: Leaving directory `/v6/src/251p5/linux/drivers/md'
make[1]: *** [_modsubdir_md] Error 2
make[1]: Leaving directory `/v6/src/251p5/linux/drivers'
make: *** [_mod_drivers] Error 2


