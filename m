Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154498-7845>; Tue, 25 Aug 1998 04:24:55 -0400
Received: from noc.nyx.net ([206.124.29.3]:4748 "EHLO noc" ident: "mail") by vger.rutgers.edu with ESMTP id <154989-7845>; Tue, 25 Aug 1998 04:01:05 -0400
Date: Tue, 25 Aug 1998 03:37:15 -0600 (MDT)
From: Colin Plumb <colin@nyx.net>
Message-Id: <199808250937.DAA06916@nyx10.nyx.net>
X-Nyx-Envelope-Data: Date=Tue Aug 25 03:37:15 1998, Sender=colin, Recipient=linux-kernel@vger.rutgers.edu, Valsender=colin@localhost
To: linux-kernel@vger.rutgers.edu
Subject: Re: Skip lists and splay trees
Sender: owner-linux-kernel@vger.rutgers.edu

Jamie Lokier (lkd@tantalophile.demon.co.uk) wrote:
> I would definitely recommend a skip list or splay tree. Both are very
> fast. Both are very short code. (_Much_ shorter and simpler than the
> AVL code was).
> 
> The skip list has the advantage that it's fairly simple to code and
> nothing is written (cache advantage).
> 
> The splay tree has the advantage that it automatically caches the
> recently used entries. So much so that there's no need for a one entry
> cache in front of it.

Skip lists have the notable disadvantage that nodes are variable-sized
(due to the random number of pointers in them), which complicates
memory management, a great kernel preoccupation.

Splay trees are amenable to a number of heuristics like self-adjusting
lists, like move-to-front or move-forward-one.  They might be worth
playing with a bit.
-- 
	-Colin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
