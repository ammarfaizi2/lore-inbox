Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272988AbTHFATs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 20:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272991AbTHFATr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 20:19:47 -0400
Received: from janus1.ktb.net ([198.175.228.34]:40464 "EHLO janus1.ktb.net")
	by vger.kernel.org with ESMTP id S272988AbTHFATq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 20:19:46 -0400
Message-ID: <3F30499F.708@hsdm.com>
Date: Tue, 05 Aug 2003 17:19:43 -0700
From: hsdm <hsdm@hsdm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem cmopiling kernel version 2.4.21
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I configured my kernel using make xconfig and ran make: I got these 
error messages at the end:


make[1]: Leaving directory `/root/linux-2.4.21/arch/i386/lib'
ld -m elf_i386 -T /root/linux-2.4.21/arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
init/version.o init/do_mounts.o \
       --start-group \
       arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o 
mm/mm.o fs/fs.o ipc/ipc.o \
        drivers/parport/driver.o drivers/char/char.o 
drivers/block/block.o drivers/misc/misc.o drivers/net/net.o 
drivers/char/agp/agp.o drivers/char/drm/drm.o
drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o 
drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/pnp/pnp.o 
drivers/video/video.o
drivers/block/paride/paride.a drivers/usb/usbdrv.o drivers/media/media.o 
drivers/input/inputdrv.o \
       net/network.o \
       /root/linux-2.4.21/arch/i386/lib/lib.a 
/root/linux-2.4.21/lib/lib.a /root/linux-2.4.21/arch/i386/lib/lib.a \
       --end-group \
       -o vmlinux
drivers/char/drm/drm.o(.text+0x18328): In function `sis_fb_alloc':
: undefined reference to `sis_malloc'
drivers/char/drm/drm.o(.text+0x183d6): In function `sis_fb_alloc':
: undefined reference to `sis_free'
drivers/char/drm/drm.o(.text+0x18449): In function `sis_fb_free':
: undefined reference to `sis_free'
drivers/char/drm/drm.o(.text+0x1887f): In function `sis_final_context':
: undefined reference to `sis_free'
make: *** [vmlinux] Error 1
[root@server linux-2.4.21]#


