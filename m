Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263658AbTEEQ07 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263660AbTEEQ0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:26:38 -0400
Received: from franka.aracnet.com ([216.99.193.44]:50371 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263658AbTEEQZi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:25:38 -0400
Date: Mon, 05 May 2003 09:37:35 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 658] New: compile failure in drivers/video/aty/mach64_gx.c
Message-ID: <10680000.1052152655@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=658

           Summary: compile failure in drivers/video/aty/mach64_gx.c
    Kernel Version: 2.5.68-bk11
            Status: NEW
          Severity: low
             Owner: jsimmons@infradead.org
         Submitter: john@larvalstage.com


Distribution:  Gentoo 1.4rc4
Hardware Environment:  Abit KG7-RAID, AMD AthlonXP 2100+ Palomino
Software Environment:  gcc 3.2.2, glibc 2.3.1, ld 2.13.90.0.18
Problem Description:

  gcc -Wp,-MD,drivers/video/aty/.mach64_gx.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
-DKBUILD_BASENAME=mach64_gx
-DKBUILD_MODNAME=atyfb -c -o drivers/video/aty/.tmp_mach64_gx.o
drivers/video/aty/mach64_gx.c
drivers/video/aty/mach64_gx.c:497: redefinition of `vclk_per'
drivers/video/aty/mach64_gx.c:496: `vclk_per' previously declared here
drivers/video/aty/mach64_gx.c: In function `aty_var_to_pll_1703':
drivers/video/aty/mach64_gx.c:496: redeclaration of `vclk_per'
drivers/video/aty/mach64_gx.c:497: `vclk_per' previously declared here
drivers/video/aty/mach64_gx.c: At top level:
drivers/video/aty/mach64_gx.c:602: warning: initialization from incompatible
pointer type
drivers/video/aty/mach64_gx.c:613: redefinition of `vclk_per'
drivers/video/aty/mach64_gx.c:612: `vclk_per' previously declared here
drivers/video/aty/mach64_gx.c: In function `aty_var_to_pll_8398':
drivers/video/aty/mach64_gx.c:612: redeclaration of `vclk_per'
drivers/video/aty/mach64_gx.c:613: `vclk_per' previously declared here
drivers/video/aty/mach64_gx.c: At top level:
drivers/video/aty/mach64_gx.c:726: warning: initialization from incompatible
pointer type
make[3]: *** [drivers/video/aty/mach64_gx.o] Error 1
make[2]: *** [drivers/video/aty] Error 2
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2


Steps to reproduce:

Graphics support  --->
[*]     Mach64 GX support

CONFIG_FB_ATY_GX=y

