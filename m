Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129292AbRBFUvd>; Tue, 6 Feb 2001 15:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129364AbRBFUvY>; Tue, 6 Feb 2001 15:51:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10258 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129292AbRBFUvS>;
	Tue, 6 Feb 2001 15:51:18 -0500
Date: Tue, 6 Feb 2001 21:50:53 +0100
From: Jens Axboe <axboe@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010206215053.G2975@suse.de>
In-Reply-To: <Pine.LNX.4.30.0102061521270.15204-100000@today.toronto.redhat.com> <3A806177.59304E88@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A806177.59304E88@colorfullife.com>; from manfred@colorfullife.com on Tue, Feb 06, 2001 at 09:41:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06 2001, Manfred Spraul wrote:
> > =)  This is what I'm seeing: lots of processes waiting with wchan ==
> > __get_request_wait.  With async io and a database flushing lots of io
> > asynchronously spread out across the disk, the NR_REQUESTS limit is hit
> > very quickly.
> >
> Has that anything to do with kiobuf or buffer head?

Nothing

> Several kernel functions need a "dontblock" parameter (or a callback, or
> a waitqueue address, or a tq_struct pointer). 

We don't even need that, non-blocking is implicitly applied with READA.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
