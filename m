Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbTBKPyi>; Tue, 11 Feb 2003 10:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbTBKPyh>; Tue, 11 Feb 2003 10:54:37 -0500
Received: from franka.aracnet.com ([216.99.193.44]:15762 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262780AbTBKPyg>; Tue, 11 Feb 2003 10:54:36 -0500
Date: Tue, 11 Feb 2003 08:04:17 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 339] New: compile failure in drivers/char/watchdog/sc1200wdt.c
Message-ID: <83520000.1044979457@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=339

           Summary: compile failure in drivers/char/watchdog/sc1200wdt.c
    Kernel Version: 2.5.60-bk1
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: john@larvalstage.com


Distribution:  Gentoo 1.4rc2
Hardware Environment:  Abit KG7-RAID, AMD Athlon TBird 1.4, 512MB DDR,
Geforce 3 Software Environment:  gcc 3.2.1, glibc 2.3.1, ld 2.13.90.0.16
Problem Description:

  gcc -Wp,-MD,drivers/char/watchdog/.sc1200wdt.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
-DKBUILD_BASENAME=sc1200wdt
-DKBUILD_MODNAME=sc1200wdt -c -o drivers/char/watchdog/sc1200wdt.o
drivers/char/watchdog/sc1200wdt.c
drivers/char/watchdog/sc1200wdt.c: In function `sc1200wdt_isapnp_probe':
drivers/char/watchdog/sc1200wdt.c:338: warning: implicit declaration of
function `isapnp_find_dev'
drivers/char/watchdog/sc1200wdt.c:338: warning: assignment makes pointer
from integer without a cast
drivers/char/watchdog/sc1200wdt.c:342: structure has no member named
`prepare' drivers/char/watchdog/sc1200wdt.c:352: structure has no member
named `activate' drivers/char/watchdog/sc1200wdt.c: In function
`sc1200wdt_init':
drivers/char/watchdog/sc1200wdt.c:426: structure has no member named
`deactivate' drivers/char/watchdog/sc1200wdt.c: In function
`sc1200wdt_exit':
drivers/char/watchdog/sc1200wdt.c:439: structure has no member named
`deactivate' make[3]: *** [drivers/char/watchdog/sc1200wdt.o] Error 1
make[2]: *** [drivers/char/watchdog] Error 2
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2


Steps to reproduce:

Character devices  --->
Watchdog Cards  --->
<*> National Semiconductor PC87307/PC97307 (ala SC1200) Watchdog

CONFIG_SC1200_WDT=y


