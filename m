Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262728AbRFDSHq>; Mon, 4 Jun 2001 14:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264343AbRFDRxG>; Mon, 4 Jun 2001 13:53:06 -0400
Received: from [194.128.63.73] ([194.128.63.73]:43690 "EHLO
	fuspcnjc.culham.ukaea.org.uk") by vger.kernel.org with ESMTP
	id <S264340AbRFDR1N>; Mon, 4 Jun 2001 13:27:13 -0400
Message-ID: <3B1BC572.A0591812@ukaea.org.uk>
Date: Mon, 04 Jun 2001 18:29:22 +0100
From: Neil Conway <nconway.list@ukaea.org.uk>
Organization: UKAEA Fusion
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE corruption, 2.2, VIA chipset in PIO mode
In-Reply-To: <E156xkJ-0005d3-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Used for a while, copied about 7gigs onto it.  Then got lots of BadCRC
> > errors when reading from disk (from dma_intr).  Decided to disable DMA
> > as a result of this...
> 
> Cable errors. Disabling DMA also disabled error checking and correction

Jeez.  Crappity, crappity, crap.  Embarrassing mistake of the year.

I managed to convince myself that the cable couldn't possibly be
responsible, because we got corruption even when using UDMA-33 (which
protects from cable faults).  Somewhere in my logic I obviously lost the
plot, and forgot that I switched DMA off *before* seeing corruption.

Sigh.  Ah, I think I see a nice brown bag, in a nice deep hole.

Thank you for gently pointing out the error of my ways ;-)

Neil
