Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267800AbUG3TaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267800AbUG3TaY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 15:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267797AbUG3TaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 15:30:24 -0400
Received: from web14929.mail.yahoo.com ([216.136.225.94]:14990 "HELO
	web14929.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267801AbUG3TaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 15:30:12 -0400
Message-ID: <20040730193011.5239.qmail@web14929.mail.yahoo.com>
Date: Fri, 30 Jul 2004 12:30:11 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Exposing ROM's though sysfs
To: Matthew Wilcox <willy@debian.org>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20040730190456.GZ10025@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Matthew Wilcox <willy@debian.org> wrote:

> My problem is with this is the following passage from PCI 2.2 and PCI
> 2.3:
> 
>   In order to minimize the number of address decoders needed, a
> device
>   may share a decoder between the Expansion ROM Base Address register
> and
>   other Base Address registers.  When expansion ROM decode is
> enabled, ...
>
> On Fri, Jul 30, 2004 at 11:59:21AM -0700, Jon Smirl wrote:
> > Alan Cox knows more about this, but I believe there is only one PCI
> > card in existence that does this.
> 
> Strange; he was the one who pointed out this requirement to me in the
> first place and he hinted that many devices did this.

Alan, what's the answer here?

> Shutting off interrupts isn't nearly enough.  Any other CPU could
> access the device, or indeed any device capable of DMA could

Another idea, it's ok to read the ROM when there is no device driver
loaded. When the driver for one of these card loads it could trigger a
copy of the ROM into RAM and cache it in a PCI structure.

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - Helps protect you from nasty viruses.
http://promotions.yahoo.com/new_mail
