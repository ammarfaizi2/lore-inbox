Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129612AbRBHNzB>; Thu, 8 Feb 2001 08:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129388AbRBHNyv>; Thu, 8 Feb 2001 08:54:51 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:1041 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129612AbRBHNyh>; Thu, 8 Feb 2001 08:54:37 -0500
Date: Thu, 8 Feb 2001 10:03:19 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
        Jens Axboe <axboe@suse.de>, Manfred Spraul <manfred@colorfullife.com>,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <20010208132218.E9130@redhat.com>
Message-ID: <Pine.LNX.4.21.0102081000450.25219-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Feb 2001, Stephen C. Tweedie wrote:

<snip>

> > How do you write high-performance ftp server without threads if select
> > on regular file always returns "ready"?
> 
> Select can work if the access is sequential, but async IO is a more
> general solution.

Even async IO (ie aio_read/aio_write) should block on the request queue if
its full in Linus mind.








-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
