Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267394AbSLSG4h>; Thu, 19 Dec 2002 01:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267509AbSLSG4h>; Thu, 19 Dec 2002 01:56:37 -0500
Received: from math.ut.ee ([193.40.5.125]:37520 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id <S267394AbSLSG4g>;
	Thu, 19 Dec 2002 01:56:36 -0500
Date: Thu, 19 Dec 2002 09:04:36 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: PPC: compile failure in 2.4.21-pre1 ide
Message-ID: <Pine.GSO.4.44.0212190858050.14294-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps this is known, but here it is anyway.

First, tens of these warnings:

In file included from /home/mroos/compile/linux-2.4/include/linux/modversions.h:127,
                 from /home/mroos/compile/linux-2.4/include/linux/module.h:21,
                 from printk.c:26:
/home/mroos/compile/linux-2.4/include/linux/modules/ide-iops.ver:37: warning: `__ver_eighty_ninty_three' redefined
/home/mroos/compile/linux-2.4/include/linux/modules/ide-features.ver:9: warning: this is the location of the previous definition
/home/mroos/compile/linux-2.4/include/linux/modules/ide-iops.ver:39: warning: `__ver_ide_ata66_check' redefined
/home/mroos/compile/linux-2.4/include/linux/modules/ide-features.ver:5: warning: this is the location of the previous definition
/home/mroos/compile/linux-2.4/include/linux/modules/ide-iops.ver:41: warning: `__ver_set_transfer' redefined
/home/mroos/compile/linux-2.4/include/linux/modules/ide-features.ver:7: warning: this is the location of the previous definition
/home/mroos/compile/linux-2.4/include/linux/modules/ide-iops.ver:43: warning: `__ver_ide_auto_reduce_xfer' redefined
/home/mroos/compile/linux-2.4/include/linux/modules/ide-features.ver:1: warning: this is the location of the previous definition
/home/mroos/compile/linux-2.4/include/linux/modules/ide-iops.ver:45: warning: `__ver_ide_driveid_update' redefined
/home/mroos/compile/linux-2.4/include/linux/modules/ide-features.ver:3: warning: this is the location of the previous definition
/home/mroos/compile/linux-2.4/include/linux/modules/ide-iops.ver:47: warning: `__ver_ide_config_drive_speed' redefined
/home/mroos/compile/linux-2.4/include/linux/modules/ide-features.ver:11: warning: this is the location of the previous definition

Then this:

ide-iops.c: In function `ide_mm_insw':
ide-iops.c:113: warning: implicit declaration of function `__ide_mm_insw'
ide-iops.c: In function `ide_mm_insl':
ide-iops.c:123: warning: implicit declaration of function `__ide_mm_insl'
ide-iops.c: In function `ide_mm_outsw':
ide-iops.c:138: warning: implicit declaration of function `__ide_mm_outsw'
ide-iops.c: In function `ide_mm_outsl':
ide-iops.c:148: warning: implicit declaration of function `__ide_mm_outsl'

And finally this:

drivers/ide/idedriver.o(.text+0x21a8): In function `ide_mm_insw':
: undefined reference to `__ide_mm_insw'
drivers/ide/idedriver.o(.text+0x21a8): In function `ide_mm_insw':
: relocation truncated to fit: R_PPC_REL24 __ide_mm_insw
drivers/ide/idedriver.o(.text+0x21d4): In function `ide_mm_insl':
: undefined reference to `__ide_mm_insl'
drivers/ide/idedriver.o(.text+0x21d4): In function `ide_mm_insl':
: relocation truncated to fit: R_PPC_REL24 __ide_mm_insl
drivers/ide/idedriver.o(.text+0x220c): In function `ide_mm_outsw':
: undefined reference to `__ide_mm_outsw'
drivers/ide/idedriver.o(.text+0x220c): In function `ide_mm_outsw':
: relocation truncated to fit: R_PPC_REL24 __ide_mm_outsw
drivers/ide/idedriver.o(.text+0x2238): In function `ide_mm_outsl':
: undefined reference to `__ide_mm_outsl'
drivers/ide/idedriver.o(.text+0x2238): In function `ide_mm_outsl':
: relocation truncated to fit: R_PPC_REL24 __ide_mm_outsl

-- 
Meelis Roos (mroos@linux.ee)

