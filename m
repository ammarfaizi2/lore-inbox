Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282977AbRK2HS1>; Thu, 29 Nov 2001 02:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283016AbRK2HSS>; Thu, 29 Nov 2001 02:18:18 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:42900 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282977AbRK2HSE>;
	Thu, 29 Nov 2001 02:18:04 -0500
Date: Thu, 29 Nov 2001 02:17:54 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: rwhron@earthlink.net
cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: Re: fsync02 test hangs 2.5.1-pre3 + patch
In-Reply-To: <Pine.GSO.4.21.0111290050250.9516-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0111290213470.9516-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Nov 2001, Alexander Viro wrote:

> OK, so what we have is breakage in bio parts merged in -pre3 _or_ breakage
> going back to -pre2.  If you could rerun these tests for vanilla 2.5.1-pre2
> and see if they break...

Latency is a bitch... Sorry - I got your previous posting (saying that
2.5.1-pre2 was OK) only now.

So it looks like it had been introduced in -pre3 minus fs/super.c changes.
Which leaves only bio stuff - AFAICS nothing aside of these two had any
chance to give a deadlock of that sort.

