Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316770AbSGLSgj>; Fri, 12 Jul 2002 14:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316774AbSGLSgi>; Fri, 12 Jul 2002 14:36:38 -0400
Received: from tao-eth.natur.cuni.cz ([195.113.46.57]:7692 "EHLO natur.cuni.cz")
	by vger.kernel.org with ESMTP id <S316770AbSGLSge>;
	Fri, 12 Jul 2002 14:36:34 -0400
X-Obalka-From: mmokrejs@natur.cuni.cz
Date: Fri, 12 Jul 2002 20:39:18 +0200 (CEST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: Thunder from the hill <thunder@ngforever.de>
cc: Kelledin <kelledin+LKML@skarpsey.dyndns.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Missing files in 2.4.19-rc1
In-Reply-To: <Pine.LNX.4.44.0207120643190.3421-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.OSF.4.44.0207122035310.281934-100000@tao.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2002, Thunder from the hill wrote:

> make mrproper

done

> cp ../.config .

cp ../linux-2.4.19-pre2/$hostname.cfg .config

> make oldconfig

done. I had to set settings for some new drivers.

`make dep` gave again:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -E -D__GENKSYMS__ au1000_gpio.c
| /sbin/genksyms -p smp_ -k 2.4.19 > /usr/src/linux-2.4.19-rc1/include/linux/modules/au1000_gpio.ver.tmp
au1000_gpio.c:41: asm/au1000.h: No such file or directory
au1000_gpio.c:42: asm/au1000_gpio.h: No such file or directory
[...]
make -C hisax fastdep
md5sum: can't open hfc_pci.
md5sum: can't open hfc_pci
[...]

I guess all as reported earlier.

BTW:
$ find . -name hfc_pci*
./drivers/isdn/hisax/hfc_pci.c
./drivers/isdn/hisax/hfc_pci.h
$

And now? ;)
-- 
Martin Mokrejs <mmokrejs@natur.cuni.cz>
PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3683 , fax: +49-89-3187 3585

