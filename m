Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130811AbRBWXNB>; Fri, 23 Feb 2001 18:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130814AbRBWXMw>; Fri, 23 Feb 2001 18:12:52 -0500
Received: from eax.student.umd.edu ([129.2.228.67]:21000 "EHLO
	eax.student.umd.edu") by vger.kernel.org with ESMTP
	id <S130811AbRBWXMg>; Fri, 23 Feb 2001 18:12:36 -0500
Date: Fri, 23 Feb 2001 19:14:43 -0500 (EST)
From: Adam <adam@eax.com>
X-X-Sender: <adam@eax.student.umd.edu>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.4.2 && Minix SP
In-Reply-To: <Pine.LNX.4.10.10102211811430.1005-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0102231912260.2064-100000@eax.student.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


are those MINIX_SUBPARITIONS in 2.4.2 actually supposed to copile?
in fs/partitions/msdos.c it refers to some MINIX defines which do not
seems to be included in that path.

---------------------------------
gcc -D__KERNEL__ -I/usr/src/Linux/24/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-march=i686    -c -o msdos.o msdos.c
msdos.c: In function `minix_partition':
msdos.c:403: `MINIX_PARTITION' undeclared (first use in this function)
msdos.c:403: (Each undeclared identifier is reported only once
msdos.c:403: for each function it appears in.)
msdos.c:406: `MINIX_NR_SUBPARTITIONS' undeclared (first use in this
function)
msdos.c: In function `msdos_partition':
msdos.c:571: `MINIX_PARTITION' undeclared (first use in this function)
make[3]: *** [msdos.o] Error 1
make[3]: Leaving directory `/usr/src/Linux/24/linux/fs/partitions'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/Linux/24/linux/fs/partitions'
make[1]: *** [_subdir_partitions] Error 2
make[1]: Leaving directory `/usr/src/Linux/24/linux/fs'
make: *** [_dir_fs] Error 2
---------------------------------


-- 
Adam
http://www.eax.com      The Supreme Headquarters of the 32 bit registers


