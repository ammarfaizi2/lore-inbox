Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262883AbSJLJiK>; Sat, 12 Oct 2002 05:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262884AbSJLJiJ>; Sat, 12 Oct 2002 05:38:09 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:64783 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262883AbSJLJiJ>;
	Sat, 12 Oct 2002 05:38:09 -0400
Date: Sat, 12 Oct 2002 11:41:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Mitchell Blank Jr <mitch@sfgoth.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: Linux v2.5.42
Message-ID: <20021012114117.A5374@mars.ravnborg.org>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Mitchell Blank Jr <mitch@sfgoth.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>
References: <Pine.LNX.4.44.0210112134160.7166-100000@penguin.transmeta.com> <Pine.NEB.4.44.0210121121150.8340-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.NEB.4.44.0210121121150.8340-100000@mimas.fachschaften.tu-muenchen.de>; from bunk@fs.tum.de on Sat, Oct 12, 2002 at 11:24:48AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 11:24:48AM +0200, Adrian Bunk wrote:
> This patch fixed part of the kbuild breakage in drivers/atm/Makefile, the
> following patch fixes the rest:
Small adjustment:

	Sam
 
--- linux-2.5.42-full/drivers/atm/Makefile.old	2002-10-12 11:13:48.000000000 +0200
+++ linux-2.5.42-full/drivers/atm/Makefile	2002-10-12 11:20:15.000000000 +0200
 @@ -36,7 +36,7 @@
    fore_200e-objs		+= fore200e_pca_fw.o
    # guess the target endianess to choose the right PCA-200E firmware image
    ifeq ($(CONFIG_ATM_FORE200E_PCA_DEFAULT_FW),y)
 -    CONFIG_ATM_FORE200E_PCA_FW = $(shell if test -n "`$(CC) -E -dM $(src)/../../include/asm/byteorder.h | grep ' __LITTLE_ENDIAN '`"; then echo pca200e.bin; else echo pca200e_ecd.bin2; fi)
 +    CONFIG_ATM_FORE200E_PCA_FW = $(shell if test -n "`$(CC) -E -dM $(src)/../../include/asm/byteorder.h | grep ' __LITTLE_ENDIAN '`"; then echo $(obj)/pca200e.bin; else echo $(obj)/pca200e_ecd.bin2; fi)
    endif
  endif
 
 
 
