Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310917AbSDQRbt>; Wed, 17 Apr 2002 13:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSDQRbs>; Wed, 17 Apr 2002 13:31:48 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:32526 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S310917AbSDQRbr> convert rfc822-to-8bit;
	Wed, 17 Apr 2002 13:31:47 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Marc-Christian Petersen <m.c.p@gmx.net>
Reply-To: m.c.p@gmx.net
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Possible EXT2 File System Corruption in Kernel 2.4
Date: Wed, 17 Apr 2002 19:31:30 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andreas Dilger <adilger@clusterfs.com>
X-PRIORITY: 2 (High)
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <20020417173147Z310917-22651+8390@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

your patch does not work:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.18/include  -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=balloc  -c -o 
balloc.o balloc.c
balloc.c: In function `ext2_new_block':
balloc.c:524: warning: long unsigned int format, unsigned int arg (arg 4)
balloc.c:397: label `io_error' used but not defined
balloc.c:383: label `out' used but not defined
gcc: Internal compiler error: program cc1 got fatal signal 11
make[3]: *** [balloc.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.18/fs/ext2'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.18/fs/ext2'
make[1]: *** [_subdir_ext2] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.18/fs'
make: *** [_dir_fs] Error 2
-- 

Kind regards
	Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824  080A 569D E2E3 DB44 1A16
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.
