Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267431AbTBNUbB>; Fri, 14 Feb 2003 15:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267432AbTBNUaY>; Fri, 14 Feb 2003 15:30:24 -0500
Received: from [81.2.122.30] ([81.2.122.30]:4104 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267431AbTBNUaJ>;
	Fri, 14 Feb 2003 15:30:09 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302142041.h1EKfF2x001173@darkstar.example.net>
Subject: Sparc IDE in 2.4.20
To: linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2003 20:41:15 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is IDE known to be broken on Sparc in 2.4.20?  I just got this compile
failiure:

make[1]: Leaving directory `/usr/src/linux-2.4.20/arch/sparc/boot'
sparc-linux-ld -T arch/sparc/vmlinux.lds arch/sparc/kernel/head.o arch/sparc/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/sparc/kernel/kernel.o arch/sparc/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/sparc/math-emu/math-emu.o arch/sparc/boot/btfix.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/pci/driver.o drivers/sbus/sbus_all.o drivers/video/video.o \
        net/network.o \
        /usr/src/linux-2.4.20/lib/lib.a /usr/src/linux-2.4.20/lib/lib.a /usr/src/linux-2.4.20/arch/sparc/prom/promlib.a /usr/src/linux-2.4.20/arch/sparc/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/ide/idedriver.o: In function `ide_end_drive_cmd':
drivers/ide/idedriver.o(.text+0x11d4): undefined reference to `inw_p'
make: *** [vmlinux] Error 1

John.
