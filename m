Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130155AbQL1TVt>; Thu, 28 Dec 2000 14:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131607AbQL1TV3>; Thu, 28 Dec 2000 14:21:29 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:39177 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130155AbQL1TV0>; Thu, 28 Dec 2000 14:21:26 -0500
Date: Thu, 28 Dec 2000 10:50:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Wedgwood <cw@f00f.org>
cc: Rik van Riel <riel@conectiva.com.br>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <20001228160005.B14479@metastasis.f00f.org>
Message-ID: <Pine.LNX.4.10.10012281049140.12260-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Dec 2000, Chris Wedgwood wrote:
> 
> this remind me; perhaps you or Al could answer this.
> 
>   How hard would it be to have ramfs backed by swap? The goal being
>   try to achieve something like a FreeBSDs mfs.
> 
> I use ramfs for /tmp on my laptop -- it's very handy because it
> extends the amount of the the disk had spent spun down and therefore
> battery life; but writing large files into /tmp can blow away the
> system or at the very least eat away at otherwise usable ram. Not
> terribly desirable.

Jeff Garzik had the code to do this, and the new shared memory code should
be able to be massaged to handle this all without actually bloating the
kernel (ie "ramfs" would still stay very very tiny, just taking advantage
of the common code that the VM layer already has to support for other
things).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
