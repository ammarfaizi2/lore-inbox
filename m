Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264619AbSJWKi1>; Wed, 23 Oct 2002 06:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264624AbSJWKi1>; Wed, 23 Oct 2002 06:38:27 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:31210 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264619AbSJWKi0>; Wed, 23 Oct 2002 06:38:26 -0400
Date: Wed, 23 Oct 2002 12:44:32 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jan Marek <linux@hazard.jcu.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [miniPATCH] 2.5.44 fix compilation errors in the AFS fs
In-Reply-To: <1035368896.3968.31.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.NEB.4.44.0210231243010.14144-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Oct 2002, Alan Cox wrote:

> On Wed, 2002-10-23 at 10:56, Jan Marek wrote:
> > Hallo lkml,
> >
> > I'm sending 2 patches to fix compilation errors in the AFS fs.
> >
> > The first of them fixed union afs_dirent_t and using this union in the
> > fs/afs/dir.c.
> >
>
> What compiler are you using, this is building fine with the gcc's I
> have. Is it 2.95 ?

Most likely. Below is the error I see when trying to compile this file
with 2.95:

<--  snip  -->

...
  gcc -Wp,-MD,fs/afs/.dir.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=dir   -c -o fs/afs/dir.o fs/afs/dir.c
fs/afs/dir.c:75: warning: unnamed struct/union that defines no instances
fs/afs/dir.c: In function `afs_dir_iterate_block':
fs/afs/dir.c:261: union has no member named `name'
fs/afs/dir.c:293: union has no member named `name'
fs/afs/dir.c:296: union has no member named `vnode'
fs/afs/dir.c:296: union has no member named `vnode'
fs/afs/dir.c:296: union has no member named `vnode'
fs/afs/dir.c:297: union has no member named `unique'
make[2]: *** [fs/afs/dir.o] Error 1

<--  snip  -->

cu
Adrian

-- 

               "Is there not promise of rain?" Ling Tan asked suddenly out
                of the darkness. There had been need of rain for many days.
               "Only a promise," Lao Er said.
                                               Pearl S. Buck - Dragon Seed



