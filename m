Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129115AbRBFXDy>; Tue, 6 Feb 2001 18:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129229AbRBFXDo>; Tue, 6 Feb 2001 18:03:44 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:49934 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129093AbRBFXD1>; Tue, 6 Feb 2001 18:03:27 -0500
Date: Tue, 6 Feb 2001 19:13:59 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jens Axboe <axboe@suse.de>, Manfred Spraul <manfred@colorfullife.com>,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.10.10102061421490.1825-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0102061900060.23574-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Feb 2001, Linus Torvalds wrote:

> Remember: in the end you HAVE to wait somewhere. You're always going to be
> able to generate data faster than the disk can take it. SOMETHING has to
> throttle - if you don't allow generic_make_request() to throttle, you have
> to do it on your own at some point. It is stupid and counter-productive to
> argue against throttling. The only argument can be _where_ that throttling
> is done, and READA/WRITEA leaves the possibility open of doing it
> somewhere else (or just delaying it and letting a future call with
> READ/WRITE do the throttling).

Its not "arguing against throttling". 

Its arguing against making a smart application block on the disk while its
able to use the CPU for other work.
 
An application which sets non blocking behavior and busy waits for a
request (which seems to be your argument) is just stupid, of course.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
