Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263440AbTDIOcd (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 10:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263469AbTDIOcd (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 10:32:33 -0400
Received: from franka.aracnet.com ([216.99.193.44]:40620 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263440AbTDIOcb (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 10:32:31 -0400
Date: Wed, 09 Apr 2003 07:43:51 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 561] New: Build failure in drivers/net/fc/iph5526.c
Message-ID: <188560000.1049899431@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=561

           Summary: Build failure in drivers/net/fc/iph5526.c
    Kernel Version: 2.5.67
            Status: NEW
          Severity: normal
             Owner: jgarzik@pobox.com
         Submitter: tobias@fresco.org


Distribution: source from ftp.kernel.org
Hardware Environment: mobile PIII
Software Environment: Debian
Problem Description: Build failure

Steps to reproduce:
Configure/build so that the relevant file gets build. Here's the bug I get when
compiling:

/usr/bin/make -f scripts/Makefile.build obj=drivers/net/fc
  gcc -Wp,-MD,drivers/net/fc/.iph5526.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=pentium3 -Iinclude/asm-i386/mach-default
-fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE  
-DKBUILD_BASENAME=iph5526 -DKBUILD_MODNAME=iph5526 -c -o
drivers/net/fc/.tmp_iph5526.o drivers/net/fc/iph5526.c
In file included from drivers/net/fc/iph5526.c:66:
drivers/net/fc/iph5526_scsi.h:28: syntax error before '*' token
drivers/net/fc/iph5526_scsi.h:28: warning: function declaration isn't a prototype
drivers/net/fc/iph5526.c: In function `iph5526_open':
drivers/net/fc/iph5526.c:2921: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:427)
drivers/net/fc/iph5526.c: In function `iph5526_close':
drivers/net/fc/iph5526.c:2928: warning: `MOD_DEC_USE_COUNT' is deprecated
(declared at include/linux/module.h:439)
drivers/net/fc/iph5526.c: In function `iph5526_detect':
drivers/net/fc/iph5526.c:3843: warning: comparison of distinct pointer types
lacks a cast
drivers/net/fc/iph5526.c: In function `add_to_sest':
drivers/net/fc/iph5526.c:4255: structure has no member named `address'
drivers/net/fc/iph5526.c:4355: structure has no member named `address'
drivers/net/fc/iph5526.c:4364: structure has no member named `address'
drivers/net/fc/iph5526.c:4370: structure has no member named `address'
make[4]: *** [drivers/net/fc/iph5526.o] Error 1
make[3]: *** [drivers/net/fc] Error 2
make[2]: *** [drivers/net] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.67'
make: *** [stamp-build] Error 2

