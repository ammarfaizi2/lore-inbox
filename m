Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268296AbRGZQVP>; Thu, 26 Jul 2001 12:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268297AbRGZQVF>; Thu, 26 Jul 2001 12:21:05 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:24337 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268296AbRGZQU6>; Thu, 26 Jul 2001 12:20:58 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: ext3-2.4-0.9.4
Date: Thu, 26 Jul 2001 16:18:59 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9jpftj$356$1@penguin.transmeta.com>
In-Reply-To: <20010726174844.W17244@emma1.emma.line.org> <E15PnTJ-0003z0-00@the-village.bc.nu>
X-Trace: palladium.transmeta.com 996164437 15750 127.0.0.1 (26 Jul 2001 16:20:37 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 26 Jul 2001 16:20:37 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <E15PnTJ-0003z0-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>> Go tell your opinion to those people that refuse to wrap their
>> rename/link calls with open()/fsync() calls to the respective parents,
>> particularly Daniel J. Bernstein, Wietse Z. Venema, among others. I
>> don't possibly know all MTAs.
>
>I've pointed things out to Mr Bernstein before. His normal replies are not
>helpful and generally vary between random ravings and threatening to sue
>people who publish things on web pages he disagrees with.

Now, now, Alan. He has strong opinions, I'll agree, but I've never see
him threaten to _sue_.

Also, I think he eventually agreed on the logic of fsync() on the
directory, and we even had a bug report (quickly fixed) for reiserfs
because it got confused by it.

Of course, knowing Dan, I suspect the fsync() is accompanied by several
lines of derogatory comments about the need for it (not that I've
checked). 

Everybody tends to agree that synchronous IO is stupid and slow, but
some people are just so fixated with "That is how it has been done for
20 years..".

Logging filesystems together with explicit logging points (namely,
"fsync()") are very obviously a superior answer from a technical
standpoint, but that doesn't impact the emotional arguments ("but I want
things to stay the same!"). 

		Linus
