Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131436AbQL2QeZ>; Fri, 29 Dec 2000 11:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131463AbQL2QeP>; Fri, 29 Dec 2000 11:34:15 -0500
Received: from d185fcbd7.rochester.rr.com ([24.95.203.215]:16646 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S131436AbQL2QeC>; Fri, 29 Dec 2000 11:34:02 -0500
Date: Fri, 29 Dec 2000 11:03:21 -0500
From: Chris Mason <mason@suse.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
Message-ID: <267620000.978105801@tiny>
In-Reply-To: <Pine.LNX.4.10.10012281125260.12260-100000@penguin.transmeta.com>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, December 28, 2000 11:29:01 AM -0800 Linus Torvalds
<torvalds@transmeta.com> wrote:
[ skipping io on the first walk in page_launder ]
> 
> There are some arguments for starting the writeout early, but there are
> tons of arguments against it too (the main one being "avoid doing IO if
> you can do so"), so your patch is probably fine. In the end, the
> performance characteristics are what matters. Does the patch make for
> smoother behaviour and better performance?

My dbench speeds have always varied from run to run, but the average speed
went up about 9% with the anon space mapping patch and the page_launder
change.  I could not find much difference in a pure test13-pre4, probably
because dbench doesn't generate much swap on my machine.  I'll do more
tests when I get back on Monday night.

Daniel, sounds like dbench varies less on your machine, what did the patch
do for you?

BTW, the last anon space mapping patch I sent also works on test13-pre5.
The block_truncate_page fix does help my patch, since I have bdflush
locking pages ( thanks Marcelo )

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
