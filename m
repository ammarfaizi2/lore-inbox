Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315916AbSENRfy>; Tue, 14 May 2002 13:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315918AbSENRfx>; Tue, 14 May 2002 13:35:53 -0400
Received: from adsl-132-170.wanadoo.be ([213.177.132.170]:53550 "EHLO
	slack.local") by vger.kernel.org with ESMTP id <S315916AbSENRfw> convert rfc822-to-8bit;
	Tue, 14 May 2002 13:35:52 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Pol <blenderman@wanadoo.be>
Reply-To: blenderman@wanadoo.be
To: linux-kernel@vger.kernel.org
Subject: SMP problem when compiling
Date: Tue, 14 May 2002 19:35:51 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200205141935.51167.blenderman@wanadoo.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi all,

I get this error when I compile the kernel 2.4.18 with make -j (make bzImage)

gcc -D__KERNEL__ -I/usr/src/linux-2.5.15/include -Wall -Wstrict-prototypes 
- -Wno-              trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing 
- -fno-common -pipe -mpref              erred-stack-boundary=2 -march=i686   
- -DKBUILD_BASENAME=ksyms  -DEXPORT_SYMTAB -c               ksyms.c
cpp0: gcc: Internal compiler error: program cc1 got fatal signal 11
output pipe has been closed
make[2]: *** [ksyms.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[2]: *** Waiting for unfinished jobs....
make[2]: Leaving directory `/usr/src/linux-2.5.15/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.15/kernel'
make: *** [_dir_kernel] Error 2
[19:32:47][root@slack:/usr/src/linux-2.5.15]# cd ../linux-2.4.18
[19:33:39][root@slack:/usr/src/linux-2.4.18]# make bzImage
gcc -D__KERNEL__ -I/usr/src/linux-2.4.18/include -Wall -Wstrict-prototypes 
- -Wno-              trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing 
- -fno-common -pipe -mpref              erred-stack-boundary=2 -march=i686   
- -DKBUILD_BASENAME=main -c -o init/main.o in              it/main.c
In file included from /usr/src/linux-2.4.18/include/linux/fs.h:26,
                 from /usr/src/linux-2.4.18/include/linux/capability.h:17,
                 from /usr/src/linux-2.4.18/include/linux/binfmts.h:5,
                 from /usr/src/linux-2.4.18/include/linux/sched.h:9,
                 from /usr/src/linux-2.4.18/include/linux/mm.h:4,
                 from /usr/src/linux-2.4.18/include/linux/slab.h:14,
                 from /usr/src/linux-2.4.18/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux-2.4.18/include/asm/bitops.h: In function `constant_test_bit':
/usr/src/linux-2.4.18/include/asm/bitops.h:235: parse error before `)'
/usr/src/linux-2.4.18/include/asm/bitops.h:236: warning: control reaches end 
of               non-void function
make: *** [init/main.o] Error 1
[19:33:46][root@slack:/usr/src/linux-2.4.18]# 


And with the 2.5.15:

gcc -D__KERNEL__ -I/usr/src/linux-2.5.15/include -Wall -Wstrict-prototypes 
- -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
- -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=lp  -c -o 
lp.o lp.c
serial.c: In function `probe_serial_pnp':
serial.c:5331: invalid use of undefined type `struct list_head'
make[3]: Leaving directory `/usr/src/linux-2.5.15/drivers/ide'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.15/drivers/ide'
make[1]: *** [_subdir_ide] Error 2
gcc -D__KERNEL__ -I/usr/src/linux-2.5.15/include -Wall -Wstrict-prototypes 
- -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
- -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=mem  -c -o 
mem.o mem.c
make[3]: *** [serial.o] Error 1
make[3]: *** Waiting for unfinished jobs....
make[3]: *** Waiting for unfinished jobs....
{standard input}: Assembler messages:
{standard input}:4084: Error: bad register name `%max'
{standard input}:6191: Error: bad register name `%eix)'
make[3]: *** [console.o] Error 1
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.15/drivers/char'
make[1]: *** [_subdir_char] Error 2
make: *** [_dir_drivers] Error 2
[19:35:22][root@slack:/usr/src/linux-2.5.15]#

- -- 
- -pol-
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE84Ur3EIL3A0sGDSERAqUDAKCB2KzCjflIQTCWPoVz+4BboCEoJQCgm2Dp
ETxF2H61zLAtMo/B37IV4nE=
=PJP9
-----END PGP SIGNATURE-----

