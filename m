Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268908AbRHFRUi>; Mon, 6 Aug 2001 13:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268906AbRHFRU2>; Mon, 6 Aug 2001 13:20:28 -0400
Received: from [63.209.4.196] ([63.209.4.196]:47364 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268903AbRHFRUV>; Mon, 6 Aug 2001 13:20:21 -0400
Date: Mon, 6 Aug 2001 10:18:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Jakub Jelinek <jakub@redhat.com>, David Luyer <david_luyer@pacific.net.au>,
        <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>
Subject: Re: /proc/<n>/maps growing...
In-Reply-To: <20010806124952.G15925@athlon.random>
Message-ID: <Pine.LNX.4.33.0108061017180.8972-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Aug 2001, Andrea Arcangeli wrote:
>
> in mainline it's not a sysctl, btw.
>
> I never noticed this limit and personally I don't like it regardless of
> the merge_segments (but of course without merge_segments it is can
> trigger problems while switching between 2.2 and 2.4).

Whether you like it or not is immaterial.

It means that users cannot allocate tons of memory by mmap'ing every odd
page, for example.

And yes, this used to be a way to lock up a machine. With a exploit that
was floating on the net.

That limit is _needed_.

		Linus

