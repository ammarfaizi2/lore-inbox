Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316880AbSHZI4L>; Mon, 26 Aug 2002 04:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317986AbSHZI4K>; Mon, 26 Aug 2002 04:56:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19728 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316880AbSHZI4K>; Mon, 26 Aug 2002 04:56:10 -0400
Date: Mon, 26 Aug 2002 10:00:23 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Lightweight Patch Manager <patch@luckynet.dynu.com>
Cc: Linux Colonel Mailing List <linux-kernel@vger.kernel.org>,
       Thunder <thunder@lightweight.ods.org>
Subject: Re: [PATCH][2.5] Export symbols corrected...
Message-ID: <20020826100023.A900@flint.arm.linux.org.uk>
References: <01020725200951.044B6C@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <01020725200951.044B6C@hawkeye.luckynet.adm>; from patch@luckynet.dynu.com on Sun, Aug 25, 2002 at 08:09:51PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2002 at 08:09:51PM +0000, Lightweight Patch Manager wrote:
> This again corrects the exporting symbol directives in the Makefiles
> 
> diff -Nur -x SCCS -x CVS -x ChangeSet -x .deps linus-2.5/arch/arm/kernel/Makefile thunder-2.5/arch/arm/kernel/Makefile
> --- linus-2.5/arch/arm/kernel/Makefile	Sat Aug 24 04:50:16 2002
> +++ thunder-2.5/arch/arm/kernel/Makefile	Sun Aug 25 08:17:28 2002
> @@ -17,7 +17,7 @@
>  obj-n		:=
>  obj-		:=
>  
> -export-objs	:= armksyms.o apm.o dma.o ecard.o fiq.o io.o time.o
> +export-objs	:= armksyms.o dma.o ecard.o fiq.o io.o time.o

You're doing it again; maybe you should read back at the comments last
time you posted a patch on this subject?  apm.c is present in my tree,
but not yours.

> diff -Nur -x SCCS -x CVS -x ChangeSet -x .deps linus-2.5/arch/arm/mach-pxa/Makefile thunder-2.5/arch/arm/mach-pxa/Makefile
> --- linus-2.5/arch/arm/mach-pxa/Makefile	Sat Aug 24 04:50:19 2002
> +++ thunder-2.5/arch/arm/mach-pxa/Makefile	Sun Aug 25 08:18:49 2002
> @@ -12,7 +12,7 @@
>  obj-n :=
>  obj-  :=
>  
> -export-objs := generic.o irq.o dma.o sa1111.o
> +export-objs := generic.o dma.o

sa1111.o not merged yet (not even with me).  Hands orf.

> diff -Nur -x SCCS -x CVS -x ChangeSet -x .deps linus-2.5/arch/arm/mach-sa1100/Makefile thunder-2.5/arch/arm/mach-sa1100/Makefile
> --- linus-2.5/arch/arm/mach-sa1100/Makefile	Sat Aug 24 04:50:20 2002
> +++ thunder-2.5/arch/arm/mach-sa1100/Makefile	Sun Aug 25 08:20:30 2002
> @@ -11,8 +11,7 @@
>  obj-  :=
>  led-y := leds.o
>  
> -export-objs :=	dma.o generic.o irq.o pcipool.o sa1111.o sa1111-pcibuf.o \
> -		usb_ctl.o usb_recv.o usb_send.o pm.o
> +export-objs :=	dma.o generic.o pcipool.o sa1111.o sa1111-pcibuf.o pm.o

The usb stuff has moved into a subdirectory now, so yea.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
