Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316190AbSEKBrJ>; Fri, 10 May 2002 21:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316191AbSEKBrI>; Fri, 10 May 2002 21:47:08 -0400
Received: from mx1.fuse.net ([216.68.2.90]:27335 "EHLO mta01.fuse.net")
	by vger.kernel.org with ESMTP id <S316190AbSEKBrI>;
	Fri, 10 May 2002 21:47:08 -0400
Message-ID: <3CDC783B.7040700@fuse.net>
Date: Fri, 10 May 2002 21:47:39 -0400
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020502 Debian/1.0rc1-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: AIC7XXX build broken in 2.5.15+Kbuild?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using Kbuild-2.5 core 12, common against 2.5.15-1, i386 against 
2.5.15-1, and some ACPI fixups in arch/i386/{pci,kernel}/Makefile.in to 
make their latest patch work.

It doesn't build with "make -f Makefile-2.5" and trying to specify it 
manually gives:

$ make -f Makefile-2.5 drivers/scsi/aic7xxx/aic7xxx_core.o
Using ARCH='i386' AS='as' LD='ld' CC='/usr/bin/gcc' CPP='/usr/bin/gcc 
-E' AR='ar' HOSTAS='as' HOSTLD='gcc' HOSTCC='gcc' HOSTAR='ar'
Generating global Makefile
  phase 1 (find all inputs)
  phase 2 (convert all Makefile.in files)
  phase 3 (evaluate selections)
  phase 4 (integrity checks, write global makefile)
Starting phase 5 (build) for drivers/scsi/aic7xxx/aic7xxx_core.o
make[1]: Nothing to be done for `drivers/scsi/aic7xxx/aic7xxx_core.o'.
Phase 5 complete for drivers/scsi/aic7xxx/aic7xxx_core.o

Relevant configs:

CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set

The build system *does* get all the sr_mod, sd_mod, etc. files.

Help!

--Nathan


