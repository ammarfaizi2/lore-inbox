Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130623AbRBGA2k>; Tue, 6 Feb 2001 19:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130624AbRBGA2a>; Tue, 6 Feb 2001 19:28:30 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:22065 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S130623AbRBGA2M>; Tue, 6 Feb 2001 19:28:12 -0500
Date: Tue, 6 Feb 2001 19:25:19 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: <mingo@devserv.devel.redhat.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <20010207002107.L1167@redhat.com>
Message-ID: <Pine.LNX.4.32.0102061924300.24366-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Feb 2001, Stephen C. Tweedie wrote:

> No, it is a problem of the ll_rw_block interface: buffer_heads need to
> be aligned on disk at a multiple of their buffer size.  Under the Unix
> raw IO interface it is perfectly legal to begin a 128kB IO at offset
> 512 bytes into a device.

then we should either fix this limitation, or the raw IO code should split
the request up into several, variable-size bhs, so that the range is
filled out optimally with aligned bhs.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
