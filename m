Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318285AbSIBMiv>; Mon, 2 Sep 2002 08:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318286AbSIBMiv>; Mon, 2 Sep 2002 08:38:51 -0400
Received: from mta.sara.nl ([145.100.16.144]:46577 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S318285AbSIBMiu>;
	Mon, 2 Sep 2002 08:38:50 -0400
Date: Mon, 2 Sep 2002 14:43:09 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: swim3.c compile error on 2.5.33
From: Remco Post <r.post@sara.nl>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <895E05A8-BE71-11D6-9030-000393911DE2@sara.nl>
X-Pgp-Agent: GPGMail 0.5.3 (v20)
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

when building 2.5.33 on my powermac (gcc 2.95.4 and binutils 2.13) I get:

make[2]: Entering directory `/usr/src/linux-2.5.33/drivers/block'
   gcc -Wp,-MD,./.swim3.o.d -D__KERNEL__ -I/usr/src/linux-2.5.33/include 
- -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
- -fno-strict-aliasing -fno-common -I/usr/src/linux-2.5.33/arch/ppc 
- -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized 
- -mmultiple -mstring -nostdinc -iwithprefix include    
- -DKBUILD_BASENAME=swim3   -c -o swim3.o swim3.c
swim3.c: In function `do_fd_request':
swim3.c:306: warning: implicit declaration of function `sti'
swim3.c: In function `set_timeout':
swim3.c:369: warning: implicit declaration of function `save_flags'
swim3.c:369: warning: implicit declaration of function `cli'
swim3.c:377: warning: implicit declaration of function `restore_flags'
swim3.c: In function `swim3_init':
swim3.c:1042: `DEVICE_REQUEST' undeclared (first use in this function)
swim3.c:1042: (Each undeclared identifier is reported only once
swim3.c:1042: for each function it appears in.)
swim3.c:1043: `blksize_size' undeclared (first use in this function)
swim3.c: In function `swim3_add_device':
swim3.c:1114: `do_floppy' undeclared (first use in this function)
swim3.c: At top level:
swim3.c:297: warning: `do_fd_request' defined but not used
swim3.c:1002: warning: `floppy_off' defined but not used
make[2]: *** [swim3.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.33/drivers/block'
make[1]: *** [block] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.33/drivers'
make: *** [drivers] Error 2

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

iD8DBQE9c1zlBIoCv9yTlOwRAqIDAJ9dA6YlbztAXyoGcSG3nblBBqZF6ACfYL5O
cJO8DWwxrJIGn80HFt4R6TE=
=ELxb
-----END PGP SIGNATURE-----

