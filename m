Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313366AbSDOXY7>; Mon, 15 Apr 2002 19:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313377AbSDOXY6>; Mon, 15 Apr 2002 19:24:58 -0400
Received: from holomorphy.com ([66.224.33.161]:10381 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S313366AbSDOXY5>;
	Mon, 15 Apr 2002 19:24:57 -0400
Date: Mon, 15 Apr 2002 16:20:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
Message-ID: <20020415232058.GO21206@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204151400200.13034-100000@penguin.transmeta.com> <Pine.LNX.4.33.0204151415110.15353-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2002, Linus Torvalds wrote:
>> Which requires the user to use something like
>> 
>> 	for_each_zone(zone) {
>> 		...
>> 	} end_zone;

Ow... this is exactly what I was trying to avoid.


On Mon, Apr 15, 2002 at 02:17:22PM -0700, Linus Torvalds wrote:
> Side note: I should probably have made this the standard notation for the 
> "for_each_xxx ()" macros, because having an "end_xxx" macro means that you 
> can start using things like "do { ... } while (x)" loops for the control 
> flow, which is often easier for the compiler to optimize (ie if the first 
> element is always valid, and you don't need a condition going in, which is 
> often true).
> It does, of course, end up polluting the name-space a bit more.
> 		Linus

This is typically either the outer loop or used in things that just aren't
time critical (at least not in comparison to deeper loop nesting levels).
This isn't my magnum opus by a longshot (or at least I hope it isn't) so
I won't scream too loud, but I think it's pretty much done right as is.


Cheers,
Bill
