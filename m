Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbTFLWNt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264835AbTFLWNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:13:49 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:53622 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S264826AbTFLWNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:13:44 -0400
Subject: Re: 2.4.21-rc8-laptop1 released
From: Disconnect <lkml@sigkill.net>
To: Hanno =?ISO-8859-1?Q?B=F6ck?= <hanno@gmx.de>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030612223940.7fcc00a1.hanno@gmx.de>
References: <20030612223940.7fcc00a1.hanno@gmx.de>
Content-Type: multipart/mixed; boundary="=-oPj+pyJTY3J4saGevdPG"
Message-Id: <1055456849.1296.132.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 12 Jun 2003 18:27:30 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oPj+pyJTY3J4saGevdPG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Build breakage:

Lots of:

drm_os_linux.h:16:2: warning: #warning the author of this code needs to
read up on list_entry
radeon_drv.h:846:2: warning: #warning PCI posting bug
In file included from radeon_irq.c:38:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to
read up on list_entry

..and some breakage:
gcc -D__KERNEL__ -I/usr/src/LinuxPatches/tmp/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=pentium4
-DMODULE -DMODVERSIONS -include
/usr/src/LinuxPatches/tmp/include/linux/modversions.h  -nostdinc
-iwithprefix include -DKBUILD_BASENAME=i810_dma  -c -o i810_dma.o
i810_dma.c
In file included from drmP.h:75,
                 from i810_dma.c:35:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to
read up on list_entry
i810_dma.c: In function `i810_unmap_buffer':
i810_dma.c:223: error: too many arguments to function
`do_munmap_Ra9e5c04d'
make[3]: *** [i810_dma.o] Error 1

Config attached

On Thu, 2003-06-12 at 16:39, Hanno Böck wrote:
> The second release of laptopkernel is out.
> Get it at
> https://savannah.nongnu.org/projects/laptopkernel/
> 
> 
> 2.4.21-rc8-laptop1
> 
> Updated patches: swsusp, supermount, agpgart, drm, broadcom
> New patches: acpi4asus, laptop_mode, sis-fb
> 
> Patch:  acpi-20030523 (www.sf.net/projects/acpi)
> The ACPI in current kernels is very outdated. Most laptops won't have
> any Powermanagement without the ACPI-Patch and some even won't boot.
> 
> Patch: swsusp-1.0_pre7 (www.sf.net/projects/swsusp)
> Software Suspend makes hibernation possible in linux, which is a very
> important feature for laptops.
> 
> Patch:  supermount-1.2.7 (http://supermount-ng.sf.net)
> Supermount is a useful feature for desktop-pcs.
> 
> Patch:  agpgart from 2.4.21-rc7-ac1 (www.kernel.org)
> Laptops with the Centrino chipset need this for working agpgart, which
> is needed for hardware graphics acceleration (dri).
> 
> Patch:  drm modules from 2.4.21-rc7-ac1 (www.kernel.org)
> This update is needed for proper working dri in XFree 4.3.
> 
> Patch:  radeonfb from Benjamin Herrenschmidt (rsync -avz
> rsync.penguinppc.org::benh-devel/) Radeon 9000 won't work with radeonfb
> found in the current kernel.
> 
> Patch:  bcm4400-2.0.2 + bcm5700-6.0.2 driver (from broadcom-ftp)
> Needed for Broadcom Network cards found in many laptops.
> 
> Patch:  vivicam usb mass storage support (from Lycoris-Kernel)
> Needed for Vivicam 355 (working as USB mass storage).
> 
> Patch:  acpi4asus-0.23 (www.sf.net/projects/acpi4asus)
> Adds support for special acpi-events on asus-laptops.
> 
> Patch:  laptop_mode (www.sf.net/projects/swsusp)
> Adds laptop_mode, which can save battery power.
> 
> Patch:  SiS framebuffer update (www.winischhofer.net)
> Needed for some SiS-Cards.
> 
> Patch:  Optimization for pentium3/4 (trivial)
> Makes gcc3-optimizations for pentium3/4 possible.
> (Note: pentium4-optimizations should only be used with gcc 3.2.3 and
> above. If you have an older gcc, please use pentium3.)
-- 
Disconnect <lkml@sigkill.net>

--=-oPj+pyJTY3J4saGevdPG
Content-Disposition: attachment; filename=config.gz
Content-Type: application/x-gzip; name=config.gz
Content-Transfer-Encoding: base64

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

--=-oPj+pyJTY3J4saGevdPG--

