Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRAISgL>; Tue, 9 Jan 2001 13:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129792AbRAISgC>; Tue, 9 Jan 2001 13:36:02 -0500
Received: from chiara.elte.hu ([157.181.150.200]:26124 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129436AbRAISf4>;
	Tue, 9 Jan 2001 13:35:56 -0500
Date: Tue, 9 Jan 2001 19:35:28 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "Benjamin C.R. LaHaise" <blah@kvack.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Christoph Hellwig <hch@caldera.de>,
        "David S. Miller" <davem@redhat.com>, <riel@conectiva.com.br>,
        <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <Pine.LNX.3.96.1010109114407.5051E-100000@kanga.kvack.org>
Message-ID: <Pine.LNX.4.30.0101091928460.7155-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2001, Benjamin C.R. LaHaise wrote:

> I've already got fully async read and write working via a helper thread
                                                      ^^^^^^^^^^^^^^^^^^^
> for doing the bmaps when the page is not uptodate in the page cache.
  ^^^^^^^^^^^^^^^^^^^

thats what TUX 2.0 does. (it does async reads at the moment.)

> The primatives for async locking of pages and waiting on events such
> that converting ext2 to performing full async bmap should be trivial.

well - if you think it's trivial (ie. no process context, no helper thread
will be needed), more power to you. How are you going to assure that the
issuing process does not block during the bmap()? [without extensive
lowlevel-FS changes that is.]

> Note that O_NONBLOCK is not good enough because you can't implement an
> asynchronous O_SYNC write with it.

(i'm using it for reads only.)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
