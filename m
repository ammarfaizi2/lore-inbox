Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129219AbRBFUgw>; Tue, 6 Feb 2001 15:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129571AbRBFUgm>; Tue, 6 Feb 2001 15:36:42 -0500
Received: from chiara.elte.hu ([157.181.150.200]:46858 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129219AbRBFUgh>;
	Tue, 6 Feb 2001 15:36:37 -0500
Date: Tue, 6 Feb 2001 21:35:58 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <20010206212503.A5426@caldera.de>
Message-ID: <Pine.LNX.4.30.0102062132250.10016-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Feb 2001, Christoph Hellwig wrote:

> The second is that bh's are two things:
>
>  - a cacheing object
>  - an io buffer
>
> This is not really an clean appropeach, and I would really like to get
> away from it.

caching bmap() blocks was a recent addition around 2.3.20, and i suggested
some time ago to cache pagecache blocks via explicit entries in struct
page. That would be one solution - but it creates overhead.

but there isnt anything wrong with having the bhs around to cache blocks -
think of it as a 'cached and recycled IO buffer entry, with the block
information cached'.

frankly, my quick (and limited) hack to abuse bhs to cache blocks just
cannot be a reason to replace bhs ...

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
