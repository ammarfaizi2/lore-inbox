Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293131AbSDMSSR>; Sat, 13 Apr 2002 14:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293132AbSDMSSQ>; Sat, 13 Apr 2002 14:18:16 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:21006
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S293131AbSDMSSQ>; Sat, 13 Apr 2002 14:18:16 -0400
Date: Sat, 13 Apr 2002 11:15:41 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: VIA, 32bit PIO and 2.5.x kernel
In-Reply-To: <E16wRU9-0000hL-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10204131059000.489-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Apr 2002, Alan Cox wrote:

> > > The global "wheee I'm a poor and can't afford 32 bit IO" option will remain
> > > there of course.
> > > 
> > > So we have no  issue here. OK?
> 
> What if the user doesn't know the precise innards of their hardware. IDE
> more than anything else has to automagically do the right thing. Given the
> size of the PIO transfer loop and the way for some boards its weirdly 
> dependant on hardware magic and wonder is there any reason for not just 
> making the host controller provide the function or reference an ide library
> function for "sane" hardware ?

You are making a nice case to not set 32-bit for PIO.
I never run 32-bit PIO in development because of the false results you end
up seeing.

For the formal record: The ATA interface data transfers are done 16-bits
	(2 bytes) at a time in PIO and DMA.

PERIOD!

Andre Hedrick
LAD Storage Consulting Group

