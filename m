Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267826AbTAHPeu>; Wed, 8 Jan 2003 10:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267827AbTAHPeu>; Wed, 8 Jan 2003 10:34:50 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:54026 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S267826AbTAHPet>; Wed, 8 Jan 2003 10:34:49 -0500
Date: Wed, 8 Jan 2003 10:43:30 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@oddball.prodigy.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.5.54 aha152x won't compile
Message-ID: <Pine.LNX.4.44.0301081028250.18364-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Judging by the number of these I'm seeing there has been another major 
change somewhere requiring fixing many modules. Why do we even pretend 
there's a feature freeze when major changes are still coming in? 


  gcc -Wp,-MD,drivers/scsi/.sr_vendor.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=sr_vendor -DKBUILD_MODNAME=sr_mod   -c -o drivers/scsi/sr_vendor.o drivers/scsi/sr_vendor.c
  ld -m elf_i386  -r -o drivers/scsi/scsi_mod.ko drivers/scsi/scsi.o drivers/scsi/hosts.o drivers/scsi/scsi_ioctl.o drivers/scsi/constants.o drivers/scsi/scsicam.o drivers/scsi/scsi_error.o drivers/scsi/scsi_lib.o drivers/scsi/scsi_scan.o drivers/scsi/scsi_syms.o drivers/scsi/scsi_sysfs.o drivers/scsi/scsi_proc.o
  gcc -Wp,-MD,drivers/scsi/.aha152x.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE  -DAHA152X_STAT -DAUTOCONF -DKBUILD_BASENAME=aha152x -DKBUILD_MODNAME=aha152x   -c -o drivers/scsi/aha152x.o drivers/scsi/aha152x.c
drivers/scsi/aha152x.c: In function `aha152x_detect':
drivers/scsi/aha152x.c:1131: warning: implicit declaration of function `isapnp_find_dev'
drivers/scsi/aha152x.c:1131: warning: assignment makes pointer from integer without a cast
drivers/scsi/aha152x.c:1132: structure has no member named `prepare'
drivers/scsi/aha152x.c:1134: structure has no member named `active'
drivers/scsi/aha152x.c:1139: structure has no member named `activate'
drivers/scsi/aha152x.c:1142: structure has no member named `deactivate'
drivers/scsi/aha152x.c: In function `aha152x_release':
drivers/scsi/aha152x.c:1424: structure has no member named `deactivate'
make[2]: *** [drivers/scsi/aha152x.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

