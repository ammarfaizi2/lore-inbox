Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267216AbTBLNrT>; Wed, 12 Feb 2003 08:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267222AbTBLNrT>; Wed, 12 Feb 2003 08:47:19 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:62188 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267216AbTBLNph>; Wed, 12 Feb 2003 08:45:37 -0500
Date: Wed, 12 Feb 2003 14:55:21 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>, "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre4-ac4: aicasm/aicasm doesn't compile
Message-ID: <20030212135520.GI17128@fs.tum.de>
References: <200302111754.h1BHsTB11002@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302111754.h1BHsTB11002@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:

I get the following compile error when trying to compile 2.4.21-pre4-ac4 
using gcc 2.95.4 20011002 (Debian prerelease) and binutils 2.13.90.0.18:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.20-ac/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6  -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.20-ac/include -e stext  
aicasm/aicasm.c   -o aicasm/aicasm
/usr/bin/ld: warning: cannot find entry symbol stext; defaulting to 
08048760
/tmp/ccF9fYkp.o(.text+0x372): In function `main':
: undefined reference to `symtable_open'
/tmp/ccF9fYkp.o(.text+0x37f): In function `main':
: undefined reference to `include_file'
/tmp/ccF9fYkp.o(.text+0x384): In function `main':
: undefined reference to `yyparse'
/tmp/ccF9fYkp.o(.text+0x3ea): In function `main':
: undefined reference to `symtable_dump'
/tmp/ccF9fYkp.o(.text+0x4bf): In function `output_code':
: undefined reference to `versions'
/tmp/ccF9fYkp.o(.text+0x548): In function `output_code':
: undefined reference to `patch_arg_list'
/tmp/ccF9fYkp.o(.text+0x560): In function `output_code':
: undefined reference to `patch_arg_list'
/tmp/ccF9fYkp.o(.text+0x566): In function `output_code':
: undefined reference to `prefix'
/tmp/ccF9fYkp.o(.text+0x58e): In function `output_code':
: undefined reference to `patch_arg_list'
/tmp/ccF9fYkp.o(.text+0x59c): In function `output_code':
: undefined reference to `prefix'
/tmp/ccF9fYkp.o(.text+0x5c6): In function `output_code':
: undefined reference to `prefix'
/tmp/ccF9fYkp.o(.text+0x5fa): In function `output_code':
: undefined reference to `prefix'
/tmp/ccF9fYkp.o(.text+0xb56): In function `stop':
: undefined reference to `yyfilename'
/tmp/ccF9fYkp.o(.text+0xb63): In function `stop':
: undefined reference to `yylineno'
/tmp/ccF9fYkp.o(.text+0xc55): In function `stop':
: undefined reference to `symlist_free'
/tmp/ccF9fYkp.o(.text+0xc5a): In function `stop':
: undefined reference to `symtable_close'
/tmp/ccF9fYkp.o(.text+0xcaf): In function `seq_alloc':
: undefined reference to `yylineno'
collect2: ld returned 1 exit status
make[4]: *** [aicasm/aicasm] Error 1
make[4]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.20-ac/drivers/scsi/aic7xxx'

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

