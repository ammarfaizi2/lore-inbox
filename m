Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129375AbRAXWtE>; Wed, 24 Jan 2001 17:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRAXWsp>; Wed, 24 Jan 2001 17:48:45 -0500
Received: from moon.aladdin.de ([212.14.90.34]:1035 "EHLO moon.aladdin.de")
	by vger.kernel.org with ESMTP id <S129375AbRAXWsi>;
	Wed, 24 Jan 2001 17:48:38 -0500
Subject: final problem pre10 & ppc
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.1a (Intl) 17 August 1999
Message-ID: <OFAFDDFCB2.EC6DCCC7-ONC12569DE.007D2CF7@aladdin.de>
From: cpg@aladdin.de
Date: Wed, 24 Jan 2001 23:42:52 +0100
X-MIMETrack: Serialize by Router on Moon/MUC/AKS(Release 5.0.5 |September 22, 2000) at
 01/24/2001 11:49:24 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when linking....

ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/kernel/head.o init/main.o
init/version.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o
ipc/ipc.o arch/ppc/xmon/x.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o drivers/net/net.o
drivers/media/media.o  drivers/net/appletalk/appletalk.o drivers/ide/idedriver.o
drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o
drivers/macintosh/macintosh.o drivers/video/video.o drivers/usb/usbdrv.o \
        net/network.o \
        /usr/src/linux/lib/lib.a \
        --end-group \
        -o vmlinux
arch/ppc/kernel/kernel.o: In function `pmac_ide_default_irq':
arch/ppc/kernel/kernel.o(.text+0xa154): undefined reference to `pmac_ide_get_irq'
arch/ppc/kernel/kernel.o(.text+0xa154): relocation truncated to fit: R_PPC_REL24 pmac_ide_get_irq
drivers/macintosh/macintosh.o: In function `powerbook_sleep_G3':
drivers/macintosh/macintosh.o(.text.openfirmware+0x1b90): undefined reference to
`grackle_pcibios_read_config_word'
drivers/macintosh/macintosh.o(.text.openfirmware+0x1b90): relocation truncated to fit: R_PPC_REL24
grackle_pcibios_read_config_word
drivers/macintosh/macintosh.o(.text.openfirmware+0x1bb4): undefined reference to
`grackle_pcibios_write_config_word'
drivers/macintosh/macintosh.o(.text.openfirmware+0x1bb4): relocation truncated to fit: R_PPC_REL24
grackle_pcibios_write_config_word
drivers/macintosh/macintosh.o(.text.openfirmware+0x1bcc): undefined reference to
`grackle_pcibios_read_config_word'
drivers/macintosh/macintosh.o(.text.openfirmware+0x1bcc): relocation truncated to fit: R_PPC_REL24
grackle_pcibios_read_config_word
drivers/macintosh/macintosh.o(.text.openfirmware+0x1bec): undefined reference to
`grackle_pcibios_write_config_word'
drivers/macintosh/macintosh.o(.text.openfirmware+0x1bec): relocation truncated to fit: R_PPC_REL24
grackle_pcibios_write_config_word
make: *** [vmlinux] Error 1

sigh...

regards,
chris


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
