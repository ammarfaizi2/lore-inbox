Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266870AbTGGIHj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 04:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266872AbTGGIHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 04:07:39 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:36876
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S266870AbTGGIHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 04:07:36 -0400
Date: Mon, 7 Jul 2003 01:17:21 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ryan Mack <lists@mackman.net>,
       Markus Plail <linux-kernel@gitteundmarkus.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21 ServerWorks DMA Bugs
In-Reply-To: <20030707034217.GD303@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.10.10307070114140.32069-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is the skinny!

SGlist with a 2 byte boundary error on the FIFO's 510-511 or is 509-510

It all is determined on if 1 or 0 is starting as the counting number.
The FIFO flush to generate the interrupt is a DMA quirk.  Similar to the
the 8K FIFO Phy issues in SATA.

Buy me a Coke (Red Can, no BLUE Crap) and we can discuss the issues.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Mon, 7 Jul 2003, Tomas Szepe wrote:

> > [andre@linux-ide.org]
> > 
> > Caution!
> > 
> > Serverworks has OEM's who have BIOS's which are setup for a reason.
> > If the BIOS is configured for any reason the the driver stomps on the BIOS
> > settings there will be damage to the content on the media.
> > 
> > Just the view from an insider in the know.
> 
> Hmm, I certainly wouldn't expect a $3500 server to come with busted
> IDE, but thanks for the suggestion, we'll take extra care.
> 
> -- 
> Tomas Szepe <szepe@pinerecords.com>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

