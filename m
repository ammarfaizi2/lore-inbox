Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288184AbSAQFgM>; Thu, 17 Jan 2002 00:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288185AbSAQFgB>; Thu, 17 Jan 2002 00:36:01 -0500
Received: from tomts14.bellnexxia.net ([209.226.175.35]:13470 "EHLO
	tomts14-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S288184AbSAQFft>; Thu, 17 Jan 2002 00:35:49 -0500
Subject: Linux 2.5.3-pre1 compiler warnings
From: Tim Coleman <tim@epenguin.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 17 Jan 2002 00:35:43 -0500
Message-Id: <1011245746.3984.0.camel@tux.epenguin.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed the following warnings when compiling 2.5.3-pre1 
this evening:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    
-c -o read_write.o read_write.c
In file included from read_write.c:13:
/usr/src/linux/include/linux/dnotify.h:18: warning: `struct inode'
declared inside parameter list
/usr/src/linux/include/linux/dnotify.h:18: warning: its scope is only
this definition or declaration, which is probably not what you want.
/usr/src/linux/include/linux/dnotify.h:21: warning: `struct inode'
declared inside parameter list
/usr/src/linux/include/linux/dnotify.h: In function `inode_dir_notify':
/usr/src/linux/include/linux/dnotify.h:23: dereferencing pointer to
incomplete type
/usr/src/linux/include/linux/dnotify.h:24: warning: passing arg 1 of
`__inode_dir_notify' from incompatible pointer type
read_write.c: In function `sys_read':
read_write.c:167: warning: passing arg 1 of `inode_dir_notify' from
incompatible pointer type
read_write.c: In function `sys_write':
read_write.c:194: warning: passing arg 1 of `inode_dir_notify' from
incompatible pointer type
read_write.c: In function `do_readv_writev':
read_write.c:299: warning: passing arg 1 of `inode_dir_notify' from
incompatible pointer type
read_write.c: In function `sys_pread':
read_write.c:371: warning: passing arg 1 of `inode_dir_notify' from
incompatible pointer type
read_write.c: In function `sys_pwrite':
read_write.c:403: warning: passing arg 1 of `inode_dir_notify' from
incompatible pointer type
make[2]: *** [read_write.o] Error 1
make[2]: Leaving directory `/usr/src/linux/fs'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux/fs'
make: *** [_dir_fs] Error 2



GCC version 2.95.4
-- 
Tim Coleman <tim@epenguin.org>                         [43.28 N 80.31 W]
BMath, Honours Combinatorics and Optimization, University of Waterloo
 "They that can give up essential liberty to obtain a little temporary
  safety deserve neither liberty nor safety." -- Benjamin Franklin

