Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262921AbSJBBeE>; Tue, 1 Oct 2002 21:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262922AbSJBBeE>; Tue, 1 Oct 2002 21:34:04 -0400
Received: from byterapers.com ([195.156.109.210]:52629 "EHLO byterapers.com")
	by vger.kernel.org with ESMTP id <S262921AbSJBBeD>;
	Tue, 1 Oct 2002 21:34:03 -0400
Date: Wed, 2 Oct 2002 04:39:30 +0300 (EEST)
From: <jhakala@byterapers.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40 aha152x module broken
Message-ID: <Pine.LNX.4.21.0210020435250.28657-100000@byterapers.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.5.40 seems to be unable to compile aha152x module.
The error message:
  gcc -Wp,-MD,./.aha152x.o.d -D__KERNEL__ -I/usr/src/linux-2.5.40/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon  -I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc
-iwithprefix include -DMODULE -include
/usr/src/linux-2.5.40/include/linux/modversions.h  -DAHA152X_STAT
-DAUTOCONF -DKBUILD_BASENAME=aha152x   -c -o aha152x.o aha152x.c
drivers/scsi/aha152x.c: In function `intr':
drivers/scsi/aha152x.c:1944: warning: implicit declaration of function
`queue_task'
drivers/scsi/aha152x.c:1944: `tq_immediate' undeclared (first use in this
function)
drivers/scsi/aha152x.c:1944: (Each undeclared identifier is reported only
once
drivers/scsi/aha152x.c:1944: for each function it appears in.)
drivers/scsi/aha152x.c:1945: warning: implicit declaration of function
`mark_bh'
drivers/scsi/aha152x.c:1945: `IMMEDIATE_BH' undeclared (first use in this
function)


>From http://byterapers.com/~jhakala/config2540_riva you can get my .config
-file. Compiler used was GCC 2.96-81(the redhat flavor).

BTW. I don't remember how it was on 2.4.x, but atleast now it still keeps
compiling other modules if one fails.



