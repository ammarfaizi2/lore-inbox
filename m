Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285291AbRLFXTS>; Thu, 6 Dec 2001 18:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285293AbRLFXTJ>; Thu, 6 Dec 2001 18:19:09 -0500
Received: from oyster.morinfr.org ([62.4.22.234]:13725 "EHLO
	oyster.morinfr.org") by vger.kernel.org with ESMTP
	id <S285291AbRLFXS6>; Thu, 6 Dec 2001 18:18:58 -0500
Date: Fri, 7 Dec 2001 00:18:52 +0100
From: Guillaume Morin <guillaume@morinfr.org>
To: Will Dyson <will_dyson@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: link error in usbdrv.o (2.4.17-pre5)
Message-ID: <20011206231852.GA13367@morinfr.org>
Mail-Followup-To: Will Dyson <will_dyson@pobox.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C0FFACF.4060806@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3C0FFACF.4060806@pobox.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dans un message du 06 déc à 18:10, Will Dyson écrivait :
> ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext 
> arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
> init/version.o \
> 	--start-group \
> 	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o 
> fs/fs.o ipc/ipc.o \
> 	 drivers/char/char.o drivers/block/block.o drivers/misc/misc.o 
> drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o 
> drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o 
> drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o 
> drivers/usb/usbdrv.o drivers/input/inputdrv.o drivers/i2c/i2c.o \
> 	net/network.o \
> 	/usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a 
> /usr/src/linux/arch/i386/lib/lib.a \
> 	--end-group \
> 	-o vmlinux
> drivers/usb/usbdrv.o(.text.lock+0x5dc): undefined reference to `local 
> symbols in discarded section .text.exit'

Are you running Debian unstable ? I had the same problem with latest
binutils. Downgrading fixed the problem.

-- 
Guillaume Morin <guillaume@morinfr.org>

                       Sauvez un arbre, mangez un castor
