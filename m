Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265647AbSKAJpW>; Fri, 1 Nov 2002 04:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265668AbSKAJpV>; Fri, 1 Nov 2002 04:45:21 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30991 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265647AbSKAJpV>; Fri, 1 Nov 2002 04:45:21 -0500
Date: Fri, 1 Nov 2002 09:51:41 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] typo in driver
Message-ID: <20021101095141.B15249@flint.arm.linux.org.uk>
References: <20021101064132.7E67E2C05E@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021101064132.7E67E2C05E@lists.samba.org>; from rusty@rustcorp.com.au on Fri, Nov 01, 2002 at 04:55:53PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 04:55:53PM +1100, Rusty Russell wrote:
> [ Russell, looks like you touched it last... ]
> 
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7594-2.5-bk-module-ppc.pre/drivers/ide/pci/sl82c105.c .7594-2.5-bk-module-ppc/drivers/ide/pci/sl82c105.c
> --- .7594-2.5-bk-module-ppc.pre/drivers/ide/pci/sl82c105.c	2002-10-15 15:30:56.000000000 +1000
> +++ .7594-2.5-bk-module-ppc/drivers/ide/pci/sl82c105.c	2002-11-01 16:48:14.000000000 +1100
> @@ -284,7 +284,7 @@ extern void ide_setup_pci_device(struct 
>  
>  static int __devinit sl82c105_init_one(struct pci_dev *dev, const struct pci_device_id *id)
>  {
> -	ide_pci_device_t *d = &slc82c105_chipsets[id->driver_data];
> +	ide_pci_device_t *d = &sl82c105_chipsets[id->driver_data];
>  	if (dev->device != d->device)
>  		BUG();
>  	ide_setup_pci_device(dev, d);

Don't bother with this small typo - its better that it doesn't build
at the moment.  The whole driver needs reworking since Martin's stuff got
ripped out to put some errata fixes back into the driver.
