Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267320AbTBKPwE>; Tue, 11 Feb 2003 10:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267322AbTBKPwD>; Tue, 11 Feb 2003 10:52:03 -0500
Received: from franka.aracnet.com ([216.99.193.44]:54925 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267320AbTBKPv5>; Tue, 11 Feb 2003 10:51:57 -0500
Date: Tue, 11 Feb 2003 08:01:37 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 337] New: build breakage for module versioning support 
Message-ID: <83000000.1044979297@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=337

           Summary: build breakage for module versioning support
    Kernel Version: 2.5.60, 2.5.60-bk1
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: john@larvalstage.com


Exact Kernel version:  2.5.60, 2.5.60-bk1
Distribution:  Gentoo 1.4rc2
Hardware Environment:  Abit KG7-RAID, AMD Athlon TBird 1.4, 512MB DDR,
Geforce 3 Software Environment:  gcc 3.2.1, glibc 2.3.1, ld 2.13.90.0.16
Problem Description:

Enabling module versioning support causes build breakage.

  gcc -Wp,-MD,arch/i386/kernel/.time.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
-DKBUILD_BASENAME=time -DKBUILD_MODNAME=time -c -o
arch/i386/kernel/.tmp_time.o arch/i386/kernel/time.c
ld:arch/i386/kernel/.tmp_time.ver:1: parse error
make[1]: *** [arch/i386/kernel/time.o] Error 1
make: *** [arch/i386/kernel] Error 2


Steps to reproduce:

CONFIG_MODVERSIONS=y

Loadable module support  --->
[*]   Module versioning support (EXPERIMENTAL)


