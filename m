Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129777AbQKWJW6>; Thu, 23 Nov 2000 04:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129859AbQKWJWt>; Thu, 23 Nov 2000 04:22:49 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:28679 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S129777AbQKWJWf>; Thu, 23 Nov 2000 04:22:35 -0500
Date: Thu, 23 Nov 2000 02:52:31 -0600
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch(?): linux-2.4.0-test11/drivers/char pci_device_id tables
Message-ID: <20001123025231.P2918@wire.cadcamlab.org>
In-Reply-To: <20001122184022.A5804@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001122184022.A5804@baldur.yggdrasil.com>; from adam@yggdrasil.com on Wed, Nov 22, 2000 at 06:40:22PM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Adam J. Richter]
> +static struct pci_device_id isicom_pci_tbl[] __initdata = {
> +	{ VENDOR_ID, 0x2028, PCI_ANY_ID, PCI_ANY_ID },
> +	{ VENDOR_ID, 0x2051, PCI_ANY_ID, PCI_ANY_ID },
> +	{ VENDOR_ID, 0x2052, PCI_ANY_ID, PCI_ANY_ID },
> +	{ VENDOR_ID, 0x2053, PCI_ANY_ID, PCI_ANY_ID },
> +	{ VENDOR_ID, 0x2054, PCI_ANY_ID, PCI_ANY_ID },
> +	{ VENDOR_ID, 0x2055, PCI_ANY_ID, PCI_ANY_ID },
> +	{ VENDOR_ID, 0x2056, PCI_ANY_ID, PCI_ANY_ID },
> +	{ VENDOR_ID, 0x2057, PCI_ANY_ID, PCI_ANY_ID },
> +	{ VENDOR_ID, 0x2058, PCI_ANY_ID, PCI_ANY_ID },

Eh.  Once again the numbers are ugly.  Unfortunately the ISICom
situation is non-obvious.  Multi-Tech is using the same PCI ID (10b5)
as PLX, even though according to pci.ids they have their own (1122).
Furthermore, the driver source does not indicate which of the five
supported models is which.  Oh well, maybe this one *isn't* worth
trying to clean up..

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
