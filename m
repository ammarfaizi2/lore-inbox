Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318219AbSIBMZk>; Mon, 2 Sep 2002 08:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318269AbSIBMZj>; Mon, 2 Sep 2002 08:25:39 -0400
Received: from mta.sara.nl ([145.100.16.144]:1777 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S318219AbSIBMZi>;
	Mon, 2 Sep 2002 08:25:38 -0400
Date: Mon, 2 Sep 2002 14:29:56 +0200
Subject: Re: Linux v2.5.33, compile error on powermac
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@transmeta.com>
From: Remco Post <r.post@sara.nl>
In-Reply-To: <Pine.LNX.4.33.0208311514430.6221-100000@penguin.transmeta.com>
Message-Id: <B0754740-BE6F-11D6-9030-000393911DE2@sara.nl>
Content-Transfer-Encoding: 7bit
X-Pgp-Agent: GPGMail 0.5.3 (v20)
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

on my powermac with a plain Debian 3.0 install (gcc version 2.95.4 
20011002 (Debian prerelease)) + binutils 2.13 I get two compile errors, 
one for intermezzo (module), the other for reiserfs (not module):

   gcc -Wp,-MD,./.vfs.o.d -D__KERNEL__ -I/usr/src/linux-2.5.33/include 
- -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
- -fno-strict-aliasing -fno-common -I/usr/src/linux-2.5.33/arch/ppc 
- -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized 
- -mmultiple -mstring -nostdinc -iwithprefix include -DMODULE -include 
/usr/src/linux-2.5.33/include/linux/modversions.h   
- -DKBUILD_BASENAME=vfs   -c -o vfs.o vfs.c
vfs.c: In function `presto_debug_fail_blkdev':
vfs.c:134: invalid initializer
vfs.c:136: warning: implicit declaration of function `is_read_only'
vfs.c: In function `presto_do_rmdir':
vfs.c:1244: warning: implicit declaration of function `double_down'
vfs.c:1260: warning: implicit declaration of function `double_up'
vfs.c: In function `presto_rename_dir':
vfs.c:1627: warning: implicit declaration of function `triple_down'
vfs.c:1644: warning: implicit declaration of function `triple_up'
vfs.c: In function `lento_do_rename':
vfs.c:1755: warning: implicit declaration of function `double_lock'
vfs.c: In function `lento_iopen':
vfs.c:1934: called object is not a function
vfs.c:1935: parse error before string constant
make[2]: *** [vfs.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.33/fs/intermezzo'
make[1]: *** [intermezzo] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.33/fs'
make: *** [fs] Error 2

When I configure not to build intermezzo at all, the make stops at:

make[2]: Entering directory `/usr/src/linux-2.5.33/fs/reiserfs'
   gcc -Wp,-MD,./.resize.o.d -D__KERNEL__ -I/usr/src/linux-2.5.33/include 
- -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
- -fno-strict-aliasing -fno-common -I/usr/src/linux-2.5.33/arch/ppc 
- -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized 
- -mmultiple -mstring -nostdinc -iwithprefix include  -O1  
- -DKBUILD_BASENAME=resize   -c -o resize.o resize.c
In file included from resize.c:12:
/usr/src/linux-2.5.33/include/linux/vmalloc.h:26: parse error before 
`pgprot_t'
/usr/src/linux-2.5.33/include/linux/vmalloc.h:26: warning: function 
declaration isn't a prototype
/usr/src/linux-2.5.33/include/linux/vmalloc.h:37: parse error before 
`pgprot_t'
/usr/src/linux-2.5.33/include/linux/vmalloc.h:38: warning: function 
declaration isn't a prototype
make[2]: *** [resize.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.33/fs/reiserfs'
make[1]: *** [reiserfs] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.33/fs'
make: *** [fs] Error 2

- ---
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam    http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167
PGP keys at http://home.sara.nl/~remco/keys.asc

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer 
industry
didn't even foresee that the century was going to end." -- Douglas Adams


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (Darwin)

iD8DBQE9c1nMBIoCv9yTlOwRAjHdAKClkl10fFrMFHjbsVkZEZENdLegCwCfZjZB
0qu7p4NN1JSxQpYsxserfw8=
=g9+h
-----END PGP SIGNATURE-----

