Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264561AbRF1V5R>; Thu, 28 Jun 2001 17:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264550AbRF1V5G>; Thu, 28 Jun 2001 17:57:06 -0400
Received: from front6.grolier.fr ([194.158.96.56]:28402 "EHLO
	front6.grolier.fr") by vger.kernel.org with ESMTP
	id <S264506AbRF1V4y> convert rfc822-to-8bit; Thu, 28 Jun 2001 17:56:54 -0400
Date: Thu, 28 Jun 2001 23:54:41 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
X-X-Sender: <groudier@>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Todd Inglett <tinglett@vnet.ibm.com>, "David S. Miller" <davem@redhat.com>,
        <tgall%rchland.vnet@RCHGATE.RCHLAND.IBM.COM>,
        <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Changes for PCI
In-Reply-To: <E15FfAV-0007GV-00@the-village.bc.nu>
Message-ID: <20010628234710.D1618-100000@>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Jun 2001, Alan Cox wrote:

> > beyond 256 physical busses in 2.4?  Maybe not.  But it is a simple
> > change and it does work and it works around the existing drivers which
> > compare busid+devfn for uniqueness when they really should compare
> > pci_dev pointers.  Should it be redone the correct way (domains) in
>
> I think it might be better to fix the needed drivers. I suspect ppc64 isnt
> going to need that man drivers handle with initially

As far as the Symbios driver is in concern, there is nothing to fix.

1) The bogus double reporting of PCI devices used (uses) 2 different
pci_dev structures.

2) The boot order has nothing to do with the kernel and must use the only
relevant way to identify PCI devices in a PCI BUS hierarchy (bus + devfn).

> > The patch does not handle the user mode case.  This leaves the X server
> > broken.  We could probably weed out busses beyond 256 under
> > /proc/bus/pci as a workaround -- meaning the video adapter (if any --
> > rare in these boxes) must be in one of the first I/O drawers.
>
> Or scan the busses for video cards and number those busses 0,1,2... then
> number the rest. Ugly but probably best for 2.4

Btw, the suggested PCI bus numbering change looks like utter hackery to
me... Seems some guys somewhere are abusing tequilla too much. :-)

  Gérard.

