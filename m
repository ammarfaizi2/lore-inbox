Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316530AbSGHHTn>; Mon, 8 Jul 2002 03:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316577AbSGHHTm>; Mon, 8 Jul 2002 03:19:42 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:26933 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316530AbSGHHTl>; Mon, 8 Jul 2002 03:19:41 -0400
Message-Id: <5.1.0.14.2.20020708081259.0419a450@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 08 Jul 2002 08:22:56 +0100
To: Miles Lane <miles@megapathdsl.net>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: 2.5.25 -- Build error -- fs/ntfs/layout.h:299: unnamed
  fields of type other than struct or union are not allowed
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3D2936DD.5040700@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are using gcc-3.1. Upgrade to a newer / downgrade to an older version 
or enable the work around I have posted before. (edit fs/ntfs/types.h and 
add your compiler version to the #if __GNUC__... line at the top)

Your gcc is broken is the summary.

Best regards,

         Anton

At 07:53 08/07/02, Miles Lane wrote:
>  gcc -Wp,-MD,./.aops.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
> -march=athlon  -nostdinc -iwithprefix include -DMODULE 
> -DNTFS_VERSION=\"2.0.14\" -DDEBUG  -DKBUILD_BASENAME=aops   -c -o aops.o aops.c
>In file included from inode.h:29,
>                 from debug.h:30,
>                 from ntfs.h:40,
>                 from aops.c:30:
>layout.h:299: unnamed fields of type other than struct or union are not 
>allowed
>layout.h:1449: unnamed fields of type other than struct or union are not 
>allowed
>layout.h:1465: unnamed fields of type other than struct or union are not 
>allowed
>layout.h:1714: unnamed fields of type other than struct or union are not 
>allowed
>layout.h:1891: unnamed fields of type other than struct or union are not 
>allowed
>layout.h:2051: unnamed fields of type other than struct or union are not 
>allowed
>layout.h:2063: unnamed fields of type other than struct or union are not 
>allowed
>make[2]: *** [aops.o] Error 1
>make[2]: Leaving directory `/usr/src/linux/fs/ntfs'
>
>CONFIG_QUOTA=y
>CONFIG_QFMT_V1=m
>CONFIG_QFMT_V2=m
>CONFIG_QUOTACTL=y
>CONFIG_AUTOFS4_FS=y
>CONFIG_EXT3_FS=y
>CONFIG_FAT_FS=m
>CONFIG_VFAT_FS=m
>CONFIG_ISO9660_FS=m
>CONFIG_JOLIET=y
>CONFIG_NTFS_FS=m
>CONFIG_NTFS_DEBUG=y
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

