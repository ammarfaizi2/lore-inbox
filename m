Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282481AbRLKTUl>; Tue, 11 Dec 2001 14:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282695AbRLKTUb>; Tue, 11 Dec 2001 14:20:31 -0500
Received: from inti.inf.utfsm.cl ([146.83.198.3]:3341 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S282728AbRLKTUU>;
	Tue, 11 Dec 2001 14:20:20 -0500
Date: Tue, 11 Dec 2001 16:19:30 -0300
Message-Id: <200112111919.fBBJJUHu008484@tigger.valparaiso.cl>
From: root <root@tigger.valparaiso.cl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.1pre9: RAID and PPA (Zip) module compilation problems
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have RAID as module (don't use it, really), and occasionaly use a
parport Zip drive (old model, PPA), also module. When building the kernel
today I got:

make -C md modules
make[2]: Entering directory `/usr/src/linux-2.5/drivers/md'
gcc -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o raid1.o raid1.c
raid1.c: In function `raid1_end_bh_io':
raid1.c:386: structure has no member named `b_rsector'
raid1.c: In function `raid1_read_balance':
raid1.c:463: structure has no member named `b_rsector'
raid1.c: In function `raid1_make_request':
raid1.c:582: structure has no member named `b_rsector'
raid1.c:582: structure has no member named `b_rsector'
raid1.c:582: structure has no member named `b_rsector'
raid1.c:582: structure has no member named `b_rsector'
raid1.c:586: structure has no member named `b_rsector'
raid1.c:613: structure has no member named `b_rsector'
raid1.c:615: structure has no member named `b_rdev'
raid1.c:619: warning: passing arg 1 of `generic_make_request' makes pointer from integer without a cast
raid1.c:619: too many arguments to function `generic_make_request'
raid1.c:657: structure has no member named `b_rsector'
raid1.c:659: structure has no member named `b_rdev'
raid1.c:660: structure has no member named `b_rsector'
raid1.c:660: structure has no member named `b_rsector'
raid1.c:699: warning: passing arg 1 of `generic_make_request' makes pointer from integer without a cast
raid1.c:699: too many arguments to function `generic_make_request'
raid1.c: In function `raid1d':
raid1.c:1183: structure has no member named `b_rdev'
raid1.c:1184: structure has no member named `b_rsector'
raid1.c:1215: warning: passing arg 1 of `generic_make_request' makes pointer from integer without a cast
raid1.c:1215: too many arguments to function `generic_make_request'
raid1.c:1238: structure has no member named `b_rdev'
raid1.c:1239: structure has no member named `b_rsector'
raid1.c:1240: warning: passing arg 1 of `generic_make_request' makes pointer from integer without a cast
raid1.c:1240: too many arguments to function `generic_make_request'
raid1.c: In function `raid1_sync_request':
raid1.c:1414: structure has no member named `b_rdev'
raid1.c:1425: structure has no member named `b_rsector'
raid1.c:1428: too many arguments to function `generic_make_request'
raid1.c: At top level:
raid1.c:1807: warning: initialization from incompatible pointer type
make[2]: *** [raid1.o] Error 1
gcc -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o raid5.o raid5.c
raid5.c: In function `raid5_end_read_request':
raid5.c:408: structure has no member named `b_reqnext'
raid5.c:409: structure has no member named `b_reqnext'
raid5.c: In function `compute_parity':
raid5.c:711: structure has no member named `b_reqnext'
raid5.c:712: structure has no member named `b_reqnext'
raid5.c:723: structure has no member named `b_reqnext'
raid5.c:724: structure has no member named `b_reqnext'
raid5.c: In function `add_stripe_bh':
raid5.c:784: structure has no member named `b_reqnext'
raid5.c:791: structure has no member named `b_reqnext'
raid5.c: In function `handle_stripe':
raid5.c:860: structure has no member named `b_reqnext'
raid5.c:861: structure has no member named `b_reqnext'
raid5.c:890: structure has no member named `b_reqnext'
raid5.c:891: structure has no member named `b_reqnext'
raid5.c:899: structure has no member named `b_reqnext'
raid5.c:900: structure has no member named `b_reqnext'
raid5.c:933: structure has no member named `b_reqnext'
raid5.c:934: structure has no member named `b_reqnext'
raid5.c:963: structure has no member named `b_reqnext'
raid5.c:1117: structure has no member named `b_reqnext'
raid5.c:1118: structure has no member named `b_reqnext'
raid5.c:1122: structure has no member named `b_reqnext'
raid5.c:1123: structure has no member named `b_reqnext'
raid5.c:1143: structure has no member named `b_rdev'
raid5.c:1144: structure has no member named `b_rsector'
raid5.c:1145: warning: passing arg 1 of `generic_make_request' makes pointer from integer without a cast
raid5.c:1145: too many arguments to function `generic_make_request'
raid5.c:849: warning: `rbh2' might be used uninitialized in this function
raid5.c:928: warning: `wbh2' might be used uninitialized in this function
raid5.c: In function `raid5_make_request':
raid5.c:1211: structure has no member named `b_rsector'
raid5.c: At top level:
raid5.c:2008: warning: initialization from incompatible pointer type
make[2]: *** [raid5.o] Error 1
gcc -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -DEXPORT_SYMTAB -c xor.c
gcc -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -DEXPORT_SYMTAB -c md.c
gcc -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o lvm.o lvm.c
lvm.c: In function `lvm_user_bmap':
lvm.c:1046: request for member `bv_len' in something not a structure or union
make[2]: *** [lvm.o] Error 1

[drivers/scsi/]

ppa.c: In function `ppa_detect':
ppa.c:131: `io_request_lock' undeclared (first use in this function)
ppa.c:131: (Each undeclared identifier is reported only once
ppa.c:131: for each function it appears in.)
ppa.c: In function `ppa_interrupt':
ppa.c:850: `io_request_lock' undeclared (first use in this function)
make[2]: *** [ppa.o] Error 1
-- 
Horst von Brand			     http://counter.li.org # 22616
