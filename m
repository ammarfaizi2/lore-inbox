Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154708-27243>; Wed, 26 Aug 1998 11:06:51 -0400
Received: from noc.nyx.net ([206.124.29.3]:3528 "EHLO noc" ident: "mail") by vger.rutgers.edu with ESMTP id <156241-27243>; Wed, 26 Aug 1998 09:37:18 -0400
Date: Wed, 26 Aug 1998 09:17:55 -0600 (MDT)
From: Colin Plumb <colin@nyx.net>
Message-Id: <199808261517.JAA24949@nyx10.nyx.net>
X-Nyx-Envelope-Data: Date=Wed Aug 26 09:17:55 1998, Sender=colin, Recipient=, Valsender=colin@localhost
To: linux-kernel@vger.rutgers.edu
Subject: Re: 2.1.xxx makes Electric Fence 22x slower
Cc: davem@dm.cobaltmicro.com
Sender: owner-linux-kernel@vger.rutgers.edu

The fuzzy hash code may make the point moot, but generating
pseudo-random numbers can be done quite quickly (say, < 10 cycles) for
the fairly low quality requirements of a skip list.  Precomputing a
bunch into a table and fetching from the table until empty helps a
great deal.

Certainly it is as fast as most good hash functions.  (After all, I could
just keep a counter and hash that if I had a good hash function, couldn't I?)

A simple lagged-fibonacci generator like x[i] = x[i-24] + x[i-55] would
do fine.  Moving to a twisted generator (TGFSR) improves things even more.
What is arguably the best PRNG currently existing, the Mersenne Twister
(Can you say "perfect score on the spectral test with up to 600 dimensions",
boys and girls?), is quite fast.

Now, if you need cryptographically strong, that's a different issue.

As I wrote before, I think it's the variable node size that makes skip
lists a pain to work with, not the random numbers.
-- 
	-Colin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
