Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282683AbRLOOZN>; Sat, 15 Dec 2001 09:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282769AbRLOOZC>; Sat, 15 Dec 2001 09:25:02 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:40216 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S282757AbRLOOYv>; Sat, 15 Dec 2001 09:24:51 -0500
Date: Sat, 15 Dec 2001 15:24:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Chabot <chabotc@reviewboard.com>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Unfreeable buffer/cache problem in 2.4.17-rc1 still there
Message-ID: <20011215152446.P2431@athlon.random>
In-Reply-To: <1008419776.6780.0.camel@gandalf.chabotc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <1008419776.6780.0.camel@gandalf.chabotc.com>; from chabotc@reviewboard.com on Sat, Dec 15, 2001 at 01:36:11PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2001 at 01:36:11PM +0100, Chris Chabot wrote:
> inode_cache       686896 686896    480 85862 85862    1 :  124   62
> dentry_cache      696810 696810    128 23227 23227    1 :  252  126

this is an icache/dcache problem, can you reproduce on 2.4.17rc1aa1, it
will shrink more aggressively.

really to get an even better balance we should add the icache/dcache
slab pages into the lru as well... that would trigger the icache/dcache
flushes more easily when too much ram is in those caches.

Andrea
