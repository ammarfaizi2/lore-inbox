Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277713AbRLGMgS>; Fri, 7 Dec 2001 07:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277918AbRLGMgI>; Fri, 7 Dec 2001 07:36:08 -0500
Received: from atm42.mobile.de ([212.12.52.53]:18949 "EHLO ATM42.mobile.de")
	by vger.kernel.org with ESMTP id <S277713AbRLGMf5> convert rfc822-to-8bit;
	Fri, 7 Dec 2001 07:35:57 -0500
Subject: Re: kernel 2.4.15
From: Falk Stern <f.stern@mobile.de>
To: tb@westend.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C10B4BA.6090303@westend.com>
In-Reply-To: <3C10B4BA.6090303@westend.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 07 Dec 2001 13:35:49 +0100
Message-Id: <1007728550.1668.2.camel@ridcully>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-12-07 at 13:23, Thomas Braun wrote:
> hi group,
> 
> 
> can someone tell me what is going wrong with my kernel?
> 
> 
> if i compile my kernel i get this error message
> 
> ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
>          --start-group \
>          arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
>           drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o \
>          net/network.o \
>          /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
>          --end-group \
>          -o vmlinux
> drivers/char/char.o(.data+0x46b4): undefined reference to `local symbols in discarded section .text.exit'
> make: *** [vmlinux] Fehler 1
> 
> attached my cpuinfo, meminfo and my .config an an nm output from driver/char/char.o


Looks like you ran in the same problem as me. What Distribution/binutils
are you using? If you are using Debian/Unstable, try downgrading
binutils to 2.11.92.0.10-4 from Testing. 

HTH, 

Falk

-- 
Mit freundlichen Grüßen
Ihr mobile.de Team

Falk Stern
Technik - Systemadministration

mobile.de GmbH
Bueschstr. 7 - D-20354 Hamburg
Tel.: +49 (0) 40/879 77-414
Fax:  +49 (0) 40/43 18 23-55
Web: http://www.mobile.de

