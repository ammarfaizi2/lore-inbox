Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129068AbRBFJpr>; Tue, 6 Feb 2001 04:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbRBFJp1>; Tue, 6 Feb 2001 04:45:27 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:28089 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S129068AbRBFJpP>; Tue, 6 Feb 2001 04:45:15 -0500
Date: Tue, 6 Feb 2001 10:22:52 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Stephen C. Tweedie" <sct@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Christoph Hellwig <hch@caldera.de>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.10.10102051658530.31998-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.10.10102060957380.7107-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 5 Feb 2001, Linus Torvalds wrote:

> > Does it has to be vectors? What about lists?
> 
> I'd prefer to avoid lists unless there is some overriding concern, like a
> real implementation issue. But I don't care much one way or the other -
> what I care about is that the setup and usage time is as low as possible.
> I suspect arrays are better for that.

I was more thinking about the higher layers. Here it's simpler to setup a
list of pages which can be send to a lower layer. In the page cache we
already have per address space lists, so it would be very easy to use
that. A lower layer can generate of course anything it wants out of this,
e.g. it can generate sublists or vectors.

bye, Roman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
