Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274097AbRISQCA>; Wed, 19 Sep 2001 12:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274072AbRISQBu>; Wed, 19 Sep 2001 12:01:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47881 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274033AbRISQBe>; Wed, 19 Sep 2001 12:01:34 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Re[2]: [PATCH] Athlon bug stomper. Pls apply.
Date: Wed, 19 Sep 2001 16:00:30 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9oafeu$1o0$1@penguin.transmeta.com>
In-Reply-To: <20010919154701.A7381@stud.ntnu.no> <Pine.GSO.4.21.0109191707260.23205-100000@skiathos.physics.auth.gr> <20010919165503.A16359@gondor.com>
X-Trace: palladium.transmeta.com 1000915299 7439 127.0.0.1 (19 Sep 2001 16:01:39 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 19 Sep 2001 16:01:39 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010919165503.A16359@gondor.com>,
Jan Niehusmann  <jan@gondor.com> wrote:
>
>Additionally, look at who tested the 'fix' up to now: Probably only
>people who had a problem before. And for all of them, the problem got
>fixed. But do we know what happens if we use this 'fix' on a computer
>that is not broken? No. Perhaps it breaks when we apply the 'fix'?

This is my personal main worry.

The problem with things like these is that people for whom the old code
works fine don't tend to be interested in "fixes" floating around on the
net - whether it is for Athlon chipset problems or for driver bugs or
anything else.

Which means that the "statistical sampling" is very skewed by
self-selection, and anybody who knows anything about statistics knows
that sample selection is _very_ important.

Right now, for example, I'm leaning towards applying the patch, but
quite frankly I'm still not certain.  Getting _some_ kind of information
out of VIA would be really good - even just an ACK from somebody who is
under NDA and can say just "yes, it's safe to clear bit 7 of reg 0x55". 

It is _probably_ an undocumented performance thing, and clearing that
bit may slow something down. But it might also change some behaviour,
and knowing _what_ the behaviour is might be very useful for figuring
out what it is that triggers the problem.

			Linus
