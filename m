Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277713AbRKNVJV>; Wed, 14 Nov 2001 16:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277738AbRKNVJM>; Wed, 14 Nov 2001 16:09:12 -0500
Received: from chaos.analogic.com ([204.178.40.224]:3968 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S277713AbRKNVIy>; Wed, 14 Nov 2001 16:08:54 -0500
Date: Wed, 14 Nov 2001 16:08:22 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Preston Crow <pc-lkml141101@crowcastle.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Compile failed on fs.o for 2.4.15-pre4
In-Reply-To: <200111142055.fAEKtQY30336@lol1122.lss.emc.com>
Message-ID: <Pine.LNX.3.95.1011114160551.635A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2001, Preston Crow wrote:

> After making the patch to setup.c so that it would compile, I ran into a
> linking error.  I have a fairly standard uniprocessor PIII system.  I can
> make my config file available to anyone that thinks it will help.
> 
> 
> make[1]: Leaving directory `/usr/src/linux/arch/i386/lib'
> ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
>         --start-group \
>         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
>          drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/net/fc/fc.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o \
>         net/network.o \
>         /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
>         --end-group \
>         -o vmlinux
> fs/fs.o: In function `dput':
> fs/fs.o(.text+0x10fb8): undefined reference to `atomic_dec_and_lock'
> make: *** [vmlinux] Error 1
> 
> [Please CC responses to me]

Assuming that your version is similar to mine....

In ...linux/fs/dcache.c add ...
#include <linux/spinlock.h>


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


