Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274681AbRJTWLv>; Sat, 20 Oct 2001 18:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274684AbRJTWLm>; Sat, 20 Oct 2001 18:11:42 -0400
Received: from protactinium.btinternet.com ([194.73.73.176]:52664 "EHLO
	protactinium") by vger.kernel.org with ESMTP id <S274681AbRJTWL1>;
	Sat, 20 Oct 2001 18:11:27 -0400
Date: Sat, 20 Oct 2001 23:11:31 +0000
To: linux-kernel@vger.kernel.org
Subject: Compilation of 2.4.0 fails when processing /i386/boot
Message-ID: <20011020231131.A4560@ubersecksie.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
From: Stuart Luscombe <stuart@ubersecksie.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am compiling kernel 2.4.0, and I am getting the following error
during the 'make install' part of the build:

ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o  drivers/parport/driver.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
nm vmlinux | grep -v '\(compiled\)\|\(\.o$\)\|\( [aUw] \)\|\(\.\.ng$\)\|\(LASH[RL]DI\)' | sort > System.map
make[1]: Entering directory `/usr/src/linux/arch/i386/boot'
ld -m elf_i386 -Ttext 0x0 -s -oformat binary bbootsect.o -o bbootsect
make[1]: Leaving directory `/usr/src/linux/arch/i386/boot'
ld: cannot open binary: No such file or directory
make[1]: *** [bbootsect] Error 1
make: *** [install] Error 2

I have checked all assembler packages, and they all seem to be installed.
I am running Debian sid and all packages are up-to-date.

Can anyone help me with this error?

Thanks in advance
--
Stuart
