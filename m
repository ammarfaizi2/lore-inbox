Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265846AbUAKMMR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 07:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265851AbUAKMMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 07:12:17 -0500
Received: from smtp1.libero.it ([193.70.192.51]:59050 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S265846AbUAKMML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 07:12:11 -0500
From: "Mario ''Jorge'' Di Nitto" <jorge78@inwind.it>
To: linux-kernel@vger.kernel.org
Subject: 2.4.24 doesn't compile clearly...
Date: Sun, 11 Jan 2004 13:15:40 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401111315.40950.jorge78@inwind.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all.
I've download 2.4.24 and I patched it with ck1 and lm_sensor 2.8.2.
Make dep is ok,  but make bzImage gives:

ld -m elf_i386 -T /usr/src/linux-2.4.24/arch/i386/vmlinux.lds -e stext 
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
drivers/i2c/i2c.o drivers/sensors/sensor.o \
        net/network.o \
        /usr/src/linux-2.4.24/arch/i386/lib/lib.a /usr/src/linux-2.4.24/lib/lib.a /usr/src/linux-2.4.24/arch/i386/lib/lib.a 
\
        --end-group \
        -o vmlinux
drivers/char/drm/drm.o(.text+0x768e): In function `sis_fb_alloc':
: undefined reference to `sis_malloc'
drivers/char/drm/drm.o(.text+0x773f): In function `sis_fb_alloc':
: undefined reference to `sis_free'
drivers/char/drm/drm.o(.text+0x77a0): In function `sis_fb_free':
: undefined reference to `sis_free'
drivers/char/drm/drm.o(.text+0x7bef): In function `sis_final_context':
: undefined reference to `sis_free'
make: *** [vmlinux] Error 1

if I set sisfb as module.

D998:/usr/src/linux# grep -i sis .config
CONFIG_BLK_DEV_SIS5513=y
CONFIG_SIS900=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS645=m
CONFIG_SENSORS_SIS5595=m
CONFIG_AGP_SIS=y
CONFIG_DRM_SIS=y
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
D998:/usr/src/linux#

However, if I compile sisfb statically all works fine...
TIA,
				Jorge
PS: Sorry for lexical mistakes I made...

-- 
Il reggiseno e' uno strumento democratico perche' separa la destra dalla
sinistra, solleva le masse e attira i popoli.

