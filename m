Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291450AbSBNKfa>; Thu, 14 Feb 2002 05:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291436AbSBNKfN>; Thu, 14 Feb 2002 05:35:13 -0500
Received: from 213-97-45-174.uc.nombres.ttd.es ([213.97.45.174]:36880 "EHLO
	pau.intranet.ct") by vger.kernel.org with ESMTP id <S291423AbSBNKex>;
	Thu, 14 Feb 2002 05:34:53 -0500
Date: Thu, 14 Feb 2002 11:34:46 +0100 (CET)
From: Pau Aliagas <linuxnow@wanadoo.es>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
Subject: error linking 2.5.5-pre1
Message-ID: <Pine.LNX.4.44.0202141134150.1622-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ld -m elf_i386 -T /home/pau/LnxZip/RPM/BUILD/kernel-2.5.5pre1/arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
init/version.o init/do_mounts.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o 
mm/mm.o fs/fs.o ipc/ipc.o \
	/home/pau/LnxZip/RPM/BUILD/kernel-2.5.5pre1/arch/i386/lib/lib.a 
/home/pau/LnxZip/RPM/BUILD/kernel-2.5.5pre1/lib/lib.a 
/home/pau/LnxZip/RPM/BUILD/kernel-2.5.5pre1/arch/i386/lib/lib.a \
	 drivers/base/base.o drivers/char/char.o drivers/block/block.o 
drivers/misc/misc.o drivers/net/net.o drivers/media/media.o 
drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/cdrom/driver.o 
drivers/pci/driver.o drivers/pcmcia/pcmcia.o 
drivers/net/pcmcia/pcmcia_net.o drivers/video/video.o drivers/md/mddev.o \
	net/network.o \
	--end-group \
	-o vmlinux
drivers/video/video.o: In function `vesafb_init':
drivers/video/video.o(.text.init+0x151b): undefined reference to 
`bus_to_virt_not_defined_use_pci_map'
make[1]: *** [vmlinux] Error 1
make[1]: Leaving directory `/home/pau/LnxZip/RPM/BUILD/kernel-2.5.5pre1'
error: Bad exit status from /home/pau/LnxZip/tmp/rpm-tmp.34494 (%build)


Pau

