Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265844AbSKBBGz>; Fri, 1 Nov 2002 20:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265847AbSKBBGz>; Fri, 1 Nov 2002 20:06:55 -0500
Received: from quechua.inka.de ([193.197.184.2]:46492 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S265844AbSKBBGu>;
	Fri, 1 Nov 2002 20:06:50 -0500
From: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: various 2.5.45 compile problems (intermezzo, pmtu, afs, qt) (was: Linux v2.5.45 ipmr.c compile failure)
In-Reply-To: <Pine.LNX.4.33L2.0211011525300.28320-100000@dragon.pdx.osdl.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E187mqj-0004BM-00@sites.inka.de>
Date: Sat, 2 Nov 2002 02:13:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33L2.0211011525300.28320-100000@dragon.pdx.osdl.net> you wrote:
> | net/ipv4/ipmr.c: In function `ipmr_forward_finish':
> Several people reported this problem in 2.5.45.

and this also:

  gcc -Wp,-MD,net/ipv4/netfilter/.ipt_TCPMSS.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -Iarch/i386/mach-generic
-nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=ipt_TCPMSS   -c
-o net/ipv4/netfilter/ipt_TCPMSS.o net/ipv4/netfilter/ipt_TCPMSS.c
net/ipv4/netfilter/ipt_TCPMSS.c: In function 	pt_tcpmss_target':
net/ipv4/netfilter/ipt_TCPMSS.c:88: structure has no member named mtu'
net/ipv4/netfilter/ipt_TCPMSS.c:91: structure has no member named mtu'
net/ipv4/netfilter/ipt_TCPMSS.c:95: structure has no member named mtu'
make[3]: *** [net/ipv4/netfilter/ipt_TCPMSS.o] Error 1

and diskmapper:

drivers/md/dm-ioctl.c: In function 'create':
drivers/md/dm-ioctl.c:588: incompatible type for argument 1 of 'set_device_ro'
drivers/md/dm-ioctl.c: In function eload':
drivers/md/dm-ioctl.c:874: incompatible type for argument 1 of 'set_device_ro'
make[1]: *** [drivers/md/dm-ioctl.o] Error 1

also intermezzo and afs do not build as a module (maybe even build in)

fs/afs/dir.c:75: warning: unnamed struct/union that defines no instances
fs/afs/dir.c: In function fs_dir_iterate_block':
fs/afs/dir.c:261: union has no member named ame'
fs/afs/dir.c:293: union has no member named ame'
fs/afs/dir.c:296: union has no member named node'
fs/afs/dir.c:296: union has no member named node'
fs/afs/dir.c:296: union has no member named node'
fs/afs/dir.c:297: union has no member named nique'
make[2]: *** [fs/afs/dir.o] Error 1

include/linux/intermezzo_fs.h: In function 	zo_ioctl_packlen':
include/linux/intermezzo_fs.h:864: sizeof applied to an incomplete type
include/linux/intermezzo_fs.h:865: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:866: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h: At top level:
include/linux/intermezzo_fs.h:870: warning: truct izo_ioctl_data' declared
inside parameter list
include/linux/intermezzo_fs.h:871: conflicting types for
zo_ioctl_is_invalid'
include/linux/intermezzo_fs.h:52: previous declaration of
zo_ioctl_is_invalid'
include/linux/intermezzo_fs.h: In function 	zo_ioctl_is_invalid':
include/linux/intermezzo_fs.h:872: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:876: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:880: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:884: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:884: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:888: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:888: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:892: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:892: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:896: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:896: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:900: warning: passing arg 1 of
zo_ioctl_packlen'
from incompatible pointer type
include/linux/intermezzo_fs.h:900: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:904: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:905: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:905: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:909: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:910: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:910: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:910: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h: At top level:
include/linux/intermezzo_fs.h:919: warning: truct kml_rec' declared inside
parameter list
include/linux/intermezzo_fs.h:920: warning: truct kml_rec' declared inside
parameter list
make[2]: *** [fs/intermezzo/cache.o] Error 1

In addtion to that make oldconfig depends on the qtlib (i was not realy able
to figure the dependencies out in that makefile but it is enough to touch
the temporary qt found flagfile to run make oldconfig.

Gruss
Bernd
