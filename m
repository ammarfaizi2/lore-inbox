Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268889AbRHFVPK>; Mon, 6 Aug 2001 17:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268941AbRHFVOv>; Mon, 6 Aug 2001 17:14:51 -0400
Received: from smtprt16.wanadoo.fr ([193.252.19.183]:51846 "EHLO
	smtprt16.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S268889AbRHFVOk>; Mon, 6 Aug 2001 17:14:40 -0400
Message-Id: <5.1.0.14.2.20010806231341.00aa7580@pop.wanadoo.fr>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 06 Aug 2001 23:17:05 +0200
To: Gregoire Favre <greg@ulima.unil.ch>
From: eddantes@wanadoo.fr
Subject: Re: 2.4.7-ac8 compilation error
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010806230743.A12850@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everyone

Yep, same error. What's funny is that all the stuff in mm/shmem.c is 
related to the TMPFS (as far as I understood), and seems to be included and 
compiled even if you don't select TMPFS...

I tried to hack a bit around, but to be honest I've got no clue. :)

Have fun
Ed


At 23:07 06/08/2001 +0200, Gregoire Favre wrote:
>Hello,
>
>I got the following error while trying 2.4.7-ac8:
>
>make[1]: Leaving directory `/usr/src/linux-2.4.7-ac8/arch/i386/lib'
>ld -m elf_i386 -T /usr/src/linux-2.4.7-ac8/arch/i386/vmlinux.lds -e stext 
>arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
>init/version.o \
>         --start-group \
>         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o 
> mm/mm.o fs/fs.o ipc/ipc.o \
>         drivers/parport/driver.o drivers/char/char.o 
> drivers/block/block.o drivers/misc/misc.o drivers/net/net.o 
> drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o 
> drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o 
> drivers/pci/driver.o drivers/video/video.o drivers/usb/usbdrv.o 
> drivers/net/irda/irda.o \
>         net/network.o \
>         /usr/src/linux-2.4.7-ac8/arch/i386/lib/lib.a 
> /usr/src/linux-2.4.7-ac8/lib/lib.a 
> /usr/src/linux-2.4.7-ac8/arch/i386/lib/lib.a \
>         --end-group \
>         -o vmlinux
>mm/mm.o: In function `init_shmem_fs':
>mm/mm.o(.text.init+0xec4): undefined reference to `shmem_set_size'
>make: *** [vmlinux] Error 1
>
>         Greg
>________________________________________________________________
>http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch

