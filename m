Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316838AbSF0O7p>; Thu, 27 Jun 2002 10:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSF0O7o>; Thu, 27 Jun 2002 10:59:44 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:49037 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S316838AbSF0O7o>; Thu, 27 Jun 2002 10:59:44 -0400
Date: Thu, 27 Jun 2002 16:59:22 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Kees Bakker <kees.bakker@altium.nl>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ATA: cleanup of channel->autodma flags usage
In-Reply-To: <siit443int.fsf@koli.tasking.nl>
Message-ID: <Pine.SOL.4.30.0206271649520.11655-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 27 Jun 2002, Kees Bakker wrote:

> >>>>> "Bartlomiej" == Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> writes:
>
> Bartlomiej> incremental to generic ATA PCI auto-dma patches...
> [...]
> Bartlomiej> 	- remove ATA_F_NOAUTODMA flag from aec62xx.c, hpt34x.c,
> Bartlomiej> 	  sis5513.c and via82cxxx.c drivers, it's use was bogus
> Bartlomiej> 	  in these drivers
>
> Bartlomiej> 	  only two usages of ATA_F_NOAUTODMA are left (in ide-pci.c),
> Bartlomiej> 	  probably they can alse be removed due to fact that drivers
> Bartlomiej> 	  should disable autodma not ide-pci (i.e. hpt34x)
> [...]
>
> That should say: ATA_F_NOADMA

Yep, thanks.


> I have removed ATA_F_NODMA in ide-pci.c for my VIA8233
> (PCI_DEVICE_ID_VIA_82C586_1). So far it has not failed (using 2.5.20).

Because its usage is bogus and you probably use via82cxxx.c anyway :)

>
> --- linux-2.5.20/drivers/ide/ide-pci.c~	Mon Jun  3 14:49:59 2002
> +++ linux-2.5.20/drivers/ide/ide-pci.c	Fri Jun  7 18:52:50 2002
> @@ -742,8 +742,7 @@
>  	{
>  		vendor: PCI_VENDOR_ID_VIA,
>  		device: PCI_DEVICE_ID_VIA_82C586_1,
> -		bootable: ON_BOARD,
> -		flags: ATA_F_NOADMA
> +		bootable: ON_BOARD
>  	},
>  	{
>  		vendor: PCI_VENDOR_ID_TTI,
>
> - Kees
>

