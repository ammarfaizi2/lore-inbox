Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWGDUoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWGDUoK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 16:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWGDUoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 16:44:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:59430 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932377AbWGDUoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 16:44:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FcGjmaa2EH97+4bWlrB2DyByvJl/Lj1ddpVr1SF8+YeM2YohQ/k2N7wMD9PBi4QKYlhoThiDdLZf1+A0jwGtLspSgp2jmbvznWGv0FM6bl6vVhAdCozw/ra4ndoYckBaVll5zut974xejpuh+p4mTmXHXCOR+Ff9hNa6G8KynF8=
Message-ID: <c526a04b0607041344nf8b7206u8c64e8730c4c770b@mail.gmail.com>
Date: Tue, 4 Jul 2006 21:44:07 +0100
From: "Adam Henley" <adamazing@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: Linux SATA Support Question - Is the ULI M1575 chip supported?
Cc: "Justin Piszcz" <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
In-Reply-To: <44A9BD0B.8010104@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0607031756510.3342@p34.internal.lan>
	 <44A9BD0B.8010104@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/06, Jeff Garzik <jeff@garzik.org> wrote:
> Justin Piszcz wrote:
> >
> > In the source:
> >
> > enum {
> >         uli_5289                = 0,
> >         uli_5287                = 1,
> >         uli_5281                = 2,
> >
> >         uli_max_ports           = 4,
> >
> >         /* PCI configuration registers */
> >         ULI5287_BASE            = 0x90, /* sata0 phy SCR registers */
> >         ULI5287_OFFS            = 0x10, /* offset from sata0->sata1 phy
> > regs */
> >         ULI5281_BASE            = 0x60, /* sata0 phy SCR  registers */
> >         ULI5281_OFFS            = 0x60, /* offset from sata0->sata1 phy
> > regs */
> > };
> >
> > However, in the manual for this motherboard it states it has a ULI
> > M1575, can anyone comment?
> >
> > http://us.dfi.com.tw/Upload/Manual/90800601.pdf
>
> What is the PCI ID?
>
>         Jeff

Sure this won't help, but just in case... my board:
http://www.asrock.com/product/939Dual-SATA2.htm
"Chipset  	- Northbridge: ULi M1695
                    - Southbridge: ULI M1567"

PCI ID of Southbridge in lspci output below looks like 5289

00:00.0 Host bridge: ALi Corporation M1695 K8 Northbridge [PCI Express
and HyperTransport]
00:01.0 PCI bridge: ALi Corporation: Unknown device 524b
00:02.0 PCI bridge: ALi Corporation: Unknown device 524c
00:04.0 Host bridge: ALi Corporation M1689 K8 Northbridge [Super K8 Single Chip]
00:05.0 PCI bridge: ALi Corporation AGP8X Controller
00:06.0 PCI bridge: ALi Corporation M5249 HTT to PCI Bridge
00:07.0 ISA bridge: ALi Corporation M1563 HyperTransport South Bridge (rev 70)
00:07.1 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
00:11.0 Ethernet controller: ALi Corporation M5263 Ethernet Controller (rev 40)
00:12.0 IDE interface: ALi Corporation M5229 IDE (rev c7)
00:12.1 IDE interface: ALi Corporation ULi 5289 SATA (rev 10)
00:13.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:13.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
<snip>

Justin: I'm using 2.6.17.1 and the sata_uli driver seems to be
handling the SATA drives just fine. But as I say, it's a different
southbridge, so apologies if I'm just contributing to the noise :o)

Not sure if this is comprehensive: http://pci-ids.ucw.cz/iii/?i=10b9
It doesn't appear to list the M1575's pci id there.

adam
