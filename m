Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287565AbSBIVDP>; Sat, 9 Feb 2002 16:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287563AbSBIVDF>; Sat, 9 Feb 2002 16:03:05 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:28646 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S287565AbSBIVCv>; Sat, 9 Feb 2002 16:02:51 -0500
Message-ID: <3C658EC2.158C2B2C@oracle.com>
Date: Sat, 09 Feb 2002 22:04:02 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.4-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.4-pre5 fails to build (sounddrivers.o/pcmcia_net.o)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[1]: Leaving directory `/usr/src/linux-2.5.4-pre5/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux-2.5.4-pre5/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	/usr/src/linux-2.5.4-pre5/arch/i386/lib/lib.a /usr/src/linux-2.5.4-pre5/lib/lib.a /usr/src/linux-2.5.4-pre5/arch/i386/lib/lib.a \
	 drivers/base/base.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/pcmcia/pcmcia.o drivers/net/pcmcia/pcmcia_net.o drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o
drivers/input/serio/seriodrv.o \
	net/network.o \
	--end-group \
	-o vmlinux
drivers/sound/sounddrivers.o: In function `m3_play_setup':
drivers/sound/sounddrivers.o(.text+0xf4e): undefined reference to `virt_to_bus_not_defined_use_pci_map'
drivers/sound/sounddrivers.o(.text+0xf6e): undefined reference to `virt_to_bus_not_defined_use_pci_map'
drivers/sound/sounddrivers.o(.text+0xf93): undefined reference to `virt_to_bus_not_defined_use_pci_map'
drivers/sound/sounddrivers.o(.text+0xfb7): undefined reference to `virt_to_bus_not_defined_use_pci_map'
drivers/sound/sounddrivers.o(.text+0xfde): undefined reference to `virt_to_bus_not_defined_use_pci_map'
drivers/sound/sounddrivers.o(.text+0x1000): more undefined references to `virt_to_bus_not_defined_use_pci_map' follow
drivers/net/pcmcia/pcmcia_net.o: In function `xircom_rx':
drivers/net/pcmcia/pcmcia_net.o(.text+0x1801): undefined reference to `bus_to_virt_not_defined_use_pci_map'
drivers/net/pcmcia/pcmcia_net.o(.text+0x19a2): undefined reference to `virt_to_bus_not_defined_use_pci_map'
drivers/net/pcmcia/pcmcia_net.o: In function `set_rx_mode':
drivers/net/pcmcia/pcmcia_net.o(.text+0x22d4): undefined reference to `virt_to_bus_not_defined_use_pci_map'
make: *** [vmlinux] Error 1

--alessandro

 "If your heart is a flame burning brightly
   you'll have light and you'll never be cold
  And soon you will know that you just grow / You're not growing old"
                              (Husker Du, "Flexible Flyer")
