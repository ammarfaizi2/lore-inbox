Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277527AbRJRBJQ>; Wed, 17 Oct 2001 21:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277531AbRJRBJG>; Wed, 17 Oct 2001 21:09:06 -0400
Received: from research.suspicious.org ([209.236.159.254]:8258 "EHLO
	research.suspicious.org") by vger.kernel.org with ESMTP
	id <S277527AbRJRBJE>; Wed, 17 Oct 2001 21:09:04 -0400
Date: Wed, 17 Oct 2001 21:11:47 -0400 (EDT)
From: Phil <phil@research.suspicious.org>
To: linux-kernel@vger.kernel.org
Subject: error in udf fs
Message-ID: <Pine.BSO.4.21.0110172110070.12347-100000@research.suspicious.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this is what happens with the udf fs in 2.4.13-pre3 

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4     -c
-o lowlevel.o lowlevel.c
lowlevel.c:72: conflicting types for `udf_get_last_block'
udfdecl.h:153: previous declaration of `udf_get_last_block'
make[3]: *** [lowlevel.o] Error 1
make[3]: Leaving directory `/usr/src/linux/fs/udf'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/fs/udf'
make[1]: *** [_subdir_udf] Error 2
make[1]: Leaving directory `/usr/src/linux/fs'
make: *** [_dir_fs] Error 2


