Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268084AbRGVWVy>; Sun, 22 Jul 2001 18:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268085AbRGVWVp>; Sun, 22 Jul 2001 18:21:45 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:26688 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268084AbRGVWVc>; Sun, 22 Jul 2001 18:21:32 -0400
Date: Mon, 23 Jul 2001 00:21:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Herbert Valerio Riedel <hvr@hvrlab.org>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: RFC: block/loop.c & crypto
Message-ID: <20010723002158.A23517@athlon.random>
In-Reply-To: <20010722170313.B30813@athlon.random> <Pine.LNX.4.33.0107222031390.3517-100000@janus.txd.hvrlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107222031390.3517-100000@janus.txd.hvrlab.org>; from hvr@hvrlab.org on Sun, Jul 22, 2001 at 08:53:50PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, Jul 22, 2001 at 08:53:50PM +0200, Herbert Valerio Riedel wrote:
> I haven't told you how the cryptoloop.c module contains the necessary
> logic... :-)

I see now ;).

> security is not the issue; it's more of practical terms... since 512 byte
> seems to be the closest practical transfer size (there isn't any smaller
> blocksize supported with linux) it seems natural to use that one....

to me it sounds more natural to use the 1k blocksize that seems to be
backwards compatible automatically (without the special case), the only
disavantage of 1k compared to 512bytes is the decreased security, so if
the decreased security is not your concern I'd suggest to use the 1k
fixed granularity for the IV. 1k is also the default BLOCK_SIZE I/O
granularity used by old linux (which incidentally is why it seems
backwards compatible automatically).

Andrea
