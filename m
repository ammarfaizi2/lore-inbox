Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285692AbSCSR6X>; Tue, 19 Mar 2002 12:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284180AbSCSR6O>; Tue, 19 Mar 2002 12:58:14 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:46075 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S285692AbSCSR6F>; Tue, 19 Mar 2002 12:58:05 -0500
Date: Tue, 19 Mar 2002 18:57:59 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre3-ac2
In-Reply-To: <E16nNPD-0008E3-00@the-village.bc.nu>
Message-ID: <Pine.NEB.4.44.0203191852570.3932-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, Alan Cox wrote:

> Linux 2.4.19pre3-ac2
>...
> o	Add iconfig  (save/extract config from kernel	(Randy Dunlap)
> 	image file)
>...

This sounds like a nice feature. Unfortunately it doesn't compile when you
are building a kernel without module support (CONFIG_MODULES is not set):

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -DEXPORT_SYMTAB -c -o configs.o configs.c
In file included from configs.c:2:
/home/bunk/linux/linux/include/linux/module.h:21: linux/modversions.h: No such file or directory
make[2]: *** [configs.o] Error 1
make[2]: Leaving directory `/home/bunk/linux/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/home/bunk/linux/linux/kernel'
make: *** [_dir_kernel] Error 2

<--  snip  -->

cu
Adrian

