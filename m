Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268237AbRGWOVC>; Mon, 23 Jul 2001 10:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268239AbRGWOUw>; Mon, 23 Jul 2001 10:20:52 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:28941 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268237AbRGWOUe>; Mon, 23 Jul 2001 10:20:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Larry McVoy <lm@bitmover.com>
Subject: Re: Common hash table implementation
Date: Mon, 23 Jul 2001 16:24:58 +0200
X-Mailer: KMail [version 1.2]
Cc: "Brian J. Watson" <Brian.J.Watson@compaq.com>,
        Larry McVoy <lm@bitmover.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <01071815464209.12129@starship> <01072122255100.02679@starship> <20010722093732.A6000@work.bitmover.com>
In-Reply-To: <20010722093732.A6000@work.bitmover.com>
MIME-Version: 1.0
Message-Id: <01072316245803.00315@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sunday 22 July 2001 18:37, Larry McVoy wrote:
> On Sat, Jul 21, 2001 at 10:25:51PM +0200, Daniel Phillips wrote:
> >   1) How random is the hash
> >   2) How efficient is it
>
> The hash is not the only part to consider for performance.  The rest
> of the code is important as well.  The code I pointed you to has been
> really carefully tuned for performance.

Yes, I can see that.  The linear congruential hash will be faster than 
the CRC32 on most modern machines, where we have fast multiplies vs 
multi-cycle table access.

If it's true that the CRC32 is actually less random as well, I'd 
consider dropping the others and just going with the linear 
congruential hash.

> And it can be made to be MP
> safe, SGI did that and managed to get 455,000 random fetches/second
> on an 8 way R4400 (each of these is about the same as the original
> Pentium at 150Mhz).

Did I mention that your linear congruential hash rated among the best 
of all I've tested?  It's possible it might be further improved along 
the lines I suggested.  I'll try this pretty soon.

--
Daniel

