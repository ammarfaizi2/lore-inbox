Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBNMua>; Wed, 14 Feb 2001 07:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129055AbRBNMuV>; Wed, 14 Feb 2001 07:50:21 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:7790 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129051AbRBNMuJ>; Wed, 14 Feb 2001 07:50:09 -0500
Date: Wed, 14 Feb 2001 06:49:43 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Alan Cox <alan@redhat.com>
cc: Donald Becker <becker@scyld.com>, Jes Sorensen <jes@linuxcare.com>,
        Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] starfire reads irq before pci_enable_device
In-Reply-To: <200102141237.f1ECbPh15777@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.3.96.1010214064743.13194A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Alan Cox wrote:
> > There was not a bug in the driver.  The bug was/is in the protocol handling
> > code.  The protocol handling code *must* be able to handle unaligned IP
> > headers.

> It does. It does so on IA64 now as well. The only architecture which has troubles
> with alignment on IP frames now is ARM2

So the IA64-specific PKT_CAN_COPY code in starfire can go away
completely?  Jes, can you test such w/ the latest kernel and starfire,
less your IA64-specific code?

The starfire update has never gone to Linus because this issue was
unresolved...

	Jeff




