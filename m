Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262643AbSI0W6f>; Fri, 27 Sep 2002 18:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262644AbSI0W6e>; Fri, 27 Sep 2002 18:58:34 -0400
Received: from daytona.gci.com ([205.140.80.57]:54534 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S262643AbSI0W6d>;
	Fri, 27 Sep 2002 18:58:33 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA3150ABAADAD@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Linux v2.5.39 - more build errors
Date: Fri, 27 Sep 2002 15:03:43 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -Wp,-MD,./.pas16.o.d -D__KERNEL__ -I/usr/src/linux-2.5.39/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -I/usr/src/linux-2.5.39/arch/i386/mach-generic -nostdinc
-iwithprefix include -DMODULE -include
/usr/src/linux-2.5.39/include/linux/modversions.h   -DKBUILD_BASENAME=pas16
-c -o pas16.o pas16.c
In file included from pas16.c:598:
NCR5380.c: In function `NCR5380_print':
NCR5380.c:409: warning: implicit declaration of function `save_flags'
NCR5380.c:410: warning: implicit declaration of function `cli'
NCR5380.c:416: warning: implicit declaration of function `restore_flags'
NCR5380.c:405: warning: `flags' might be used uninitialized in this function
NCR5380.c: In function `NCR5380_timer_fn':
NCR5380.c:620: `io_request_lock' undeclared (first use in this function)
NCR5380.c:620: (Each undeclared identifier is reported only once
NCR5380.c:620: for each function it appears in.)
NCR5380.c: In function `pas16_proc_info':
NCR5380.c:875: `io_request_lock' undeclared (first use in this function)
In file included from pas16.c:598:
NCR5380.c: In function `do_pas16_intr':
NCR5380.c:1387: `io_request_lock' undeclared (first use in this function)
NCR5380.c: In function `NCR5380_transfer_dma':
NCR5380.c:2022: `io_request_lock' undeclared (first use in this function)
pas16.c: At top level:
NCR5380.c:459: warning: `NCR5380_print_phase' defined but not used
NCR5380.c:403: warning: `NCR5380_print' defined but not used
make[2]: *** [pas16.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.39/drivers/scsi'
make[1]: *** [scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.39/drivers'
make: *** [drivers] Error 2
