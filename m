Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269467AbTCDSDR>; Tue, 4 Mar 2003 13:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269470AbTCDSDR>; Tue, 4 Mar 2003 13:03:17 -0500
Received: from franka.aracnet.com ([216.99.193.44]:3772 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S269467AbTCDSDN>; Tue, 4 Mar 2003 13:03:13 -0500
Date: Tue, 04 Mar 2003 10:13:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 436] New: i82365.c does not compile (too many arguments to
 `pnp_activate_dev')
Message-ID: <127170000.1046801620@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=436

           Summary: i82365.c does not compile (too many arguments to
                    `pnp_activate_dev')
    Kernel Version: 2.5.63
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: vincent@gryzor.com


Distribution: Debian sid
Hardware Environment: HP pavilion n5422 laptop
Software Environment: gcc3.2
Problem Description: i82365.c does not compile and issues errors [and
warnings]

  gcc -Wp,-MD,drivers/pcmcia/.i82365.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=pentium3
-Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix
include -DMODULE  
-DKBUILD_BASENAME=i82365 -DKBUILD_MODNAME=i82365 -c -o
drivers/pcmcia/i82365.o drivers/pcmcia/i82365.c
drivers/pcmcia/i82365.c: In function `is_alive':
drivers/pcmcia/i82365.c:720: warning: `__check_region' is deprecated
(declared at include/linux/ioport.h:112)
drivers/pcmcia/i82365.c: In function `isa_probe':
drivers/pcmcia/i82365.c:849: too many arguments to function
`pnp_activate_dev' drivers/pcmcia/i82365.c:867: warning: `__check_region'
is deprecated (declared at include/linux/ioport.h:112)
make[3]: *** [drivers/pcmcia/i82365.o] Error 1
make[2]: *** [drivers/pcmcia] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.63'
make: *** [stamp-build] Error 2

Steps to reproduce:
I got this error (of course) when compiling this driver as module as well as
compiled in kernel.

