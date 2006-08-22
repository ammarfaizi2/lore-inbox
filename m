Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWHVO7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWHVO7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 10:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWHVO7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 10:59:11 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25866 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932286AbWHVO7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 10:59:09 -0400
Date: Tue, 22 Aug 2006 16:59:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: avr32@atmel.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [-mm patch] avr32: set KBUILD_DEFCONFIG
Message-ID: <20060822145909.GZ11651@stusta.de>
References: <20060816231340.GK7813@stusta.de> <20060822141547.3f92c1ab@cad-250-152.norway.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822141547.3f92c1ab@cad-250-152.norway.atmel.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 02:15:47PM +0200, Haavard Skinnemoen wrote:
> On Thu, 17 Aug 2006 01:13:40 +0200
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > Please add an arch/avr32/defconfig.
> > 
> > The purposes of a defconfig are:
> > - starting point for people compiling their own kernel
> > - usable configuration for compile tests
> > 
> > It doesn't need to be anything special, e.g. a working .config from a 
> > machine you are using would be a suitable defconfig.
> 
> The patch below adds a defconfig which is essentially the same as
> at32stk1002_defconfig. I just ran it through oldconfig to make sure
> it's sane.

Ups, I missed at32stk1002_defconfig.

In this case, the simple patch below is the solution instead.

> Thanks for testing -- I assume you managed to get the
> toolchain up and running :)

I can only test the compilation due to lack of hardware, but using your 
patches it was easy building binutils 2.16.1 and gcc 4.0.3 cross 
compilers.

>...
> Haavard
>...

cu
Adrian


<--  snip  -->


This patch sets KBUILD_DEFCONFIG for enabling "make defconfig".

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc4-mm2/arch/avr32/Makefile.old	2006-08-22 16:47:43.000000000 +0200
+++ linux-2.6.18-rc4-mm2/arch/avr32/Makefile	2006-08-22 16:49:09.000000000 +0200
@@ -9,6 +9,8 @@
 .PHONY: all
 all: uImage vmlinux.elf linux.lst
 
+KBUILD_DEFCONFIG	:= at32stk1002_defconfig
+
 CFLAGS		+= -pipe -fno-builtin -mno-pic
 AFLAGS		+= -mrelax -mno-pic
 CFLAGS_MODULE	+= -mno-relax

