Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319252AbSHNRvE>; Wed, 14 Aug 2002 13:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319261AbSHNRvE>; Wed, 14 Aug 2002 13:51:04 -0400
Received: from 26-120-ADSL.red.retevision.es ([80.224.120.26]:35267 "EHLO
	jerry.boludo.cjb.net") by vger.kernel.org with ESMTP
	id <S319252AbSHNRvE>; Wed, 14 Aug 2002 13:51:04 -0400
Date: Wed, 14 Aug 2002 19:54:55 +0200
From: Javier Marcet <jmarcet@pobox.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre2-ac1
Message-ID: <20020814175455.GA5254@jerry.boludo.cjb.net>
References: <200208141634.g7EGYGO29387@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208141634.g7EGYGO29387@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan Cox,
on Wed, 14 Aug 2002 12:34:16 +0000, you wrote:

> Linux 2.4.20-pre2-ac1
> o	Merge 2.4.20-pre2
> 	-	drop change to apic error logging level
> 	-	drop bogus sign cast in spin_is_locked
> o	Fix partition table breakage			(me)

I get this:

make -C partitions
make[2]: Entering directory `/usr/src/linux-2.4.20-pre2-ac1/fs/partitions'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.4.20-pre2-ac1/fs/partitions'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20-pre2-ac1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon-xp    -nostdinc -I /usr/lib/gcc-lib/i686-pc-linux-gnu/3.2/include -DKBUILD_BASENAME=check  -DEXPORT_SYMTAB -c check.c
check.c: In function `devfs_register_disc':
check.c:328: structure has no member named `number'
check.c:329: structure has no member named `number'
check.c: In function `devfs_register_partitions':
check.c:361: structure has no member named `number'
make[3]: *** [check.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.20-pre2-ac1/fs/partitions'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.20-pre2-ac1/fs/partitions'
make[1]: *** [_subdir_partitions] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.20-pre2-ac1/fs'
make: *** [_dir_fs] Error 2

This is whether I enable CONFIG_PARTITION_ADVANCED ( and CONFIG_MSDOS_PARTITION )
or not. This happens in 2.4.20-pre2 too, while it doesn't either in pre1
nor pre2-ac3.

