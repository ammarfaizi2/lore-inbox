Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135469AbRBERZS>; Mon, 5 Feb 2001 12:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135470AbRBERZI>; Mon, 5 Feb 2001 12:25:08 -0500
Received: from zeus.kernel.org ([209.10.41.242]:1514 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S135469AbRBERYu>;
	Mon, 5 Feb 2001 12:24:50 -0500
Date: Mon, 5 Feb 2001 17:20:42 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Christoph Hellwig <hch@caldera.de>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010205172042.O1167@redhat.com>
In-Reply-To: <20010205150354.E1167@redhat.com> <E14PnQ8-0003WC-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E14PnQ8-0003WC-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Feb 05, 2001 at 03:19:09PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 05, 2001 at 03:19:09PM +0000, Alan Cox wrote:
> > Yes, it's the sort of thing that you would hope should work, but in
> > practice it's not reliable.
> 
> So the less smart devices need to call something like
> 
> 	kiovec_align(kiovec, 512);
> 
> and have it do the bounce buffers ?

_All_ drivers would have to do that in the degenerate case, because
none of our drivers can deal with a dma boundary in the middle of a
sector, and even in those places where the hardware supports it in
theory, you are still often limited to word-alignment.

--Stephen

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
