Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130497AbQKISDJ>; Thu, 9 Nov 2000 13:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130531AbQKISC7>; Thu, 9 Nov 2000 13:02:59 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:37894 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130526AbQKISCu>; Thu, 9 Nov 2000 13:02:50 -0500
Date: Thu, 9 Nov 2000 10:02:35 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: rd - deadlock removal
In-Reply-To: <20001109103511.G467@suse.de>
Message-ID: <Pine.LNX.4.10.10011091001030.1909-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Nov 2000, Jens Axboe wrote:
> 
> >  The second is more elegant in that it side steps the problem by
> >  giving rd.c a make_request function instead of using the default
> >  _make_request.   This means that io_request_lock is simply never
> >  claimed my rd.
> 
> And this solution is much better, even given the freeze I think that
> is the way to go.

I agree, I already applied it. The second approach just makes the problem
go away, and also avoids needlessly merging the request etc. I suspect
that the lack of request-merging could also eventually be used to simplify
the driver a bit, as it now wouldn't need to worry about that issue any
more at all.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
