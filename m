Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBHPrM>; Thu, 8 Feb 2001 10:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129051AbRBHPrD>; Thu, 8 Feb 2001 10:47:03 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:1554 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129031AbRBHPqz>; Thu, 8 Feb 2001 10:46:55 -0500
Date: Thu, 8 Feb 2001 16:46:12 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: "Stephen C. Tweedie" <sct@redhat.com>, Pavel Machek <pavel@suse.cz>,
        Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.21.0102081000450.25219-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.3.96.1010208164448.9024C-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > How do you write high-performance ftp server without threads if select
> > > on regular file always returns "ready"?
> > 
> > Select can work if the access is sequential, but async IO is a more
> > general solution.
> 
> Even async IO (ie aio_read/aio_write) should block on the request queue if
> its full in Linus mind.

This is not problem (you can create queue big enough to handle the load).

The problem is that aio_read and aio_write are pretty useless for ftp or
http server. You need aio_open.

Mikulas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
