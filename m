Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264082AbRFETPz>; Tue, 5 Jun 2001 15:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264085AbRFETPq>; Tue, 5 Jun 2001 15:15:46 -0400
Received: from [24.219.123.215] ([24.219.123.215]:35846 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S264082AbRFETP3>; Tue, 5 Jun 2001 15:15:29 -0400
Date: Tue, 5 Jun 2001 12:15:21 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: "Todd M. Roy" <troy@holstein.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: patch for ide.2.4.5-ac8
In-Reply-To: <200106051908.f55J8bS32044@pcx4168.holstein.com>
Message-ID: <Pine.LNX.4.10.10106051214510.21236-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Todd,

Everyone knows that I was not an english major ;-)

Cheers,

On Tue, 5 Jun 2001, Todd M. Roy wrote:

> Andre,
>   Minor typo fix:
> --- ide-dma.c.~1~	Tue Jun  5 14:39:06 2001
> +++ ide-dma.c	Tue Jun  5 15:04:54 2001
> @@ -708,15 +708,15 @@
>  	if ((!dma_base) && (!second_chance)) {
>  		unsigned long set_bmiba = 0;
>  		second_chance++;
> -		switch(dev->vender) {
> -			PCI_VENDOR_ID_AL:
> -				set_bmiba = DEFAULT_BMALIBA; break;
> -			PCI_VENDOR_ID_VIA:
> -				set_bmiba = DEFAULT_BMCRBA; break;
> -			PCI_VENDOR_ID_INTEL:
> -				set_bmiba = DEFAULT_BMIBA; break;
> -			default:
> -				return dma_base;
> +		switch (dev->vendor) {
> +		         case PCI_VENDOR_ID_AL:
> +				        set_bmiba = DEFAULT_BMALIBA; break;
> +		         case PCI_VENDOR_ID_VIA:
> +		                set_bmiba = DEFAULT_BMCRBA; break;
> +		         case PCI_VENDOR_ID_INTEL:
> +		                set_bmiba = DEFAULT_BMIBA; break;
> +		         default:
> +		                return dma_base;
>  		}
>  		pci_write_config_dword(dev, 0x20, set_bmiba|1);
>  		goto second_chance_to_dma;
> 
> Cheers,
>   Todd
> **********************************************************************
> This footnote confirms that this email message has been swept by 
> MIMEsweeper for the presence of computer viruses.
> **********************************************************************
> 

Andre Hedrick
ASL Kernel Development
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

