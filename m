Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267198AbTBDJ5G>; Tue, 4 Feb 2003 04:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267208AbTBDJ5G>; Tue, 4 Feb 2003 04:57:06 -0500
Received: from math.ut.ee ([193.40.5.125]:12284 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id <S267198AbTBDJ5F>;
	Tue, 4 Feb 2003 04:57:05 -0500
Date: Tue, 4 Feb 2003 12:06:16 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.4-current: ndelay error on PPC
Message-ID: <Pine.GSO.4.44.0302041204450.4475-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.21-pre4+BK doesn't link on PPC: problems with ndelay.

ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/kernel/head.o arch/ppc/kernel/idle_6xx.o init/main.o init/version.o init/do_mounts.o \
	--start-group \
	arch/ppc/kernel/kernel.o arch/ppc/platforms/platform.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	 drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/macintosh/macintosh.o drivers/video/video.o drivers/media/media.o drivers/input/inputdrv.o \
	net/network.o \
	/home/mroos/compile/linux-2.4/lib/lib.a \
	--end-group \
	-o vmlinux
drivers/ide/idedriver.o(.text+0x3bc8): In function `ide_execute_command':
: undefined reference to `ndelay'
drivers/ide/idedriver.o(.text+0x3bc8): In function `ide_execute_command':
: relocation truncated to fit: R_PPC_REL24 ndelay
make: *** [vmlinux] Error 1

-- 
Meelis Roos (mroos@linux.ee)

