Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVGRTrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVGRTrA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 15:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVGRTrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 15:47:00 -0400
Received: from colo.lackof.org ([198.49.126.79]:22936 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261561AbVGRTrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 15:47:00 -0400
Date: Mon, 18 Jul 2005 13:51:41 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Jon Smirl <jonsmirl@gmail.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6] remove PCI_BRIDGE_CTL_VGA handling from setup-bus.c
Message-ID: <20050718195141.GE11016@colo.lackof.org>
References: <20050714155344.A27478@jurassic.park.msu.ru> <20050714145327.B7314@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050714145327.B7314@flint.arm.linux.org.uk>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 02:53:27PM +0100, Russell King wrote:
> On Thu, Jul 14, 2005 at 03:53:44PM +0400, Ivan Kokshaysky wrote:
> > The setup-bus code doesn't work correctly for configurations
> > with more than one display adapter in the same PCI domain.
> > This stuff actually is a leftover of an early 2.4 PCI setup code
> > and apparently it stopped working after some "bridge_ctl" changes.
> > So the best thing we can do is just to remove it and rely on the fact
> > that any firmware *has* to configure VGA port forwarding for the boot
> > display device properly.
> 
> What happens when there is no firmware?

I helped test/add bridge_ctl patch but PARISC general does NOT
support VGA at this time.

> I'm sure this code would not have been added had there not been a reason
> for it.  Do we know why it was added?

It was a replacement for the previous hacks and should represent essentially
the same functionality. I suspect we just didn't care about (or test)
multiheaded gfx at the time. Certainly not on parisc. This was in 2000/2001
timeframe originally.

grant
