Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129089AbRBGA1A>; Tue, 6 Feb 2001 19:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129934AbRBGA0u>; Tue, 6 Feb 2001 19:26:50 -0500
Received: from zeus.kernel.org ([209.10.41.242]:14559 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129089AbRBGA0i>;
	Tue, 6 Feb 2001 19:26:38 -0500
Date: Wed, 7 Feb 2001 00:21:07 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Ben LaHaise <bcrl@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010207002107.L1167@redhat.com>
In-Reply-To: <Pine.LNX.4.30.0102061437250.15204-100000@today.toronto.redhat.com> <Pine.LNX.4.30.0102062052110.8926-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.30.0102062052110.8926-100000@elte.hu>; from mingo@elte.hu on Tue, Feb 06, 2001 at 08:57:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 06, 2001 at 08:57:13PM +0100, Ingo Molnar wrote:
> 
> [overhead of 512-byte bhs in the raw IO code is an artificial problem of
> the raw IO code.]

No, it is a problem of the ll_rw_block interface: buffer_heads need to
be aligned on disk at a multiple of their buffer size.  Under the Unix
raw IO interface it is perfectly legal to begin a 128kB IO at offset
512 bytes into a device.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
