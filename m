Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263134AbRE1TlK>; Mon, 28 May 2001 15:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263144AbRE1TlA>; Mon, 28 May 2001 15:41:00 -0400
Received: from [130.113.218.59] ([130.113.218.59]:11080 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S263143AbRE1Tko>; Mon, 28 May 2001 15:40:44 -0400
Date: Mon, 28 May 2001 15:39:00 -0400 (EDT)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: Jens Axboe <axboe@suse.de>
cc: andre@linux-ide.org, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [patch]: ide dma timeout retry in pio
In-Reply-To: <20010528203421.N9102@suse.de>
Message-ID: <Pine.LNX.4.10.10105281533400.25183-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> request, when we hit a dma timout. In this case, what we really want to
> do is retry the request in pio mode and revert to normal dma operations
> later again.

really?  do we know the nature of the DMA engine problem well enough?
is there a reason to believe that it'll work better "later"?
I guess I was surprised at resorting to PIO - couldn't we just
break the request up into smaller chunks, still using DMA?

I seem to recall Andre saying that the problem arises when the 
ide DMA engine looses PCI arbitration during a burst.  shorter 
bursts would seem like the best workaround if this is the problem...

resorting to PIO would be such a shame, not only because it eats
CPU so badly, but also because it has no checksum like UDMA...

thanks, mark hahn.

