Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbTFKENb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 00:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbTFKENb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 00:13:31 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:58785 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S264085AbTFKENa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 00:13:30 -0400
From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: Linux 2.4.21-rc1
Date: Wed, 11 Jun 2003 01:27:07 -0300
User-Agent: KMail/1.5.1
Cc: lkml <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva> <200304250006.53769.lucasvr@gobolinux.org> <20030607193542.GA12443@fs.tum.de>
In-Reply-To: <20030607193542.GA12443@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306110127.07243.lucasvr@gobolinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 June 2003 16:35, Adrian Bunk wrote:
> On Fri, Apr 25, 2003 at 12:06:53AM -0300, Lucas Correia Villa Real wrote:
> > Hi,
>
> Hi Lucas,
>
> > I had some problems compiling the ramdisk driver:
> >
> > gcc -D__KERNEL__ -I/Depot/Sources/2.4.21-rc1/include -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> > -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
> > -DMODULE -DMODVERSIONS -include
> > /Depot/Sources/2.4.21-rc1/include/linux/modversions.h  -nostdinc
> > -iwithprefix include -DKBUILD_BASENAME=rd  -c -o rd.o rd.c
> > rd.c:88: `CONFIG_BLK_DEV_RAM_SIZE' undeclared here (not in a function)
> > make[2]: *** [rd.o] Error 1
> > make[2]: Leaving directory `/Depot/Sources/2.4.21-rc1/drivers/block'
> > make[1]: *** [_modsubdir_block] Error 2
> > make[1]: Leaving directory `/Depot/Sources/2.4.21-rc1/drivers'
> > make: *** [_mod_drivers] Error 2
> >
> >
> > The simple patch below can fix it, though. Is it ok to check against
> > CONFIG_BLK_DEV_RAM_SIZE definition and redefine it if not found?
>
> does this problem still exist in -rc7 ?
>
> If yes, please send your .config .

I have tryied with -rc8, and the problem is fixed now.

Lucas
