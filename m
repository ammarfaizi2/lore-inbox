Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129063AbRBHP4f>; Thu, 8 Feb 2001 10:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129178AbRBHP4P>; Thu, 8 Feb 2001 10:56:15 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:13585 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129027AbRBHP4A>; Thu, 8 Feb 2001 10:56:00 -0500
Date: Thu, 8 Feb 2001 12:05:38 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
cc: "Stephen C. Tweedie" <sct@redhat.com>, Pavel Machek <pavel@suse.cz>,
        Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.3.96.1010208164448.9024C-100000@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.21.0102081202570.25475-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Feb 2001, Mikulas Patocka wrote:

> > > > How do you write high-performance ftp server without threads if select
> > > > on regular file always returns "ready"?
> > > 
> > > Select can work if the access is sequential, but async IO is a more
> > > general solution.
> > 
> > Even async IO (ie aio_read/aio_write) should block on the request queue if
> > its full in Linus mind.
> 
> This is not problem (you can create queue big enough to handle the load).

The point is that you want to be able to not block if the queue full (and
the queue size has nothing to do with that).

> The problem is that aio_read and aio_write are pretty useless for ftp or
> http server. You need aio_open.

Could you explain this? 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
