Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRBFS7M>; Tue, 6 Feb 2001 13:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129754AbRBFS7C>; Tue, 6 Feb 2001 13:59:02 -0500
Received: from chiara.elte.hu ([157.181.150.200]:27658 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129383AbRBFS6n>;
	Tue, 6 Feb 2001 13:58:43 -0500
Date: Tue, 6 Feb 2001 19:58:04 +0100 (CET)
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
In-Reply-To: <Pine.LNX.4.30.0102061338380.15204-100000@today.toronto.redhat.com>
Message-ID: <Pine.LNX.4.30.0102061955380.7919-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Feb 2001, Ben LaHaise wrote:

> 	- reduce the overhead in submitting block ios, especially for
> 	  large ios. Look at the %CPU usages differences between 512 byte
> 	  blocks and 4KB blocks, this can be better.

my system is already submitting 4KB bhs. If anyone's raw-IO setup submits
512 byte bhs thats a problem of the raw IO code ...

> 	- make asynchronous io possible in the block layer.  This is
> 	  impossible with the current ll_rw_block scheme and io request
> 	  plugging.

why is it impossible?

> You mentioned non-spindle base io devices in your last message.  Take
> something like a big RAM disk. Now compare kiobuf base io to buffer
> head based io. Tell me which one is going to perform better.

roughly equal performance when using 4K bhs. And a hell of a lot more
complex and volatile code in the kiobuf case.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
