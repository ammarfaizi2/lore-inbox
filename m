Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbTEWTVX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 15:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264153AbTEWTVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 15:21:23 -0400
Received: from mail0.ewetel.de ([212.6.122.10]:61825 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S264151AbTEWTVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 15:21:20 -0400
Date: Fri, 23 May 2003 21:34:25 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc3 link error: wolfson_init
Message-ID: <Pine.LNX.4.44.0305232133130.7577-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Got the following link error with a config that worked just fine
for 2.4.21-rc2:

ld -m elf_i386 -T /home/kernel/linux-2.4/arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o 
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/parport/driver.o drivers/char/char.o 
drivers/block/block.o drivers/misc/misc.o drivers/net/net.o 
drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o 
drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o 
drivers/pci/driver.o drivers/video/video.o drivers/usb/usbdrv.o 
drivers/media/media.o drivers/input/inputdrv.o \
        net/network.o \
        /home/kernel/linux-2.4/arch/i386/lib/lib.a 
/home/kernel/linux-2.4/lib/lib.a 
/home/kernel/linux-2.4/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/sound/sounddrivers.o(.data+0x210): undefined reference to 
`wolfson_init05'
drivers/sound/sounddrivers.o(.data+0x21c): undefined reference to 
`wolfson_init11'
make: *** [vmlinux] Error 1

-- 
Ciao,
Pascal

