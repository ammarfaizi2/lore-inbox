Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130606AbRCTSpD>; Tue, 20 Mar 2001 13:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130565AbRCTSox>; Tue, 20 Mar 2001 13:44:53 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:48398 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130791AbRCTSoj>; Tue, 20 Mar 2001 13:44:39 -0500
Date: Tue, 20 Mar 2001 10:43:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Serge Orlov <sorlov@con.mcst.ru>
cc: <linux-kernel@vger.kernel.org>, <sorlov@mcst.ru>
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
In-Reply-To: <3AB7A169.53F4E4BB@con.mcst.ru>
Message-ID: <Pine.LNX.4.31.0103201042360.1990-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Mar 2001, Serge Orlov wrote:
>
> I upgraded one of our computer happily running 2.2.13 kernel
> to 2.4.2. Everything was OK, but compilation time of our C++
> project greatly increased (1.4 times slower). I investigated the
> issue and found that g++ spends 7 times more time in kernel.
> The reason for this is big vm map:

Cool. Somebody actually found a real case.

I'll fix the mmap case asap. Its' not hard, I just waited to see if it
ever actually triggers. Something like g++ certainly counts as major.

Are you willing to test out patches?

		Linus

