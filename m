Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129451AbRBFRZl>; Tue, 6 Feb 2001 12:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129500AbRBFRZV>; Tue, 6 Feb 2001 12:25:21 -0500
Received: from ns.caldera.de ([212.34.180.1]:60683 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129451AbRBFRZL>;
	Tue, 6 Feb 2001 12:25:11 -0500
Date: Tue, 6 Feb 2001 18:22:58 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010206182258.A17923@caldera.de>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Manfred Spraul <manfred@colorfullife.com>,
	Steve Lord <lord@sgi.com>, linux-kernel@vger.kernel.org,
	kiobuf-io-devel@lists.sourceforge.net,
	Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@redhat.com>
In-Reply-To: <E14Pr8G-0003zV-00@the-village.bc.nu> <Pine.LNX.4.10.10102051118210.31206-100000@penguin.transmeta.com> <20010205205429.V1167@redhat.com> <20010206000704.F1167@redhat.com> <20010206180058.A15974@caldera.de> <20010206170506.H1167@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20010206170506.H1167@redhat.com>; from sct@redhat.com on Tue, Feb 06, 2001 at 05:05:06PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2001 at 05:05:06PM +0000, Stephen C. Tweedie wrote:
> The whole point of the post was that it is merging, not splitting,
> which is troublesome.  How are you going to merge requests without
> having chains of scatter-gather entities each with their own
> completion callbacks?

The object passed down to the low-level driver just needs to ne able
to contain multiple end-io callbacks.  The decision what to call when
some of the scatter-gather entities fail is of course not so easy to
handle and needs further discussion.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
