Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284955AbRLKJqN>; Tue, 11 Dec 2001 04:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284954AbRLKJqD>; Tue, 11 Dec 2001 04:46:03 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43020 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S284951AbRLKJpx>; Tue, 11 Dec 2001 04:45:53 -0500
Date: Tue, 11 Dec 2001 10:45:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: Cory Bell <cory.bell@usa.net>
Cc: John Clemens <john@deater.net>, linux-kernel@vger.kernel.org
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
Message-ID: <20011211104546.A10682@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.33.0112101240180.15280-100000@pianoman.cluster.toy> <1008035585.17062.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1008035585.17062.22.camel@localhost.localdomain>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > My apologies, i misunderstood what you were saying before..  As an
> > additional data point, one person who tried my origional USB hack (moving
> > it to IRQ 11) also reported possible problems with PCMCIA not working
> > anymore... this isn't my experience however.  Also note that the Trident
> > BladeXP is also on IRQ11, not that linux should care.
> 
> PCMCIA (16-bit, not cardbus) ethernet/modem (only tried the modem) works
> fine for me with the patch. Haven't tried cardbus or multiple cards.

Yep, single PCMCIA card looks good even for me, it is two cards that
break, or swapping cards like crazy. I found out that disabling irq 5
(and 9?) in config.opts looks like a good trick. (You have to enable
something in compensation so you have enough irqs available, I let
pcmcia take irq 7).
								Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
