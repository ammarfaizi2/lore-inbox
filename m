Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129212AbRBFSgR>; Tue, 6 Feb 2001 13:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129488AbRBFSf5>; Tue, 6 Feb 2001 13:35:57 -0500
Received: from chiara.elte.hu ([157.181.150.200]:25098 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129212AbRBFSf4>;
	Tue, 6 Feb 2001 13:35:56 -0500
Date: Tue, 6 Feb 2001 19:35:17 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ben LaHaise <bcrl@redhat.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.30.0102061321110.15204-100000@today.toronto.redhat.com>
Message-ID: <Pine.LNX.4.30.0102061932040.7249-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Feb 2001, Ben LaHaise wrote:

> > - higher levels do not have the kind of state to eg. merge requests done
> >   by different users. The only chance for merging is often the lowest
> >   level, where we already know what disk, which sector.
>
> That's what a readaround buffer is for, [...]

If you are merging based on (device, offset) values, then that's lowlevel
- and this is what we have been doing for years.

If you are merging based on (inode, offset), then it has flaws like not
being able to merge through a loopback or stacked filesystem.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
