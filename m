Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267564AbUBSUcy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267557AbUBSUcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:32:54 -0500
Received: from bolt.sonic.net ([208.201.242.18]:50362 "EHLO bolt.sonic.net")
	by vger.kernel.org with ESMTP id S267565AbUBSUcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:32:48 -0500
Date: Thu, 19 Feb 2004 12:32:34 -0800
From: David Hinds <dhinds@sonic.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Silla Rizzoli <silla@netvalley.it>, linux-kernel@vger.kernel.org,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: 2.4.25 yenta problem and small fix/workaround
Message-ID: <20040219203234.GC1819@sonic.net>
References: <200402191222.45709.silla@netvalley.it> <Pine.LNX.4.58L.0402191011470.29796@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0402191011470.29796@logos.cnet>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004, Silla Rizzoli wrote:
>
> Inserting a PC Card in my laptop (IMB R40 2681) with kernel 2.4.25
> results in the following message:
>
> Feb 19 11:10:16 [kernel] cs: socket d603e000 voltage interrogation timed out
>
> This sometimes happens with 2.6.x too, but issuing cardctl insert
> 0 usually solves the problem, however in this case it didn't. I
> tried to modify all the pcmcia_core module parameters but to no
> avail, the socket remained dead.

That is a pisser.  What brand and model of laptop is this, exactly?
Did you ever use the pcmcia-cs modules on this laptop, and if so, did
they behave the same?  Does this happen with a specific card?  Which
one(s) are you using?  Does it happen if you hot insert the card, or
only if the card is inserted at startup?  What CardBus bridge do you
have (use 'lspci -v')?

As Marcello said, the change was introduced specifically to avoid this
sort of problem, on certain other laptops.

-- Dave
