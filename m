Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263843AbTDIV5V (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 17:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263848AbTDIV5V (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 17:57:21 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:27894 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263843AbTDIV5T (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 17:57:19 -0400
Date: Wed, 09 Apr 2003 14:58:51 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 567] New: compile failure in drivers/i2c/scx200_i2c.c 
Message-ID: <14290000.1049925531@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=567

           Summary: compile failure in drivers/i2c/scx200_i2c.c
    Kernel Version: 2.5.67
            Status: NEW
          Severity: low
             Owner: greg@kroah.com
         Submitter: john@larvalstage.com


Distribution:  Gentoo 1.4rc2
Hardware Environment:  Abit KG7-RAID, AMD AthlonXP 2100+, 512MB DDR
Software Environment:  gcc 3.2.2, glibc 2.3.1, ld 2.13.90.0.18
Problem Description:

  gcc -Wp,-MD,drivers/i2c/.scx200_i2c.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=scx200_i2c
-DKBUILD_MODNAME=scx200_i2c -c -o drivers/i2c/.tmp_scx200_i2c.o
drivers/i2c/scx200_i2c.c
drivers/i2c/scx200_i2c.c:85: unknown field `name' specified in initializer
drivers/i2c/scx200_i2c.c:85: warning: initialization makes integer from pointer
without a cast
drivers/i2c/scx200_i2c.c: In function `scx200_i2c_init':
drivers/i2c/scx200_i2c.c:113: structure has no member named `name'
make[2]: *** [drivers/i2c/scx200_i2c.o] Error 1
make[1]: *** [drivers/i2c] Error 2
make: *** [drivers] Error 2


Steps to reproduce:

Character devices  --->
I2C support  --->
<*>     NatSemi SCx200 I2C using GPIO pins

CONFIG_SCx200_I2C=y


