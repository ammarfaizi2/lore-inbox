Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129516AbRBEWKK>; Mon, 5 Feb 2001 17:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129057AbRBEWKA>; Mon, 5 Feb 2001 17:10:00 -0500
Received: from chiara.elte.hu ([157.181.150.200]:32521 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129516AbRBEWJx>;
	Mon, 5 Feb 2001 17:09:53 -0500
Date: Mon, 5 Feb 2001 23:09:09 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Christoph Hellwig <hch@caldera.de>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
 /notify + callback chains
In-Reply-To: <20010205150354.E1167@redhat.com>
Message-ID: <Pine.LNX.4.30.0102052307560.11396-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Feb 2001, Stephen C. Tweedie wrote:

> > Obviously the disk access itself must be sector aligned and the total
> > length must be a multiple of the sector length, but there shouldn't be
> > any restrictions on the data buffers.
>
> But there are. Many controllers just break down and corrupt things
> silently if you don't align the data buffers (Jeff Merkey found this
> by accident when he started generating unaligned IOs within page
> boundaries in his NWFS code). And a lot of controllers simply cannot
> break a sector dma over a page boundary (at least not without some
> form of IOMMU remapping).

so we are putting workarounds for hardware bugs into the design?

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
