Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272935AbRIHBpw>; Fri, 7 Sep 2001 21:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272936AbRIHBpl>; Fri, 7 Sep 2001 21:45:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1804 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272935AbRIHBpc>; Fri, 7 Sep 2001 21:45:32 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [SOLVED + PATCH]: documented Oops running big-endian reiserfs
 on parisc architecture
Date: Sat, 8 Sep 2001 01:41:44 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9nbt0o$o5s$1@penguin.transmeta.com>
In-Reply-To: <OF9A995335.07A81CF5-ONC1256ABC.00422A7B@de.ibm.com> <20010903.152443.59467554.davem@redhat.com>
X-Trace: palladium.transmeta.com 999913539 26499 127.0.0.1 (8 Sep 2001 01:45:39 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 8 Sep 2001 01:45:39 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010903.152443.59467554.davem@redhat.com>,
David S. Miller <davem@redhat.com> wrote:
>
>Oh thats different!  That won't even work %100 correctly on x86.  On
>x86 it will "execute", but it won't be atomic.

Actually, it will.  Intel definitely discourages it, but they'll lock
both cache-lines if the access is unaligned and crosses.  So while they
encourage natural alignment for atomic accesses, I think they also
guarantee that they always work - it ends up being only a performance
issue. 

I agree that it is bad practice, though, and I bet that the x86 is one
of the very few architectures that _will_ do this naturally.

		Linus
