Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276877AbRKRRIU>; Sun, 18 Nov 2001 12:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279902AbRKRRIL>; Sun, 18 Nov 2001 12:08:11 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:2809 "EHLO
	c0mailgw10.prontomail.com") by vger.kernel.org with ESMTP
	id <S276877AbRKRRIH>; Sun, 18 Nov 2001 12:08:07 -0500
Message-ID: <3BF7EAD1.6AB3EC02@starband.net>
Date: Sun, 18 Nov 2001 12:07:29 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Vogt <a_vogt@gaia.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Compilation problem 2.4.14
In-Reply-To: <8D6bPntFarB@a_vogt.gaia.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been reported, what, over 300 times? heh

Edit loop.c and remove the deactivate_page() functions.
And try again.

Andreas Vogt wrote:

> Hi,
>
> I can't compile actual kernel
> 2.4.14
> with gcc 2.95.3 and ld 2.11.90.0.29 (GNU)
>
> Compilation ends with follwing messages:
>
> make dep clean
> works fine.
>
> Next step
> make bzImage
>
> outputs the following:
>
> . scripts/mkversion > .tmpversion
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.14/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -DUTS_MACHINE='"i386"' -c -o init/version.o init/version.c
> make CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.14/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 " -C  kernel
> ...
> ...
> make all_targets
> make[2]: Entering directory `/usr/src/linux-2.4.14/arch/i386/lib'
> make[2]: Nothing to be done for `all_targets'.
> make[2]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/lib'
> make[1]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/lib'
> ld -m elf_i386 -T /usr/src/linux-2.4.14/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
>         --start-group \
>         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
>          drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/drm/drm.o drivers/net/fc/fc.o drivers/net/appletalk/appletalk.o drivers/net/wan/wan.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/net/pcmcia/pcmcia_net.o drivers/video/video.o drivers/md/mddev.o \
>         net/network.o \
>         /usr/src/linux-2.4.14/arch/i386/lib/lib.a /usr/src/linux-2.4.14/lib/lib.a /usr/src/linux-2.4.14/arch/i386/lib/lib.a \
>         --end-group \
>         -o vmlinux
> drivers/block/block.o: In function `lo_send':
> drivers/block/block.o(.text+0xa2ef): undefined reference to `deactivate_page'
> drivers/block/block.o(.text+0xa339): undefined reference to `deactivate_page'
> make: *** [vmlinux] Error 1
>
> So what's wrong?
> I didn't patch the kernel. It's original from ftp.kernel.org, downloaded
> yesterday.
> What can I do? Do you need more information about .config?
>
> I also noticed a problem with kernel 2.4.12 concerning ieee1284_ops.c
> (IEEE1284_PH_DIR_UNKNOWN should be IEEE1284_PH_ECP_DIR_UNKNOWN)
> This seems to be fixed now (2.4.14).
>
> There was also a warning about not to use 2.4.11
>
> Aren't there enough people to test new kernels? Are you releasing too
> often?
>
> Thank's for any helping answers.
>
> Bye
> Andreas Vogt
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

