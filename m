Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269187AbUJUARu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269187AbUJUARu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 20:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270512AbUJUARl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 20:17:41 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:8924 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S270506AbUJUANK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 20:13:10 -0400
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4176E08B.2050706@techsource.com>
References: <4176E08B.2050706@techsource.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098313825.12374.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 00:10:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-10-20 at 23:02, Timothy Miller wrote:
> - The card "just works" with Linux because, maybe, the drivers would go 
> into main-line

That bit ought to "just work" 8)

> - The drivers are easy to work on, since you don't ever have to guess 
> about anything.
> - The drivers are easy to debug because
>      (a) we document everything, and
>      (b) we'll talk to you.

Some other vendors pretty much did this but the takeup isn't that vast
because writing 3D drivers is not trivial (we have docs for about 5
cards and no drivers, some are pretty old some are fairly passable
cards)

> and they STILL don't document the internals of the BIOS so that the card 
> can be ported to a non-x86 system.  Furthermore, since all these vendors

Talking to one very large motherboard video company they actually can't
because the analogue side is done by the board vendor as is things like
the RAM choice.
 
> give me sufficient funding to produce an ASIC.  What this means is that 
> the design has to be small and simple and focus primarily on 2D 
> performance so that it can fit into an FPGA.

X actually needs very little functionality nowdays, although some of it
does not map well onto a generic 2D rendering card. Notably most 2D
engines lack alpha blend.

Essentially if you can do alpha, bitblit, blit from main memory and
a couple of fills and colour-expands X is happy.

> (1) Would the sales volumes of this product be enough to make it worth 
> producing (ie. profitable)?

I'm very dubious I must admit. 


I've actually always wondered what a hybrid video device would look like
for 3D. Doing the alpha blend and very basic operations only in the
hardware that are expensive in software - alpha and perhaps some of the
texture scaling, but walking textures in software, doing shaders in
software and so on.

Alan

