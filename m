Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133097AbRDZUoH>; Thu, 26 Apr 2001 16:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135909AbRDZUn5>; Thu, 26 Apr 2001 16:43:57 -0400
Received: from zeus.kernel.org ([209.10.41.242]:40576 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S133097AbRDZUnr>;
	Thu, 26 Apr 2001 16:43:47 -0400
Date: Thu, 26 Apr 2001 13:26:15 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <20010426221109.E819@athlon.random>
Message-ID: <Pine.LNX.4.31.0104261325220.1118-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Apr 2001, Andrea Arcangeli wrote:
>
> What I'm saying above is that even without the wait_on_buffer ext2 can
> screwup itself because the splice happens after the buffer are just all
> uptodate so any "reader" (I mean any reader through ext2 not through
> block_dev) will never try to do a bread on that blocks before they're
> just zeroed and uptodate.

I assume you meant "..can _not_ screw up itself..", otherwise the rest of
the sentence doesn't seem to make much sense.

		Linus

