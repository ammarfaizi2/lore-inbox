Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVFYMhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVFYMhW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 08:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbVFYMhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 08:37:21 -0400
Received: from [81.2.110.250] ([81.2.110.250]:24766 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261216AbVFYMfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 08:35:14 -0400
Subject: Re: PATCH: IDE - sensible probing for PCI systems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61L.0506241217490.28452@blysk.ds.pg.gda.pl>
References: <1119356601.3279.118.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0506211422190.9446@blysk.ds.pg.gda.pl>
	 <1119363150.3325.151.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0506211535100.17779@blysk.ds.pg.gda.pl>
	 <1119379587.3325.182.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0506231903170.31113@blysk.ds.pg.gda.pl>
	 <1119566026.18655.30.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0506241217490.28452@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119702761.28649.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 25 Jun 2005 13:32:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-06-24 at 12:52, Maciej W. Rozycki wrote:
>  Well, keyboard and mouse are USB these days, serial and parallel are PCI, 
> floppies are not used anymore and the ISA DMA controller would only be 
> needed for them.  Video?  I've thought ISA implementations are gone -- 
> what is all that AGP/PCI-E noise about then?  And no more ISA slots 
> either.

PC systems have serial at 0x3f8/0x2f8 (lpc bus), almost always PS/2 port
on the mainboard. Timers, interrupt controllers. 

> logic, though, which hasn't been moved elsewhere, indeed.  I think it 
> really belongs to the PCI configuration space somewhere -- probably I/O 
> APICs or host bridges.

As I understand it both Windows XP and Linux x86 still require some of
these ports. There is also a range of ports that are needed _before_ the
PCI bus can be used in order to bootstrap the system, configure ram
timings etc and in some cases adjust the caches.

> > also have ranges of non-PCI decoded space that appears in no PCI bar.
> 
>  That is what surprises me and what my whole consideration is about.  
> It's just I don't see a need for such a setup anymore and for a system 
> with no ISA or EISA bridge I'd expect all that legacy to be gone leaving 
> us with no need to handle implicit resources.  But has any manufacturer 
> produced such an i386 system yet?

Whats the _economic_ incentive to do so ? There basically isnt one.

