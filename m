Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130970AbRBGBMw>; Tue, 6 Feb 2001 20:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131010AbRBGBMm>; Tue, 6 Feb 2001 20:12:42 -0500
Received: from chiara.elte.hu ([157.181.150.200]:10763 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130970AbRBGBMY>;
	Tue, 6 Feb 2001 20:12:24 -0500
Date: Wed, 7 Feb 2001 02:11:46 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Jens Axboe <axboe@suse.de>
Cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <20010207020957.B14105@suse.de>
Message-ID: <Pine.LNX.4.30.0102070211060.14951-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Feb 2001, Jens Axboe wrote:

> > > Adaptec drivers had an oops.  Also, AIC7XXX also had some oops with it.
> >
> > most likely some coding error on your side. buffer-size mismatches should
> > show up as filesystem corruption or random DMA scribble, not in-driver
> > oopses.
>
> I would suspect so, aic7xxx shouldn't care about anything except the
> sg entries and I would seriously doubt that it makes any such
> assumptions on them :-)

yep - and not a single reference to b_size in aic7xxx.c.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
