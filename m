Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129249AbRBFUuO>; Tue, 6 Feb 2001 15:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129364AbRBFUuE>; Tue, 6 Feb 2001 15:50:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:6674 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129249AbRBFUt6>;
	Tue, 6 Feb 2001 15:49:58 -0500
Date: Tue, 6 Feb 2001 21:49:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Ben LaHaise <bcrl@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010206214904.F2975@suse.de>
In-Reply-To: <Pine.LNX.4.30.0102062052110.8926-100000@elte.hu> <Pine.LNX.4.30.0102061521270.15204-100000@today.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0102061521270.15204-100000@today.toronto.redhat.com>; from bcrl@redhat.com on Tue, Feb 06, 2001 at 03:25:00PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06 2001, Ben LaHaise wrote:
> =)  This is what I'm seeing: lots of processes waiting with wchan ==
> __get_request_wait.  With async io and a database flushing lots of io
> asynchronously spread out across the disk, the NR_REQUESTS limit is hit
> very quickly.

You can't do async I/O this way! In going what Linus said, make submit_bh
return an int telling you if it failed to queue the buffer and use
READA/WRITEA to submit it.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
