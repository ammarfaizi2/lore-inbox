Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129639AbRBYTZO>; Sun, 25 Feb 2001 14:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129652AbRBYTZE>; Sun, 25 Feb 2001 14:25:04 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:51808 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129639AbRBYTYq>; Sun, 25 Feb 2001 14:24:46 -0500
Date: Sun, 25 Feb 2001 20:26:05 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: ll_rw_block/submit_bh and request limits
Message-ID: <20010225202605.C16259@athlon.random>
In-Reply-To: <20010222145642.D17276@suse.de> <Pine.LNX.4.10.10102221052000.8403-100000@penguin.transmeta.com> <20010222223811.A29372@athlon.random> <20010225183401.D7830@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010225183401.D7830@suse.de>; from axboe@suse.de on Sun, Feb 25, 2001 at 06:34:01PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2001 at 06:34:01PM +0100, Jens Axboe wrote:
> Any reason why you don't have a lower wake-up limit for the queue?

The watermark diff looked too high (it's 128M in current Linus's tree), but it's
probably a good idea to resurrect it with a max difference of a few full sized
requests (1/2mbytes).

> Do you mind if I do some testing with this patch and fold it in,
> possibly?

Go ahead, thanks,
Andrea
