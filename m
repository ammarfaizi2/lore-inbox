Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131176AbRBERa7>; Mon, 5 Feb 2001 12:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135538AbRBERat>; Mon, 5 Feb 2001 12:30:49 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18693 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131176AbRBERak>; Mon, 5 Feb 2001 12:30:40 -0500
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
To: sct@redhat.com (Stephen C. Tweedie)
Date: Mon, 5 Feb 2001 17:29:47 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), sct@redhat.com (Stephen C. Tweedie),
        manfred@colorfullife.com (Manfred Spraul),
        torvalds@transmeta.com (Linus Torvalds),
        hch@caldera.de (Christoph Hellwig), lord@sgi.com (Steve Lord),
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
In-Reply-To: <20010205172042.O1167@redhat.com> from "Stephen C. Tweedie" at Feb 05, 2001 05:20:42 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14PpSY-0003lL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 	kiovec_align(kiovec, 512);
> > and have it do the bounce buffers ?
> 
> _All_ drivers would have to do that in the degenerate case, because
> none of our drivers can deal with a dma boundary in the middle of a
> sector, and even in those places where the hardware supports it in
> theory, you are still often limited to word-alignment.

Thats true for _block_ disk devices but if we want a generic kiovec then
if I am going from video capture to network I dont need to force anything more
than 4 byte align

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
