Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130270AbRBFWOF>; Tue, 6 Feb 2001 17:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129286AbRBFWNz>; Tue, 6 Feb 2001 17:13:55 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:60941 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130272AbRBFWNr>; Tue, 6 Feb 2001 17:13:47 -0500
Date: Tue, 6 Feb 2001 14:13:11 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Jens Axboe <axboe@suse.de>, Ben LaHaise <bcrl@redhat.com>,
        Ingo Molnar <mingo@elte.hu>, "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <3A80733E.A570B6C7@colorfullife.com>
Message-ID: <Pine.LNX.4.10.10102061412270.1825-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Feb 2001, Manfred Spraul wrote:
> > 
> > The aio functions should NOT use READA/WRITEA. They should just use the
> > normal operations, waiting for requests.
> 
> But then you end with lots of threads blocking in get_request()

So?

What the HELL do you expect to happen if somebody writes faster than the
disk can take?

You don't lik ebusy-waiting. Fair enough.

So maybe blocking on a wait-queue is the right thing? Just MAYBE?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
