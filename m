Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265484AbRF1Cnm>; Wed, 27 Jun 2001 22:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265485AbRF1Cnb>; Wed, 27 Jun 2001 22:43:31 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:48326 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265484AbRF1CnT>; Wed, 27 Jun 2001 22:43:19 -0400
Message-ID: <3B3A24D9.5013B835@vnet.ibm.com>
Date: Wed, 27 Jun 2001 13:24:25 -0500
From: Tom Gall <tom_gall@vnet.ibm.com>
X-Mailer: Mozilla 4.7 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com> <3B3A5B00.9FF387C9@mandrakesoft.com> <3B3A64CD.28B72A2A@vnet.ibm.com> <3B3A6D80.E82A2BA6@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jeff Garzik wrote:

> Tom Gall wrote:
> > Well you have device drivers like the symbios scsi driver for instance that
> > tries to determine if it's seen a card before. It does this by looking at the
> > bus,dev etc numbers...  It's quite reasonable for two different scsi cards to be
> > on the same bus number, same dev number etc yet they are in different PCI
> > domains.
> >
> > Is this a device driver bug or feature?
>
> I hesitate to call it a device driver bug, because that was likely the
> best decision Gerard could make at the time.

I don't doubt it. I wouldn't doubt I've been guilty of simliar things in my past...


> However, I think the driver (only going by your description) would be
> more correct to use a pointer to struct pci_dev.  We have a token in the
> kernel that is guaranteed 100% unique to any given PCI device:  the
> pointer to its struct pci_dev.

Sound good.

> > > Changing the meaning of dev->bus->number globally seems pointless.  If
> > > you are going to do that, just do it the right way and introduce another
> > > struct member, pci_domain or somesuch.
>
> Sorry, not pci_domain, just system bus number, for any bus, like we
> talked about in the previous discussion.

Yes agreed. However do you think it's possible for the additional of such a value now
in 2.4.x series? Alan? Linus?

Regards,

Tom
--
Tom Gall - PPC64 Maintainer      "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://www.ibm.com/linux/ltc/projects/ppc


