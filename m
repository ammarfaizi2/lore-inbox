Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130944AbRBGBKm>; Tue, 6 Feb 2001 20:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130826AbRBGBKd>; Tue, 6 Feb 2001 20:10:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:31763 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130944AbRBGBKU>;
	Tue, 6 Feb 2001 20:10:20 -0500
Date: Wed, 7 Feb 2001 02:09:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010207020957.B14105@suse.de>
In-Reply-To: <20010206190050.B23960@vger.timpanogas.org> <Pine.LNX.4.30.0102070205430.14696-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0102070205430.14696-100000@elte.hu>; from mingo@elte.hu on Wed, Feb 07, 2001 at 02:06:27AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07 2001, Ingo Molnar wrote:
> > > So I would appreciate pointers to these devices that break so we
> > > can inspect them.
> > >
> > > --
> > > Jens Axboe
> >
> > Adaptec drivers had an oops.  Also, AIC7XXX also had some oops with it.
> 
> most likely some coding error on your side. buffer-size mismatches should
> show up as filesystem corruption or random DMA scribble, not in-driver
> oopses.

I would suspect so, aic7xxx shouldn't care about anything except the
sg entries and I would seriously doubt that it makes any such
assumptions on them :-)

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
