Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263483AbTDIOyJ (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 10:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263485AbTDIOyJ (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 10:54:09 -0400
Received: from franka.aracnet.com ([216.99.193.44]:19670 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263483AbTDIOyH (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 10:54:07 -0400
Date: Wed, 09 Apr 2003 08:05:44 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 562] New: Build error on file drivers/mtd/mtdblock.c
Message-ID: <189040000.1049900744@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=562

           Summary: Build error on file drivers/mtd/mtdblock.c
    Kernel Version: 2.5.67
            Status: NEW
          Severity: normal
             Owner: dwmw2@infradead.org
         Submitter: tobias@fresco.org


Distribution: source form ftp.kernel.org
Hardware Environment: mobile PIII
Software Environment: Debian
Problem Description: Building the kernel fails with the following error:

Steps to reproduce:
Build a kernel with MTD enabled.

  gcc -Wp,-MD,drivers/mtd/.mtdblock.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=pentium3 -Iinclude/asm-i386/mach-default
-fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE  
-DKBUILD_BASENAME=mtdblock -DKBUILD_MODNAME=mtdblock -c -o
drivers/mtd/.tmp_mtdblock.o drivers/mtd/mtdblock.c
drivers/mtd/mtdblock.c: In function `handle_mtdblock_request':
drivers/mtd/mtdblock.c:391: warning: assignment makes pointer from integer
without a cast
drivers/mtd/mtdblock.c:391: syntax error before '{' token
drivers/mtd/mtdblock.c:394: `p' undeclared (first use in this function)
drivers/mtd/mtdblock.c:394: (Each undeclared identifier is reported only once
drivers/mtd/mtdblock.c:394: for each function it appears in.)
drivers/mtd/mtdblock.c: At top level:
drivers/mtd/mtdblock.c:442: syntax error before '}' token
make[3]: *** [drivers/mtd/mtdblock.o] Error 1
make[2]: *** [drivers/mtd] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.67'
make: *** [stamp-build] Error 2

