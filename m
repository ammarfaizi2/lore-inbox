Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756535AbWKVTkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756535AbWKVTkM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 14:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756727AbWKVTkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 14:40:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32264 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1756535AbWKVTkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 14:40:10 -0500
Date: Wed, 22 Nov 2006 20:40:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] 2.6.19-rc5: modular USB rebuilds vmlinux?
Message-ID: <20061122194012.GA3516@stusta.de>
References: <200611222145.59560.arvidjaar@mail.ru> <20061122105454.aa5c0f3d.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061122105454.aa5c0f3d.randy.dunlap@oracle.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 10:54:54AM -0800, Randy Dunlap wrote:
> On Wed, 22 Nov 2006 21:45:55 +0300 Andrey Borzenkov wrote:
> 
> > I was under impression that I have fully modular USB. Still:
> > 
> > {pts/1}% make -C ~/src/linux-git O=$HOME/build/linux-2.6.19
> > make: Entering directory `/home/bor/src/linux-git'
> >   GEN     /home/bor/build/linux-2.6.19/Makefile
> > scripts/kconfig/conf -s arch/i386/Kconfig
> >   Using /home/bor/src/linux-git as source for kernel
> >   GEN     /home/bor/build/linux-2.6.19/Makefile
> >   CHK     include/linux/version.h
> >   CHK     include/linux/utsrelease.h
> >   CHK     include/linux/compile.h
> >   CC [M]  drivers/usb/core/usb.o
> >   CC [M]  drivers/usb/core/hub.o
> >   CC [M]  drivers/usb/core/hcd.o
> >   CC [M]  drivers/usb/core/urb.o
> >   CC [M]  drivers/usb/core/message.o
> >   CC [M]  drivers/usb/core/driver.o
> >   CC [M]  drivers/usb/core/config.o
> >   CC [M]  drivers/usb/core/file.o
> >   CC [M]  drivers/usb/core/buffer.o
> >   CC [M]  drivers/usb/core/sysfs.o
> >   CC [M]  drivers/usb/core/endpoint.o
> >   CC [M]  drivers/usb/core/devio.o
> >   CC [M]  drivers/usb/core/notify.o
> >   CC [M]  drivers/usb/core/generic.o
> >   CC [M]  drivers/usb/core/hcd-pci.o
> >   CC [M]  drivers/usb/core/inode.o
> >   CC [M]  drivers/usb/core/devices.o
> >   LD [M]  drivers/usb/core/usbcore.o
> >   CC      drivers/usb/host/pci-quirks.o
> >   LD      drivers/usb/host/built-in.o
> >  
> > Sorry? How comes it still compiles something into main kernel?
> 
> It's just a quirk of the build machinery.
> The built-in.o file should be 8 bytes or so, with nothing
> really in it.
>...

No, it's something different:

Note that drivers/usb/host/pci-quirks.o is built non-modular since it 
won't work modular.

> ~Randy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

