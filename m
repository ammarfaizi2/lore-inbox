Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283012AbRK1DpK>; Tue, 27 Nov 2001 22:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281870AbRK1Dov>; Tue, 27 Nov 2001 22:44:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28946 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283011AbRK1Do3>; Tue, 27 Nov 2001 22:44:29 -0500
Date: Tue, 27 Nov 2001 19:38:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>,
        <jmerkey@timpanogas.org>
Subject: Re: Block I/O Enchancements, 2.5.1-pre2
In-Reply-To: <3C044CB1.62F5650F@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0111271933100.1195-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Nov 2001, Jeff Garzik wrote:
>
> Oh yeah, I meant to ask: do we get 64-bit inode numbers and 64-bit block
> numbers on x86 sometime in 2.5?

Well, the 64-bit sector number skeleton is already there in pre2..

We will probably _not_ get 64-bit page index numbers, though. I don't want
to make the page structure bigger/slower for very little gain. So the page
cache is probably going to be limited to about 44 bits (45+ if people
start doing large pages, which is probably worth it). So there would still
be partition/file limits on the order of 16-64 TB in the next few years.

(In a longer timeframe, assuming RAM keeps getting cheaper and cheaper,
and 64-bit computing starts hppening on PC's, a few years down the line we
can re-visit this - that particular transition is not going to be too
painful).

And yes, I realize that you can already build big arrays and use LVM etc
to make them be more than 16TB. I just do not think it's a problem yet,
and I'd rather cater to "normal" people than to peopel who can't bother
to partition their data at all.

		Linus

