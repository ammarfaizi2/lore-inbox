Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTELOkC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 10:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbTELOkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 10:40:02 -0400
Received: from franka.aracnet.com ([216.99.193.44]:15043 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262123AbTELOkA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 10:40:00 -0400
Date: Mon, 12 May 2003 05:38:25 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 707] New: Compilation error of Initio9100 SCSI 
Message-ID: <21620000.1052743105@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=707

           Summary: Compilation error of Initio9100 SCSI
    Kernel Version: 2.5.69
            Status: NEW
          Severity: normal
             Owner: andmike@us.ibm.com
         Submitter: zawadaa@wp.pl


Distribution: PLD Linux Distribution
Hardware Environment:Mainboard Abit on VIA266
Software Environment: gcc version 3.2.3 (PLD Linux); glibc-2.3.2-2
Problem Description: Compilation error

LOG:

make -f scripts/Makefile.build obj=drivers/scsi
  gcc -Wp,-MD,drivers/scsi/.ini9100u.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default
-fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE  
-DKBUILD_BASENAME=ini9100u -DKBUILD_MODNAME=initio -c -o drivers/scsi/ini9100u.o
drivers/scsi/ini9100u.c
drivers/scsi/ini9100u.c:111:2: #error Please convert me to
Documentation/DMA-mapping.txt
drivers/scsi/ini9100u.c:144: unknown field `next' specified in initializer
drivers/scsi/ini9100u.c:144: warning: initialization from incompatible pointer type
drivers/scsi/ini9100u.c:144: warning: initialization from incompatible pointer type
drivers/scsi/ini9100u.c: In function `i91uAppendSRBToQueue':
drivers/scsi/ini9100u.c:226: structure has no member named `next'
drivers/scsi/ini9100u.c:231: structure has no member named `next'
drivers/scsi/ini9100u.c: In function `i91uPopSRBFromQueue':
drivers/scsi/ini9100u.c:253: structure has no member named `next'
drivers/scsi/ini9100u.c:254: structure has no member named `next'
drivers/scsi/ini9100u.c: In function `i91uBuildSCB':
drivers/scsi/ini9100u.c:492: structure has no member named `address'
drivers/scsi/ini9100u.c:501: structure has no member named `address'
make[2]: *** [drivers/scsi/ini9100u.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

