Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130174AbRBFTgF>; Tue, 6 Feb 2001 14:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130177AbRBFTfz>; Tue, 6 Feb 2001 14:35:55 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30993 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130174AbRBFTfn>;
	Tue, 6 Feb 2001 14:35:43 -0500
Date: Tue, 6 Feb 2001 20:35:25 +0100
From: Jens Axboe <axboe@suse.de>
To: Ben LaHaise <bcrl@redhat.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010206203525.B2975@suse.de>
In-Reply-To: <20010206190018.E580@suse.de> <Pine.LNX.4.30.0102061301310.15204-100000@today.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0102061301310.15204-100000@today.toronto.redhat.com>; from bcrl@redhat.com on Tue, Feb 06, 2001 at 01:09:09PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06 2001, Ben LaHaise wrote:
> > > As for io completion, can't we just issue seperate requests for the
> > > critical data and the readahead?  That way for SCSI disks, the important
> > > io should be finished while the readahead can continue.  Thoughts?
> >
> > Priorities?
> 
> Definately.  I'd like to be able to issue readaheads with a "don't bother
> executing if this request unless the cost is low" bit set.  It might also
> be helpful for heavy multiuser loads (or even a single user with multiple
> processes) to ensure progress is made for others.

And in other contexts too it might be handy to assign priorities to
requests as well. I don't know how sgi plan on handling grio (or already
handle it in irix), maybe Steve can fill us in on that :)

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
