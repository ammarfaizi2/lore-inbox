Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129630AbRBGB0e>; Tue, 6 Feb 2001 20:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129662AbRBGB0X>; Tue, 6 Feb 2001 20:26:23 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:9992 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129630AbRBGB0R>; Tue, 6 Feb 2001 20:26:17 -0500
Date: Tue, 6 Feb 2001 17:26:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>, Jens Axboe <axboe@suse.de>,
        "Stephen C. Tweedie" <sct@redhat.com>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.30.0102070205430.14696-100000@elte.hu>
Message-ID: <Pine.LNX.4.10.10102061724080.2193-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Feb 2001, Ingo Molnar wrote:
> 
> most likely some coding error on your side. buffer-size mismatches should
> show up as filesystem corruption or random DMA scribble, not in-driver
> oopses.

I'm not sure. If I was a driver writer (and I'm happy those days are
mostly behind me ;), I would not be totally dis-inclined to check for
various limits and things.

There can be hardware out there that simply has trouble with non-native
alignment, ie be unhappy about getting a 1kB request that is aligned in
memory at a 512-byte boundary. So there are real reasons why drivers might
need updating. Don't dismiss the concerns out-of-hand.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
