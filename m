Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313699AbSDPOvt>; Tue, 16 Apr 2002 10:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313700AbSDPOvs>; Tue, 16 Apr 2002 10:51:48 -0400
Received: from waste.org ([209.173.204.2]:51122 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S313699AbSDPOvr>;
	Tue, 16 Apr 2002 10:51:47 -0400
Date: Tue, 16 Apr 2002 09:50:57 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <wli@holomorphy.com>
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
In-Reply-To: <Pine.LNX.4.33.0204151415110.15353-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0204160948130.3933-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2002, Linus Torvalds wrote:

> On Mon, 15 Apr 2002, Linus Torvalds wrote:
> >
> > Which requires the user to use something like
> >
> > 	for_each_zone(zone) {
> > 		...
> > 	} end_zone;
>
> Side note: I should probably have made this the standard notation for the
> "for_each_xxx ()" macros, because having an "end_xxx" macro means that you
> can start using things like "do { ... } while (x)" loops for the control
> flow, which is often easier for the compiler to optimize (ie if the first
> element is always valid, and you don't need a condition going in, which is
> often true).
>
> It does, of course, end up polluting the name-space a bit more.

Ugh. If we're going to use such ugly things, it would be nice if they were
do_zone/while_zone instead of being suggestive of a for loop.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

