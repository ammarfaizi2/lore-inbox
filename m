Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129934AbRBGAgU>; Tue, 6 Feb 2001 19:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130564AbRBGAgL>; Tue, 6 Feb 2001 19:36:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12563 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129934AbRBGAfy>;
	Tue, 6 Feb 2001 19:35:54 -0500
Date: Wed, 7 Feb 2001 01:35:23 +0100
From: Jens Axboe <axboe@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010207013523.C9013@suse.de>
In-Reply-To: <Pine.LNX.4.30.0102061437250.15204-100000@today.toronto.redhat.com> <Pine.LNX.4.30.0102062052110.8926-100000@elte.hu> <20010207002107.L1167@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010207002107.L1167@redhat.com>; from sct@redhat.com on Wed, Feb 07, 2001 at 12:21:07AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07 2001, Stephen C. Tweedie wrote:
> > [overhead of 512-byte bhs in the raw IO code is an artificial problem of
> > the raw IO code.]
> 
> No, it is a problem of the ll_rw_block interface: buffer_heads need to
> be aligned on disk at a multiple of their buffer size.  Under the Unix
> raw IO interface it is perfectly legal to begin a 128kB IO at offset
> 512 bytes into a device.

Submitting buffers to lower layers that are not hw sector aligned
can't be supported below ll_rw_blk anyway (they can, but look at the
problems this has always created), and I would much rather see stuff
like this handled outside of there.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
