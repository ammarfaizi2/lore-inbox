Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293052AbSB1Ei4>; Wed, 27 Feb 2002 23:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293156AbSB1EhC>; Wed, 27 Feb 2002 23:37:02 -0500
Received: from [65.169.83.229] ([65.169.83.229]:32137 "EHLO
	hst000004380um.kincannon.olemiss.edu") by vger.kernel.org with ESMTP
	id <S293135AbSB1Ef3>; Wed, 27 Feb 2002 23:35:29 -0500
Date: Wed, 27 Feb 2002 22:34:41 -0600
From: Benjamin Pharr <ben@benpharr.com>
To: linux-kernel@vger.kernel.org
Subject: .text problems in 2.5.6-pre1
Message-ID: <20020228043441.GA32149@hst000004380um.kincannon.olemiss.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.19pre1
X-PGP-ID: 0x6859792C
X-PGP-Key: http://www.benpharr.com/public_key.asc
X-PGP-Fingerprint: 7BF0 E432 3365 C1FC E0E3  0BE2 44E1 3E1E 6859 792C
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I saw a couple of mentions in the changelog that the .text problem had
been fixed in this version. However, I found this one while compiling:



--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=error_log

make[2]: Leaving directory `/usr/src/linux-2.5.6-pre1/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux-2.5.6-pre1/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux-2.5.6-pre1/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	/usr/src/linux-2.5.6-pre1/arch/i386/lib/lib.a /usr/src/linux-2.5.6-pre1/lib/lib.a /usr/src/linux-2.5.6-pre1/arch/i386/lib/lib.a \
	 drivers/base/base.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/cdrom/driver.o sound/sound.o drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o \
	net/network.o \
	--end-group \
	-o vmlinux
drivers/char/drm/drm.o: In function `i810_dma_initialize':
drivers/char/drm/drm.o(.text+0x1dc19): undefined reference to `virt_to_bus_not_defined_use_pci_map'
make: *** [vmlinux] Error 1


--Nq2Wo0NMKNjxTN9z--
