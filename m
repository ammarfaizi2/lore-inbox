Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316172AbSEOAlX>; Tue, 14 May 2002 20:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316173AbSEOAlW>; Tue, 14 May 2002 20:41:22 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:16274 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316172AbSEOAlV>; Tue, 14 May 2002 20:41:21 -0400
Date: Wed, 15 May 2002 02:41:13 +0200
From: "Axel H. Siebenwirth" <axel@hh59.org>
To: linux-kernel@vger.kernel.org
Cc: aia21@cantab.net
Subject: [2.5.15] NTFS does not compile. (with gcc3.1)
Message-ID: <20020515004113.GA21702@neon>
Mail-Followup-To: linux-kernel@vger.kernel.org, aia21@cantab.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: hh59.org
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel developers,

I know, I know, I am not supposed to use gcc 3.x with linux kernel build,
but maybe someone can just give me a hint what gcc option to add to NTFS
build to get it to work?
I just tried to build 2.5.15 and it stops during compilation of
fs/ntfs/aops.c because of included header file layout.h:

gcc -D__KERNEL__ -I/usr/src/linux-2.5.15/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686  -DNTFS_VERSION=\"2.0.6\"
-DDEBUG -DKBUILD_BASENAME=aops  -c -o aops.o aops.c
In file included from attrib.h:31,
                 from debug.h:31,
                 from ntfs.h:43,
                 from aops.c:30:
layout.h:299: unnamed fields of type other than struct or union are not
allowed
layout.h:1450: unnamed fields of type other than struct or union are not
allowed
layout.h:1466: unnamed fields of type other than struct or union are not
allowed
layout.h:1715: unnamed fields of type other than struct or union are not
allowed
layout.h:1892: unnamed fields of type other than struct or union are not
allowed
layout.h:2052: unnamed fields of type other than struct or union are not
allowed
layout.h:2064: unnamed fields of type other than struct or union are not
allowed
make[3]: *** [aops.o] Error 1
make[3]: Leaving directory /usr/src/linux-2.5.15/fs/ntfs'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory /usr/src/linux-2.5.15/fs/ntfs'
make[1]: *** [_subdir_ntfs] Error 2
make[1]: Leaving directory /usr/src/linux-2.5.15/fs'
make: *** [_dir_fs] Error 2



Regards,
Axel
