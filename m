Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTFGTWP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 15:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbTFGTWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 15:22:15 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:14545 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263487AbTFGTWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 15:22:14 -0400
Date: Sat, 7 Jun 2003 21:35:43 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.21-rc1
Message-ID: <20030607193542.GA12443@fs.tum.de>
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva> <200304250006.53769.lucasvr@gobolinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304250006.53769.lucasvr@gobolinux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 25, 2003 at 12:06:53AM -0300, Lucas Correia Villa Real wrote:

> Hi,

Hi Lucas,

> I had some problems compiling the ramdisk driver:
> 
> gcc -D__KERNEL__ -I/Depot/Sources/2.4.21-rc1/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
> -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS 
> -include /Depot/Sources/2.4.21-rc1/include/linux/modversions.h  -nostdinc 
> -iwithprefix include -DKBUILD_BASENAME=rd  -c -o rd.o rd.c
> rd.c:88: `CONFIG_BLK_DEV_RAM_SIZE' undeclared here (not in a function)
> make[2]: *** [rd.o] Error 1
> make[2]: Leaving directory `/Depot/Sources/2.4.21-rc1/drivers/block'
> make[1]: *** [_modsubdir_block] Error 2
> make[1]: Leaving directory `/Depot/Sources/2.4.21-rc1/drivers'
> make: *** [_mod_drivers] Error 2
> 
> 
> The simple patch below can fix it, though. Is it ok to check against 
> CONFIG_BLK_DEV_RAM_SIZE definition and redefine it if not found?

does this problem still exist in -rc7 ?

If yes, please send your .config .

> Lucas
>...

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

