Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbTEEQV2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTEEQTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:19:50 -0400
Received: from franka.aracnet.com ([216.99.193.44]:35000 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262567AbTEEQTf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:19:35 -0400
Date: Mon, 05 May 2003 09:31:31 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 649] New: make stops compiling isdn_common.c with my .config
Message-ID: <9580000.1052152291@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=649

           Summary: make stops compiling isdn_common.c with my .config
    Kernel Version: 2.5.68
            Status: NEW
          Severity: normal
             Owner: zippel@linux-m68k.org
         Submitter: georg.lippold@gmx.de


Distribution: gentoo linux 1.4_rc3
Hardware Environment: x68/pentium III
Software Environment: gcc 3.2.2
Problem Description:
I entered a kernel configuration via make menuconfig, but it wont compile
the isdn submodules. Here is the output

make -f scripts/Makefile.build obj=drivers/isdn/i4l
  gcc -Wp,-MD,drivers/isdn/i4l/.isdn_common.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=pentium3
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE
-DKBUILD_BASENAME=isdn_common -DKBUILD_MODNAME=isdn -c -o
drivers/isdn/i4l/isdn_common.o
drivers/isdn/i4l/isdn_common.c
drivers/isdn/i4l/isdn_common.c: In function `map_drvname':
drivers/isdn/i4l/isdn_common.c:1984: structure has no member named `drvid'
drivers/isdn/i4l/isdn_common.c: In function `map_namedrv':
drivers/isdn/i4l/isdn_common.c:1991: structure has no member named `drvid'
drivers/isdn/i4l/isdn_common.c: In function `isdn_register_divert':
drivers/isdn/i4l/isdn_common.c:2007: warning: `MOD_DEC_USE_COUNT' is
deprecated (declared at include/linux/module.h:439)
drivers/isdn/i4l/isdn_common.c:2013: `isdn_command' undeclared (first use in
this function)
drivers/isdn/i4l/isdn_common.c:2013: (Each undeclared identifier is reported
only once
drivers/isdn/i4l/isdn_common.c:2013: for each function it appears in.)
drivers/isdn/i4l/isdn_common.c:2016: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:427)
drivers/isdn/i4l/isdn_common.c: At top level:
drivers/isdn/i4l/isdn_common.c:2169: warning: `isdn_register_devfs' defined
but not used
drivers/isdn/i4l/isdn_common.c:2179: warning: `isdn_unregister_devfs'
defined but not used
make[3]: *** [drivers/isdn/i4l/isdn_common.o] Error 1
make[2]: *** [drivers/isdn/i4l] Error 2
make[1]: *** [drivers/isdn] Error 2
make: *** [drivers] Error 2

Steps to reproduce:
use my .config with 2.5.68, make menuconfig, make and this error happens...

