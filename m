Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129180AbRBFRJ2>; Tue, 6 Feb 2001 12:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129198AbRBFRJS>; Tue, 6 Feb 2001 12:09:18 -0500
Received: from zeus.kernel.org ([209.10.41.242]:56517 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129180AbRBFRJG>;
	Tue, 6 Feb 2001 12:09:06 -0500
Date: Tue, 6 Feb 2001 17:05:06 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010206170506.H1167@redhat.com>
In-Reply-To: <E14Pr8G-0003zV-00@the-village.bc.nu> <Pine.LNX.4.10.10102051118210.31206-100000@penguin.transmeta.com> <20010205205429.V1167@redhat.com> <20010206000704.F1167@redhat.com> <20010206180058.A15974@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010206180058.A15974@caldera.de>; from hch@caldera.de on Tue, Feb 06, 2001 at 06:00:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 06, 2001 at 06:00:58PM +0100, Christoph Hellwig wrote:
> On Tue, Feb 06, 2001 at 12:07:04AM +0000, Stephen C. Tweedie wrote:
> > 
> > Is that a realistic basis for a cleaned-up ll_rw_blk.c?
> 
> I don't think os.  If we minimize the state in the IO container object,
> the lower levels could split them at their guess and the IO completion
> function just has to handle the case that it might be called for a smaller
> object.

The whole point of the post was that it is merging, not splitting,
which is troublesome.  How are you going to merge requests without
having chains of scatter-gather entities each with their own
completion callbacks?

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
