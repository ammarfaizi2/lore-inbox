Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269207AbRHQAaV>; Thu, 16 Aug 2001 20:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269212AbRHQAaL>; Thu, 16 Aug 2001 20:30:11 -0400
Received: from ronispc.Chem.McGill.CA ([132.206.205.91]:15267 "EHLO
	ronispc.chem.mcgill.ca") by vger.kernel.org with ESMTP
	id <S269207AbRHQA3z>; Thu, 16 Aug 2001 20:29:55 -0400
Date: Thu, 16 Aug 2001 20:29:47 -0400
Message-Id: <200108170029.f7H0TlC7029810@ronispc.chem.mcgill.ca>
From: root <ronis@ronispc.chem.mcgill.ca>
To: linux-kernel@vger.kernel.org
Subject: Module Build Failure in fs/ntf/unistr.c
Reply-to: ronis@onsager.chem.mcgill.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I just patched 2.4.8 to 2.4.9 on an i686-linux-gnu(libc-2.2.3) box and
tried to compile using the same configuration options and compiler
(gcc-2.95.3) as I used to build 2.4.8.  The build fails in one of the
modules.  Here's the log:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=3 -march=i686 -DMODULE
-DNTFS_VERSION=\"1.1.16\" -c -o unistr.o unistr.c

unistr.c: In function `ntfs_collate_names':
unistr.c:99: warning: implicit declaration of function `min'
unistr.c:99: parse error before `unsigned'
unistr.c:99: parse error before `)'
unistr.c:97: warning: `c1' might be used uninitialized in this function
unistr.c: At top level:
unistr.c:118: parse error before `if'
unistr.c:123: warning: type defaults to `int' in declaration of `c1'
unistr.c:123: `name1' undeclared here (not in a function)
unistr.c:123: warning: data definition has no type or storage class
unistr.c:124: parse error before `if'
make[2]: *** [unistr.o] Error 1
make[2]: Leaving directory `/usr/src/linux/fs/ntfs'
make[1]: *** [_modsubdir_ntfs] Error 2
make[1]: Leaving directory `/usr/src/linux/fs'
make: *** [_mod_fs] Error 2

David
