Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281964AbRKZSCb>; Mon, 26 Nov 2001 13:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281974AbRKZSCM>; Mon, 26 Nov 2001 13:02:12 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:51072 "EHLO
	c0mailgw13.prontomail.com") by vger.kernel.org with ESMTP
	id <S281964AbRKZSCE>; Mon, 26 Nov 2001 13:02:04 -0500
Message-ID: <3C028378.50CA616C@starband.net>
Date: Mon, 26 Nov 2001 13:01:28 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.16 Bug (PPC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bug still resides in 2.4.16 still, even after the PPC fixes that were
applied to 2.4.16-pre1.

If nobody cares about PPC updates, I guess I should put the box back on
the shelf.

The video driver (plat) is the framebuffer for a few macs, without it,
I cannot do anything.

Any plans to fix this?

//              default_vmode = nvram_read_byte(NV_VMODE);
//              default_cmode = nvram_read_byte(NV_CMODE);

Commenting the two undefined functions out in drivers/video/platinumfb.c
allows for a successful compile.
It also allows for the video driver to be brought up succesfully.

Now will this bug be fixed in 2.4.17 for PPC or should I just put my PPC
back on the shelf? :)

make[2]: Nothing to be done for `all_targets'.
make[2]: Leaving directory `/usr/src/linux/arch/ppc/lib'
make[1]: Leaving directory `/usr/src/linux/arch/ppc/lib'
ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic
arch/ppc/kernel/head.o init/main.o init/version.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/scsi/scsidrv.o
drivers/cdrom/driver.o drivers/pci/driver.o
drivers/macintosh/macintosh.o drivers/video/video.o \
        net/network.o \
        /usr/src/linux/lib/lib.a \
        --end-group \
        -o vmlinux
nm vmlinux | grep -v '\(compiled\)\|\(\.o$\)\|\( [aUw]
\)\|\(\.\.ng$\)\|\(LASH[RL]DI\)' | sort > System.map




make[2]: Leaving directory `/usr/src/linux/arch/ppc/lib'
make[1]: Leaving directory `/usr/src/linux/arch/ppc/lib'
ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic
arch/ppc/kernel/head.o init/main.o init/version.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/scsi/scsidrv.o
drivers/cdrom/driver.o drivers/pci/driver.o
drivers/macintosh/macintosh.o drivers/video/video.o \
        net/network.o \
        /usr/src/linux/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/video/video.o: In function `init_platinum':
drivers/video/video.o(.text.init+0x1350): undefined reference to
`nvram_read_byte'
drivers/video/video.o(.text.init+0x1350): relocation truncated to fit:
R_PPC_REL24 nvram_read_byte
drivers/video/video.o(.text.init+0x13d0): undefined reference to
`nvram_read_byte'
drivers/video/video.o(.text.init+0x13d0): relocation truncated to fit:
R_PPC_REL24 nvram_read_byte
make: *** [vmlinux] Error 1


