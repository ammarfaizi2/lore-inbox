Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292728AbSCDSxR>; Mon, 4 Mar 2002 13:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292714AbSCDSxO>; Mon, 4 Mar 2002 13:53:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39691 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292701AbSCDSvv>;
	Mon, 4 Mar 2002 13:51:51 -0500
Message-ID: <3C83C258.FCF57746@mandrakesoft.com>
Date: Mon, 04 Mar 2002 13:52:08 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Dillow <dillowd@y12.doe.gov>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IBM Lanstreamer bugfixes (round 3)
In-Reply-To: <Pine.LNX.4.33.0203041023580.11065-100000@janetreno.austin.ibm.com>
		 <3C83A925.F93BF448@mandrakesoft.com> <3C83AE6B.9B5DE85F@y12.doe.gov> <3C83B2E7.B5EB0FB5@mandrakesoft.com> <3C83C0B8.659F1AE@y12.doe.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Dillow wrote:
> 
> Jeff Garzik wrote:
> >
> > David Dillow wrote:
> > >
> > > Jeff Garzik wrote:
> > > > Set cache line size just like drivers/net/acenic.c does, and enable
> > > > memory-write-invalidate...
> > >
> > > Does this mean the setup pci_enable_device() does on the cache line size
> > > is not sufficient?
> >
> > pci_enable_device doesn't touch the PCI_COMMAND_INVALIDATE bit at all...
> 
> Right, I was talking more about the cache line size... is it sufficient
> for that?

pci_enable_device doesn't touch PCI_COMMAND_INVALIDATE either, on most
platforms (particularly ia32, i.e. the popular one :))


> As for PCI_COMMAND_INVALIDATE, what does that do for me; my PCI spec
> isn't handy....

Enables Memory-Write-Invalidate (MWI).


> > > I ask, because I've been relying on it for a driver I'm working on;
> > > should I be setting this as acenic does? It would seem that this is
> > > something many drivers would need to do...
> >
> > Yes, acenic is the code to copy, for setting that up.
> 
> INVALIDATE, or cache line size?

both.

	Jeff



-- 
Jeff Garzik      |
Building 1024    |
MandrakeSoft     | Choose life.
