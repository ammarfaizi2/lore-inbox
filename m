Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267915AbTBVUxE>; Sat, 22 Feb 2003 15:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267916AbTBVUxE>; Sat, 22 Feb 2003 15:53:04 -0500
Received: from franka.aracnet.com ([216.99.193.44]:64454 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267915AbTBVUxC>; Sat, 22 Feb 2003 15:53:02 -0500
Date: Sat, 22 Feb 2003 13:03:07 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 391] New: 2.5.62-bk5 compile failure with gcc-2.95 
Message-ID: <2330000.1045947787@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=391

           Summary: 2.5.62-bk5 compile failure with gcc-2.95
    Kernel Version: 2.5.62-bk5
            Status: NEW
          Severity: blocking
             Owner: ambx1@neo.rr.com
         Submitter: plars@austin.ibm.com


Distribution:Debian stable
Hardware Environment:pIII-800
Software Environment:gcc-2.95
Problem Description:
I got this compile failure on the nightly bk pull test last night.  It should
match up to what's in -bk5:
  gcc -Wp,-MD,drivers/pnp/.interface.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=interface
-DKBUILD_MODNAME=interface -c -o drivers/pnp/interface.o drivers/pnp/interface.c
drivers/pnp/interface.c: In function `pnp_set_current_resources':
drivers/pnp/interface.c:438: parse error before `struct'
drivers/pnp/interface.c:440: `res' undeclared (first use in this function)
drivers/pnp/interface.c:440: (Each undeclared identifier is reported only once
drivers/pnp/interface.c:440: for each function it appears in.)
drivers/pnp/interface.c:448: `nport' undeclared (first use in this function)
drivers/pnp/interface.c:468: `nmem' undeclared (first use in this function)
drivers/pnp/interface.c:488: `nirq' undeclared (first use in this function)
drivers/pnp/interface.c:500: `ndma' undeclared (first use in this function)
make[2]: *** [drivers/pnp/interface.o] Error 1
make[1]: *** [drivers/pnp] Error 2
make: *** [drivers] Error 2
Steps to reproduce:
I tried reproducing this with gcc-3.2 and it compiles fine, but when I switch to
2.95 it breaks.

