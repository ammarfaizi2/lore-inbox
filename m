Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129763AbRBHPeT>; Thu, 8 Feb 2001 10:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129051AbRBHPd7>; Thu, 8 Feb 2001 10:33:59 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:7697 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129031AbRBHPdv>; Thu, 8 Feb 2001 10:33:51 -0500
Date: Thu, 8 Feb 2001 11:44:25 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Ben LaHaise <bcrl@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>, Ingo Molnar <mingo@elte.hu>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.30.0102080927400.23469-100000@today.toronto.redhat.com>
Message-ID: <Pine.LNX.4.21.0102081141050.25350-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Feb 2001, Ben LaHaise wrote:

<snip>

> > (besides, latency would suck. I bet you're better off waiting for the
> > requests if they are all used up. It takes too long to get deep into the
> > kernel from user space, and you cannot use the exclusive waiters with its
> > anti-herd behaviour etc).
> 
> Ah, but no.  In fact for some things, the wait queue extensions I'm using
> will be more efficient as things like test_and_set_bit for obtaining a
> lock gets executed without waking up a task.

The latency argument is somewhat bogus because there is no problem to
check the request queue, in the aio syscalls, and simply fail if its full.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
