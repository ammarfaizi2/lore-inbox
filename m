Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262620AbSKROFB>; Mon, 18 Nov 2002 09:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262631AbSKROFB>; Mon, 18 Nov 2002 09:05:01 -0500
Received: from ma-northadams1b-126.bur.adelphia.net ([24.52.166.126]:42896
	"EHLO ma-northadams1b-126.bur.adelphia.net") by vger.kernel.org
	with ESMTP id <S262620AbSKROFA>; Mon, 18 Nov 2002 09:05:00 -0500
Date: Mon, 18 Nov 2002 09:12:36 -0500
From: Eric Buddington <eric@ma-northadams1b-126.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.48: compile failure in fs/devfs/base.c
Message-ID: <20021118091236.J25188@ma-northadams1b-126.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.48, Athlon, mostly modules, gcc-3.2 yields this:

  gcc -Wp,-MD,fs/devfs/.base.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=base -DKBUILD_MODNAME=devfs -DEXPORT_SYMTAB  -c -o fs/devfs/base.o fs/devfs/base.c
fs/devfs/base.c: In function `devfs_symlink':
fs/devfs/base.c:3032: incompatible types in assignment
fs/devfs/base.c:3033: incompatible types in assignment
fs/devfs/base.c:3034: incompatible types in assignment
fs/devfs/base.c: In function `devfs_mkdir':
fs/devfs/base.c:3063: incompatible types in assignment
fs/devfs/base.c:3064: incompatible types in assignment
fs/devfs/base.c:3065: incompatible types in assignment
fs/devfs/base.c: In function `devfs_mknod':
fs/devfs/base.c:3132: incompatible types in assignment
fs/devfs/base.c:3133: incompatible types in assignment
fs/devfs/base.c:3134: incompatible types in assignment
make[2]: *** [fs/devfs/base.o] Error 1
make[1]: *** [fs/devfs] Error 2
make: *** [fs] Error 2
