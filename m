Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbTDIV5j (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 17:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263857AbTDIV5j (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 17:57:39 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:19934 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263851AbTDIV5g (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 17:57:36 -0400
Date: Wed, 09 Apr 2003 14:59:08 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 566] New: compile failure in drivers/char/rio/rio_linux.c 
Message-ID: <14680000.1049925548@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=566

           Summary: compile failure in drivers/char/rio/rio_linux.c
    Kernel Version: 2.5.67
            Status: NEW
          Severity: low
             Owner: rmk@arm.linux.org.uk
         Submitter: john@larvalstage.com


Distribution:  Gentoo 1.4rc2
Hardware Environment:  Abit KG7-RAID, AMD AthlonXP 2100+, 512MB DDR
Software Environment:  gcc 3.2.2, glibc 2.3.1, ld 2.13.90.0.18
Problem Description:

  gcc -Wp,-MD,drivers/char/rio/.rio_linux.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=rio_linux
-DKBUILD_MODNAME=rio -c -o drivers/char/rio/.tmp_rio_linux.o
drivers/char/rio/rio_linux.c
drivers/char/rio/rio_linux.c: In function `rio_ioctl':
drivers/char/rio/rio_linux.c:732: warning: implicit declaration of function
`verify_area'
drivers/char/rio/rio_linux.c:732: `VERIFY_READ' undeclared (first use in this
function)
drivers/char/rio/rio_linux.c:732: (Each undeclared identifier is reported only once
drivers/char/rio/rio_linux.c:732: for each function it appears in.)
drivers/char/rio/rio_linux.c:734: warning: implicit declaration of function
`get_user'
drivers/char/rio/rio_linux.c:741: `VERIFY_WRITE' undeclared (first use in this
function)
make[3]: *** [drivers/char/rio/rio_linux.o] Error 1
make[2]: *** [drivers/char/rio] Error 2
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2


Steps to reproduce:

Character devices  --->
<*>   Specialix RIO system support

CONFIG_RIO=y


