Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbTBER7P>; Wed, 5 Feb 2003 12:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbTBER7O>; Wed, 5 Feb 2003 12:59:14 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:42139
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261742AbTBER7N>; Wed, 5 Feb 2003 12:59:13 -0500
Subject: Re: Help with promise sx6000 card
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Lists <user_linux@citma.cu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5E3B08A1.4000205@citma.cu>
References: <20030203221923.M79151@webmail.citma.cu>
	 <1044360902.23312.16.camel@irongate.swansea.linux.org.uk>
	 <5E3AE650.2010208@citma.cu>
	 <1044461220.32062.11.camel@irongate.swansea.linux.org.uk>
	 <5E3B06A0.40802@citma.cu>  <5E3B08A1.4000205@citma.cu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044471959.32062.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 05 Feb 2003 19:05:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ide: Found promise 20265 in RAID mode.
> PDC20276: not 100% native mode: will probe irqs later
> PDC20276: simplex device:  DMA disabled
> ide2: PDC20276 Bus-Master DMA disabled (BIOS)
> PDC20276: simplex device:  DMA disabled
> ide3: PDC20276 Bus-Master DMA disabled (BIOS)
> PDC20276: IDE controller on PCI bus 02 dev 08
> PDC20276: chipset revision 1
> ide: Found promise 20265 in RAID mode.
> PDC20276: not 100% native mode: will probe irqs later
> PDC20276: simplex device:  DMA disabled
> ide4: PDC20276 Bus-Master DMA disabled (BIOS)
> PDC20276: simplex device:  DMA disabled
> ide5: PDC20276 Bus-Master DMA disabled (BIOS)
> PDC20276: IDE controller on PCI bus 02 dev 10
> PDC20276: chipset revision 1
> ide: Found promise 20265 in RAID mode.
> PDC20276: not 100% native mode: will probe irqs later
> PDC20276: simplex device:  DMA disabled
> ide6: PDC20276 Bus-Master DMA disabled (BIOS)
> PDC20276: simplex device:  DMA disabled
> ide7: PDC20276 Bus-Master DMA disabled (BIOS)

It looks like it isnt skipping the devices on the raid card
for some reason. That would be a problem. It might work
with "ide2=noprobe ide3=noprobe ide4=noprobe ide5=noprobe ide6=noprobe
ide7=noprobe"

> Unable to obtain status of i2o/iop0, attempting a reset.
> i2o/iop0: Get status timeout.
> IOP reset timeout.
> i2o/iop0: Get status timeout.

and indeed the i2o firmware on the card seems to have crashed

What kernel are you using at the moment. And can you send me an lspci -v as
well as an lspci -t

