Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbTFLXIX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 19:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265067AbTFLXIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 19:08:21 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:2052 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id S265062AbTFLXG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 19:06:56 -0400
Date: Thu, 12 Jun 2003 16:20:35 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: John T Copeland <johnc@neto.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linuxkernel <linux-kernel@vger.kernel.org>
Subject: Re: siimage driver
In-Reply-To: <3EE9070A.4040403@neto.com>
Message-ID: <Pine.LNX.4.10.10306121618270.806-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Until the device ordering can be sorted out, your pain will be the
following:

ide0=0x1f0,0x3f6,14 ide1=0x170,0x376,15

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Thu, 12 Jun 2003, John T Copeland wrote:

> Alan,
> A couple of questions if you please.
> 
> 1)  When I compile the siimage driver into the kernel, the ide buses are 
> scanned in the following order:
>   IDE0 - SATA primary - hda, hdb
>   IDE1 - SATA secondary - hdc, hdd
>   IDE2 - ATA tertiary - hde, hdf
>   IDE3 - ATA quandrary hdg, hdh
> I want the ATA to be IDE0/1  and SATA to be IDE2/3.  I have noticed from 
> some of the posts about the siimage driver on the ASUS nforce2 mobo this 
> is the apparent order scanned.  My mobo is an Abit NF7-S nforce2.  Is 
> there someway of controlling the order of scannin the IDE buses?  I 
> tried append="ide=reverse" to no avail.
> 
> 2) To try and get the nforce2 IDE buses scanned first, I compiled 
> siimage as a module, but when I did an "insmod siimage" I get an 
> unresolved external, "noautodma", in siimage.
> 
> I'd appreciate any help you can offer.
> 
> Thanks,
> John Copeland
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

