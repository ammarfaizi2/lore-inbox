Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267319AbTBKPvT>; Tue, 11 Feb 2003 10:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267320AbTBKPvT>; Tue, 11 Feb 2003 10:51:19 -0500
Received: from franka.aracnet.com ([216.99.193.44]:46988 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267319AbTBKPvS>; Tue, 11 Feb 2003 10:51:18 -0500
Date: Tue, 11 Feb 2003 08:01:00 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 338] New: compile failure in drivers/block/cciss_scsi.c
Message-ID: <82870000.1044979260@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=338

           Summary: compile failure in drivers/block/cciss_scsi.c
    Kernel Version: 2.5.60-bk1
            Status: NEW
          Severity: normal
             Owner: andmike@us.ibm.com
         Submitter: john@larvalstage.com


Distribution:  Gentoo 1.4rc2
Hardware Environment:  Abit KG7-RAID, AMD Athlon TBird 1.4, 512MB DDR,
Geforce 3 Software Environment:  gcc 3.2.1, glibc 2.3.1, ld 2.13.90.0.16
Problem Description:

  gcc -Wp,-MD,drivers/block/.cciss.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
-DKBUILD_BASENAME=cciss -DKBUILD_MODNAME=cciss -c -o drivers/block/cciss.o
drivers/block/cciss.c
In file included from drivers/block/cciss.c:136:
drivers/block/cciss_scsi.c: In function `cciss_scsi_proc_info':
drivers/block/cciss_scsi.c:1265: warning: unused variable `found'
In file included from drivers/block/cciss.c:136:
drivers/block/cciss_scsi.c: In function `cciss_scsi_queue_command':
drivers/block/cciss_scsi.c:1382: structure has no member named `host'
drivers/block/cciss_scsi.c:1385: structure has no member named `channel'
drivers/block/cciss_scsi.c:1385: structure has no member named `target'
drivers/block/cciss_scsi.c:1385: structure has no member named `lun'
make[2]: *** [drivers/block/cciss.o] Error 1
make[1]: *** [drivers/block] Error 2
make: *** [drivers] Error 2


Steps to reproduce:

CONFIG_BLK_CPQ_CISS_DA=y

Block devices  --->
<*> Compaq Smart Array 5xxx suppor

