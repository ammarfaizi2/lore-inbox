Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbTEEQYd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263655AbTEEQYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:24:10 -0400
Received: from franka.aracnet.com ([216.99.193.44]:448 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263636AbTEEQXq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:23:46 -0400
Date: Mon, 05 May 2003 09:35:41 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 659] New: compile failure in
 drivers/media/radio/miropcm20-rds.c
Message-ID: <10320000.1052152541@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=659

           Summary: compile failure in drivers/media/radio/miropcm20-rds.c
    Kernel Version: 2.5.68-bk11
            Status: NEW
          Severity: low
             Owner: bugme-janitors@lists.osdl.org
         Submitter: john@larvalstage.com


Distribution:  Gentoo 1.4rc4
Hardware Environment:  Abit KG7-RAID, AMD AthlonXP 2100+ Palomino
Software Environment:  gcc 3.2.2, glibc 2.3.1, ld 2.13.90.0.18
Problem Description:

  gcc -Wp,-MD,drivers/media/radio/.miropcm20-rds.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
-DKBUILD_BASENAME=miropcm20_rds -DKBUILD_MODNAME=miropcm20_rds -c -o
drivers/media/radio/.tmp_miropcm20-rds.o drivers/media/radio/miropcm20-rds.c
drivers/media/radio/miropcm20-rds.c:23: warning: `struct inode' declared
inside parameter list
drivers/media/radio/miropcm20-rds.c:23: warning: its scope is only this
definition or declaration, which is probably not what you want
drivers/media/radio/miropcm20-rds.c:38: warning: `struct inode' declared
inside parameter list
drivers/media/radio/miropcm20-rds.c:106: variable `rds_fops' has
initializer but incomplete type
drivers/media/radio/miropcm20-rds.c:107: unknown field `owner' specified in
initializer
drivers/media/radio/miropcm20-rds.c:107: warning: excess elements in struct
initializer
drivers/media/radio/miropcm20-rds.c:107: warning: (near initialization for
`rds_fops')
drivers/media/radio/miropcm20-rds.c:108: unknown field `read' specified in
initializer
drivers/media/radio/miropcm20-rds.c:108: warning: excess elements in struct
initializer
drivers/media/radio/miropcm20-rds.c:108: warning: (near initialization for
`rds_fops')
drivers/media/radio/miropcm20-rds.c:109: unknown field `open' specified in
initializer
drivers/media/radio/miropcm20-rds.c:109: warning: excess elements in struct
initializer
drivers/media/radio/miropcm20-rds.c:109: warning: (near initialization for
`rds_fops')
drivers/media/radio/miropcm20-rds.c:110: unknown field `release' specified
in initializer
drivers/media/radio/miropcm20-rds.c:111: warning: excess elements in struct
initializer
drivers/media/radio/miropcm20-rds.c:111: warning: (near initialization for
`rds_fops')
drivers/media/radio/miropcm20-rds.c:106: storage size of `rds_fops' isn't
known make[3]: *** [drivers/media/radio/miropcm20-rds.o] Error 1
make[2]: *** [drivers/media/radio] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2


Steps to reproduce:

Multimedia devices  --->
Radio Adapters  --->
<*>   miroSOUND PCM20 radio RDS user interface (EXPERIMENTAL)

CONFIG_RADIO_MIROPCM20_RDS=y


