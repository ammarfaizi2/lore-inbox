Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131023AbQLaDGc>; Sat, 30 Dec 2000 22:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135519AbQLaDGW>; Sat, 30 Dec 2000 22:06:22 -0500
Received: from [213.166.15.20] ([213.166.15.20]:52237 "EHLO mail.fsbdial.co.uk")
	by vger.kernel.org with ESMTP id <S131023AbQLaDGT>;
	Sat, 30 Dec 2000 22:06:19 -0500
Message-ID: <3A4E9B70.574B1A51@FreeNet.co.uk>
Date: Sun, 31 Dec 2000 02:35:28 +0000
From: Sid Boyce <sidb@FreeNet.co.uk>
Reply-To: sidb@FreeNet.co.uk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: test13-pre4-ac2/test13-pre7 ax25 undefined reference
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The problem showed up on the stroke of test13-pre4-ac2 and stuff from
Alan has been merged in. I went from pre4-ac2 to pre5 (AOK) and now
attempting pre7.......

ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel
/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/f
s.o ipc/ipc.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers/ne
t/net.o drivers/media/media.o  drivers/ide/idedriver.o
drivers/scsi/scsidrv.o dr
ivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o
drivers/p
np/pnp.o drivers/video/video.o drivers/net/hamradio/hamradio.o
drivers/usb/usbdr
v.o drivers/acpi/acpi.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/lin
ux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/net/net.o: In function `network_ldisc_init':
drivers/net/net.o(.text.init+0x141): undefined reference to
`mkiss_init_ctrl_dev
'
make: *** [vmlinux] Error 1

Regards
-- 
Sid Boyce ... hamradio G3VBV ... Cessna/Warrior Pilot
Linux only shop.. Tel. 44-121 422 0375
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
