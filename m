Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUAKW1Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 17:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266001AbUAKW1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 17:27:24 -0500
Received: from smtp0.libero.it ([193.70.192.33]:43666 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S265999AbUAKW1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 17:27:19 -0500
From: "Mario ''Jorge'' Di Nitto" <jorge78@inwind.it>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.24 doesn't compile clearly...
Date: Sun, 11 Jan 2004 23:30:50 +0100
User-Agent: KMail/1.5.4
References: <200401111315.40950.jorge78@inwind.it> <20040111124804.GH545@alpha.home.local>
In-Reply-To: <20040111124804.GH545@alpha.home.local>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401112330.50255.jorge78@inwind.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 13:48, domenica 11 gennaio 2004, Willy Tarreau ha scritto:

Hi Willy,
> > Hi to all.
> > I've download 2.4.24 and I patched it with ck1 and lm_sensor 2.8.2.
>
> [...]
>
> > PS: Sorry for lexical mistakes I made...
>
> no lexical mistakes, but misleading information. It's not 2.4.24 which
> does not compile for you, but a patched 2.4.24. Your message is only
> relevant if you get the same error on plain 2.4.24.
>
> Willy

Now I've compiled a vanilla 2.4.24 and it breaks exactly like the one I 
patched: sisfb was compiled as module.


------ Vanilla -------- 
make[2]: Nothing to be done for `all_targets'.
make[2]: Leaving directory `/work/linux-2.4.24/drivers'
make[1]: Leaving directory `/work/linux-2.4.24/drivers'
ld -m elf_i386 -T /work/linux-2.4.24/arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o 
fs/fs.o ipc/ipc.o \
         drivers/acpi/acpi.o drivers/char/char.o drivers/block/block.o 
drivers/misc/misc.o drivers/net/net.o drivers/char/agp/agp.o 
drivers/char/drm/drm.o drivers/atm/atm.o drivers/ide/idedriver.o 
drivers/scsi/scsidrv.o drivers/ieee1394/ieee1394drv.o drivers/cdrom/driver.o 
drivers/pci/driver.o drivers/pcmcia/pcmcia.o drivers/net/pcmcia/pcmcia_net.o 
drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o 
drivers/media/media.o drivers/input/inputdrv.o drivers/message/i2o/i2o.o 
drivers/i2c/i2c.o \
        net/network.o \
        /work/linux-2.4.24/arch/i386/lib/lib.a /work/linux-2.4.24/lib/lib.a /work/linux-2.4.24/arch/i386/lib/lib.a 
\
        --end-group \
        -o vmlinux
drivers/char/drm/drm.o(.text+0x71be): In function `sis_fb_alloc':
: undefined reference to `sis_malloc'
drivers/char/drm/drm.o(.text+0x726f): In function `sis_fb_alloc':
: undefined reference to `sis_free'
drivers/char/drm/drm.o(.text+0x72d0): In function `sis_fb_free':
: undefined reference to `sis_free'
drivers/char/drm/drm.o(.text+0x771f): In function `sis_final_context':
: undefined reference to `sis_free'
make: *** [vmlinux] Error 1


Regards,
							Jorge

