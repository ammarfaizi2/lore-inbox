Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVF0QaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVF0QaS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 12:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVF0Q14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 12:27:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12307 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261399AbVF0QYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 12:24:45 -0400
Date: Mon, 27 Jun 2005 17:24:39 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: IDE - sensible probing for PCI systems
Message-ID: <20050627172439.C17140@flint.arm.linux.org.uk>
Mail-Followup-To: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1119356601.3279.118.camel@localhost.localdomain> <Pine.LNX.4.61L.0506211422190.9446@blysk.ds.pg.gda.pl> <1119363150.3325.151.camel@localhost.localdomain> <Pine.LNX.4.61L.0506211535100.17779@blysk.ds.pg.gda.pl> <1119379587.3325.182.camel@localhost.localdomain> <Pine.LNX.4.61L.0506231903170.31113@blysk.ds.pg.gda.pl> <1119566026.18655.30.camel@localhost.localdomain> <Pine.LNX.4.61L.0506241217490.28452@blysk.ds.pg.gda.pl> <1119702761.28649.2.camel@localhost.localdomain> <Pine.LNX.4.61L.0506271519060.23903@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61L.0506271519060.23903@blysk.ds.pg.gda.pl>; from macro@linux-mips.org on Mon, Jun 27, 2005 at 03:55:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 03:55:39PM +0100, Maciej W. Rozycki wrote:
> On Sat, 25 Jun 2005, Alan Cox wrote:
> 
> > PC systems have serial at 0x3f8/0x2f8 (lpc bus), almost always PS/2 port
> 
>  Strange -- boxes have started to appear that have no connectors or at 
> least PCB headers for them.  What's the point in removing connectors and 
> leaving the (otherwise useful) hardware inaccessible?

It's far easier for a mobo manufacturer to remove the connectors and
PCB tracking for the connections.  For all we know, PCI southbridges
with serial ports integrated into them may still be cheaper in quantity
than ones without - so if mobo manufacturers want to get rid of the
serial ports their easiest way is to omit the connectors and associated
PCB tracks.

> > >  That is what surprises me and what my whole consideration is about.  
> > > It's just I don't see a need for such a setup anymore and for a system 
> > > with no ISA or EISA bridge I'd expect all that legacy to be gone leaving 
> > > us with no need to handle implicit resources.  But has any manufacturer 
> > > produced such an i386 system yet?
> > 
> > Whats the _economic_ incentive to do so ? There basically isnt one.
> 
>  One chip less?  Well, perhaps the cost of R&D for such a system would 
> exceed the total cost of keeping that chip included in all boards 
> manufactured during the term corporate planning is able to cover....

The southbridge typically contains the other things like the RTC, etc.
What you're suggesting isn't just a case of "removing a chip" - it's
more a case of designing a replacement without a lot of the legacy
stuff in.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
