Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284254AbRLMPb6>; Thu, 13 Dec 2001 10:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284280AbRLMPbt>; Thu, 13 Dec 2001 10:31:49 -0500
Received: from zeus.kernel.org ([204.152.189.113]:57586 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S284258AbRLMPbk>;
	Thu, 13 Dec 2001 10:31:40 -0500
Subject: TUX 2
From: Paulo Schreiner <paulo@bewnet.com.br>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99 (Preview Release)
Date: 13 Dec 2001 10:27:54 -0200
Message-Id: <1008246475.874.11.camel@gandalf>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, folks, i just downloaded the 2.4.16 kernel and applied the latest
tux2 patch (tux2-full-2.4.16-final-D1.bz2), but the kernel does not
compile.
I get the following error:

ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/parport/driver.o drivers/char/char.o
drivers/block/block.o drivers/misc/misc.o drivers/net/net.o
drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o
drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o
drivers/sound/sounddrivers.o drivers/pci/driver.o
drivers/pcmcia/pcmcia.o drivers/net/pcmcia/pcmcia_net.o
drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
net/network.o: In function `_tr_flush_block':
net/network.o(.text+0x45810): multiple definition of `_tr_flush_block'
drivers/net/net.o(.text+0x9dd0): first defined here
net/network.o: In function `_tr_stored_type_only':
net/network.o(.text+0x45510): multiple definition of
`_tr_stored_type_only'
drivers/net/net.o(.text+0x9ad0): first defined here
net/network.o: In function `_tr_stored_block':
net/network.o(.text+0x45460): multiple definition of `_tr_stored_block'
drivers/net/net.o(.text+0x9a20): first defined here
net/network.o(.data+0x49c0): multiple definition of `deflate_copyright'
drivers/net/net.o(.data+0xe80): first defined here
net/network.o: In function `_tr_init':
net/network.o(.text+0x443a0): multiple definition of `_tr_init'
drivers/net/net.o(.text+0x8960): first defined here
net/network.o: In function `_tr_tally':
net/network.o(.text+0x45a60): multiple definition of `_tr_tally'
drivers/net/net.o(.text+0xa020): first defined here
net/network.o: In function `_tr_align':
net/network.o(.text+0x45590): multiple definition of `_tr_align'
drivers/net/net.o(.text+0x9b50): first defined here
make: *** [vmlinux] Error 1

Any help will be GREATLY appreciated.
I am currently running slackware 8.0 with linux 2.4.15-pre2 with ext3
filesystems.

Paulo Schreiner

