Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269777AbRHaXsQ>; Fri, 31 Aug 2001 19:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269786AbRHaXsH>; Fri, 31 Aug 2001 19:48:07 -0400
Received: from mercury.mv.net ([199.125.85.40]:45582 "EHLO mercury.mv.net")
	by vger.kernel.org with ESMTP id <S269777AbRHaXr7>;
	Fri, 31 Aug 2001 19:47:59 -0400
Message-ID: <006501c13277$2e3c8620$0201a8c0@home>
From: "jeff millar" <jeff@wa1hco.mv.com>
To: "Greg KH" <greg@kroah.com>
Cc: "Carlos E Gorges" <carlos@techlinux.com.br>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <01083019402502.01265@skydive.techlinux> <20010830161809.A19258@kroah.com> <002801c13270$86592680$0201a8c0@home> <20010831162303.A23689@kroah.com>
Subject: Re: [ANNOUNCE] Hardware detection tool 0.2
Date: Fri, 31 Aug 2001 19:46:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What bus and slot number does the driver use to register itself before the
plugging the card?

----- Original Message -----
From: "Greg KH" <greg@kroah.com>
To: "jeff millar" <jeff@wa1hco.mv.com>
Cc: "Carlos E Gorges" <carlos@techlinux.com.br>;
<linux-kernel@vger.kernel.org>
Sent: Friday, August 31, 2001 7:23 PM
Subject: Re: [ANNOUNCE] Hardware detection tool 0.2


> On Fri, Aug 31, 2001 at 06:58:59PM -0400, jeff millar wrote:
> >
> > One reason: Not all hardware has the signals needed to detect when a
card
> > gets plugged or unplugged.  Consider legacy cPCI systems.  The don't
have
> > the Hot Swap extensions or backplane hot swap control.  The only way to
find
> > the cards is to periodically scan the bus for new cards, cards that
> > disappeared, or requests for Hot Swap.
>
> But the driver for those devices have a struct pci_driver object that
> they use to register themselves with the PCI subsystem, right?  The
> MODULE_DEVICE_TABLE uses the id_table structure in the struct pci_driver
> object.  That's all, it isn't necessarily a hotplug specific thing.
>
> And having that MODULE_DEVICE_TABLE for those drivers will allow the
> kernel to load those modules when the bus is scanned for new cards, like
> on boot :)
>
> thanks,
>
> greg k-h
>

