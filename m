Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312525AbSDEMel>; Fri, 5 Apr 2002 07:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312529AbSDEMec>; Fri, 5 Apr 2002 07:34:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:7827 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S312525AbSDEMeT>;
	Fri, 5 Apr 2002 07:34:19 -0500
Date: Fri, 5 Apr 2002 14:34:10 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Brett Nuske <bnuske@cs.rmit.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: COMPILE BUG: SiS DRM Support
Message-Id: <20020405143410.0cfc2c2c.sebastian.droege@gmx.de>
In-Reply-To: <Pine.SOL.4.33.0204052211080.25614-100000@numbat.cs.rmit.edu.au>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.8cvpuBcGvQo78V"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.8cvpuBcGvQo78V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Apr 2002 22:22:05 +1000 (EST)
Brett Nuske <bnuske@cs.rmit.edu.au> wrote:

> 
> Hi,
> 
>    I have been trying to compile SiS DRM support
> with the 2.4.18 kernel (have tried both module
> and in the kernel) but to no avail. When built
> as a module it compiles but when the module gets
> loaded I get unresolved symbols.
> 
>    When trying to compile the support directly into
> the kernel I get the following compilation errors:
> 
> <cut>
> 
> ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
>         --start-group \
>         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
>          drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o \
>         net/network.o \
>         /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
>         --end-group \
>         -o vmlinux
> drivers/char/drm/drm.o: In function `sis_fb_alloc':
> drivers/char/drm/drm.o(.text+0x6a26): undefined reference to `sis_malloc'
> drivers/char/drm/drm.o(.text+0x6a6d): undefined reference to `sis_free'
> drivers/char/drm/drm.o: In function `sis_fb_free':
> drivers/char/drm/drm.o(.text+0x6bb2): undefined reference to `sis_free'
> drivers/char/drm/drm.o: In function `sis_final_context':
> drivers/char/drm/drm.o(.text+0x7066): undefined reference to `sis_free'
> make: *** [vmlinux] Error 1
> 
> </cut>
> 
> sis_free appears to be in linux/drivers/video/sis/sis_main.c
> with its prototype in linux/drivers/video/sis/sis_main.h
> 
> linux/drivers/video/sis/sis_mm.c seems to be where the sis_fb_alloc
> and sis_fb_free function calls are made.
> 
> Is there any obvious reasons why this isn't compiling?
Try compiling with SiS framebuffer device (CONFIG_FB_SIS and CONFIG_FB_SIS_300 or CONFIG_FB_SIS_315) activated... the SiS DRI driver needs it... don't ask me why ;)

Bye
--=.8cvpuBcGvQo78V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8rZnEe9FFpVVDScsRAiosAJsHQgbw29USW5d3lmBCN3ULe0IC0ACfS1sG
oBgIno670RqY+qkh+7be8Mo=
=Dlgg
-----END PGP SIGNATURE-----

--=.8cvpuBcGvQo78V--

