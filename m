Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317898AbSHBAJH>; Thu, 1 Aug 2002 20:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317905AbSHBAJH>; Thu, 1 Aug 2002 20:09:07 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:11500 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317898AbSHBAJG>;
	Thu, 1 Aug 2002 20:09:06 -0400
Date: Thu, 1 Aug 2002 20:12:34 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Banai Zoltan <bazooka@emitel.hu>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.30
In-Reply-To: <20020801233253.GA524@bazooka.saturnus.vein.hu>
Message-ID: <Pine.GSO.4.21.0208012000120.13359-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Aug 2002, Banai Zoltan wrote:

> There is a complie error:
> make[2]: Entering directory `/usr/src/linux-2.5.24/fs/partitions'
> gcc -Wp,-MD,./.check.o.d -D__KERNEL__
> -I/usr/src/linux-2.5.24/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
> -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686
> -nostdinc -iwithprefix include    -DKBUILD_BASENAME=check
> -DEXPORT_SYMTAB  -c -o check.o check.c
> check.c: In function `devfs_register_partitions':
> check.c:470: array subscript is not an integer

Argh.  My fault - it's devfs-only code and it didn't get tested ;-/

Fix: replace line 470 with
		p[part].de = NULL;


