Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262878AbSJLKQO>; Sat, 12 Oct 2002 06:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262881AbSJLKQO>; Sat, 12 Oct 2002 06:16:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:14791 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262878AbSJLKQN>; Sat, 12 Oct 2002 06:16:13 -0400
Date: Sat, 12 Oct 2002 12:21:58 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Sam Ravnborg <sam@ravnborg.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Mitchell Blank Jr <mitch@sfgoth.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: Linux v2.5.42
In-Reply-To: <20021012114117.A5374@mars.ravnborg.org>
Message-ID: <Pine.NEB.4.44.0210121205410.8340-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Oct 2002, Sam Ravnborg wrote:

> On Sat, Oct 12, 2002 at 11:24:48AM +0200, Adrian Bunk wrote:
> > This patch fixed part of the kbuild breakage in drivers/atm/Makefile, the
> > following patch fixes the rest:
> Small adjustment:
>
> 	Sam
>
> --- linux-2.5.42-full/drivers/atm/Makefile.old	2002-10-12 11:13:48.000000000 +0200
> +++ linux-2.5.42-full/drivers/atm/Makefile	2002-10-12 11:20:15.000000000 +0200
>  @@ -36,7 +36,7 @@
>     fore_200e-objs		+= fore200e_pca_fw.o
>     # guess the target endianess to choose the right PCA-200E firmware image
>     ifeq ($(CONFIG_ATM_FORE200E_PCA_DEFAULT_FW),y)
>  -    CONFIG_ATM_FORE200E_PCA_FW = $(shell if test -n "`$(CC) -E -dM $(src)/../../include/asm/byteorder.h | grep ' __LITTLE_ENDIAN '`"; then echo pca200e.bin; else echo pca200e_ecd.bin2; fi)
>  +    CONFIG_ATM_FORE200E_PCA_FW = $(shell if test -n "`$(CC) -E -dM $(src)/../../include/asm/byteorder.h | grep ' __LITTLE_ENDIAN '`"; then echo $(obj)/pca200e.bin; else echo $(obj)/pca200e_ecd.bin2; fi)
>     endif
>   endif

Yes thanks, your patch is better than mine.

cu
Adrian

-- 

"Is there not promise of rain?" Ling Tan asked suddenly out
of the darkness. There had been need of rain for many days.
"Only a promise," Lao Er said.
                                Pearl S. Buck - Dragon Seed



