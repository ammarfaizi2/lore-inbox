Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285280AbRLFXKs>; Thu, 6 Dec 2001 18:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285281AbRLFXK3>; Thu, 6 Dec 2001 18:10:29 -0500
Received: from cn129399-a.wall1.pa.home.com ([24.40.41.32]:19585 "EHLO dysonwi")
	by vger.kernel.org with ESMTP id <S285280AbRLFXKQ>;
	Thu, 6 Dec 2001 18:10:16 -0500
Message-ID: <3C0FFACF.4060806@pobox.com>
Date: Thu, 06 Dec 2001 18:10:07 -0500
From: Will Dyson <will_dyson@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011202
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: link error in usbdrv.o (2.4.17-pre5)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling 2.4.17-pre5 with the usb compiled in, the final link 
produces the following error:


ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
init/version.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o 
fs/fs.o ipc/ipc.o \
	 drivers/char/char.o drivers/block/block.o drivers/misc/misc.o 
drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o 
drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o 
drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o 
drivers/usb/usbdrv.o drivers/input/inputdrv.o drivers/i2c/i2c.o \
	net/network.o \
	/usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a 
/usr/src/linux/arch/i386/lib/lib.a \
	--end-group \
	-o vmlinux
drivers/usb/usbdrv.o(.text.lock+0x5dc): undefined reference to `local 
symbols in discarded section .text.exit'

The .config that produces this error can be found here: 
<http://cs.earlham.edu/~will/err_config>

-- 
Will Dyson

