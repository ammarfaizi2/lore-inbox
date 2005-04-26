Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVDZFpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVDZFpy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 01:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVDZFpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 01:45:54 -0400
Received: from fmr21.intel.com ([143.183.121.13]:6831 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261330AbVDZFpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 01:45:39 -0400
Subject: Re: [2.6 patch] ACPI: add two missing config.h #include's
From: Len Brown <len.brown@intel.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alexey Dobriyan <adobriyan@mail.ru>, Andrew Morton <akpm@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-serial@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <20050417181948.GB3625@stusta.de>
References: <20050415151053.GM5456@stusta.de>
	 <E1DMTPC-000ASo-00.adobriyan-mail-ru@f13.mail.ru>
	 <20050416023852.GI4831@stusta.de>
	 <20050416085923.A10826@flint.arm.linux.org.uk>
	 <20050417181948.GB3625@stusta.de>
Content-Type: text/plain
Organization: 
Message-Id: <1114494219.2930.260.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 26 Apr 2005 01:43:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.

thanks,
-Len

On Sun, 2005-04-17 at 14:19, Adrian Bunk wrote:
> On Sat, Apr 16, 2005 at 08:59:23AM +0100, Russell King wrote:
> > On Sat, Apr 16, 2005 at 04:38:52AM +0200, Adrian Bunk wrote:
> > > In the Linux kernel, it's more common to put such header
> dependencies
> > > for header files into the C files, but if the ACPI people agree a
> patch
> > > to add the #include <linux/config.h> to acpi_bus.h is the other
> possble
> > > correct solution for this issue.
> >
> > With the exception of linux/config.h.
> >
> > Do a 'make configcheck' and it'll tell you where linux/config.h is
> missing
> > and where it shouldn't be.
> 
> OK, then the patch below is the correct solution.
> 
> cu
> Adrian
> 
> 
> <--  snip  -->
> 
> 
> This patch fixes the following warning by adding two missing config.h
> #include's:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/serial/8250_acpi.o
> drivers/serial/8250_acpi.c: In function `acpi_serial_ext_irq':
> drivers/serial/8250_acpi.c:51: warning: implicit declaration of
> function
> `acpi_register_gsi'
> ...
> 
> <--  snip  -->
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.12-rc2-mm3-full/include/acpi/acpi_bus.h.old      
> 2005-04-17 19:05:23.000000000 +0200
> +++ linux-2.6.12-rc2-mm3-full/include/acpi/acpi_bus.h   2005-04-17
> 19:05:37.000000000 +0200
> @@ -26,6 +26,7 @@
>  #ifndef __ACPI_BUS_H__
>  #define __ACPI_BUS_H__
> 
> +#include <linux/config.h>
>  #include <linux/kobject.h>
> 
>  #include <acpi/acpi.h>
> --- linux-2.6.12-rc2-mm3-full/include/linux/acpi.h.old  2005-04-17
> 19:25:51.000000000 +0200
> +++ linux-2.6.12-rc2-mm3-full/include/linux/acpi.h      2005-04-17
> 19:24:54.000000000 +0200
> @@ -25,6 +25,8 @@
>  #ifndef _LINUX_ACPI_H
>  #define _LINUX_ACPI_H
> 
> +#include <linux/config.h>
> +
>  #ifdef CONFIG_ACPI
> 
>  #ifndef _LINUX
> 
> 

