Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267871AbRGRMw6>; Wed, 18 Jul 2001 08:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267872AbRGRMws>; Wed, 18 Jul 2001 08:52:48 -0400
Received: from mail.gris.uni-tuebingen.de ([134.2.176.16]:13584 "HELO
	mail.gris.uni-tuebingen.de") by vger.kernel.org with SMTP
	id <S267871AbRGRMwb>; Wed, 18 Jul 2001 08:52:31 -0400
Date: Wed, 18 Jul 2001 14:52:35 +0200 (CEST)
From: Alexander Ehlert <alexander.ehlert@uni-tuebingen.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Alexander Ehlert <alexander.ehlert@uni-tuebingen.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Right Semantics for ioremap, remap_page_range
In-Reply-To: <Pine.LNX.3.95.1010718082115.17113A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.32.0107181445110.809-100000@frodo.sau98.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in the meantime I got it running, just some board setup issues,
I had to introduce some udelays() at the right spot :)

> designed to be used with readl() readw() readb(), writel(), etc.
> For large arrays, you use copy/to/from_io().  It is possible to

Thats what I do anyway.

> than it probably already is. The assumption seems to be that
> when Apple comes out with a 256 bit machine with 128 bit PCI
> and 32, 40 GHz CPUs, you just recompile everything and it will run );

Yeah, there are only about 5 boards at the present time :)

> If your driver is never going to be used for anything but
> a private experiment, the value of a pointer to the remapped
> area is (usually) the (address_you_asked_for) | PAGE_OFFSET.

What I now do is ioremap_nocache and do writel's, readl's on it.
For the mmap stuff, I just call remap_page_range with the physical
address that I get from pci_resource_start(). Is that alright?
I mean it's working for me now, thats most important :)

Cheers, Alex

-- 

When I was younger, I could remember anything, whether it had happened
or not; but my faculties are decaying now and soon I shall be so I
cannot remember any but the things that never happened.  It is sad to
go to pieces like this but we all have to do it.
		-- Mark Twain

