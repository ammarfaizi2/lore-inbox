Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130673AbRBGAmm>; Tue, 6 Feb 2001 19:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130738AbRBGAmf>; Tue, 6 Feb 2001 19:42:35 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:2566 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130673AbRBGAmZ>; Tue, 6 Feb 2001 19:42:25 -0500
Date: Tue, 6 Feb 2001 16:42:14 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@redhat.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.32.0102061924300.24366-100000@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.10.10102061641300.2045-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Feb 2001, Ingo Molnar wrote:
> 
> On Wed, 7 Feb 2001, Stephen C. Tweedie wrote:
> 
> > No, it is a problem of the ll_rw_block interface: buffer_heads need to
> > be aligned on disk at a multiple of their buffer size.  Under the Unix
> > raw IO interface it is perfectly legal to begin a 128kB IO at offset
> > 512 bytes into a device.
> 
> then we should either fix this limitation, or the raw IO code should split
> the request up into several, variable-size bhs, so that the range is
> filled out optimally with aligned bhs.

As mentioned, no such limitation exists if you just use the right
interfaces.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
