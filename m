Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313268AbSDOVTB>; Mon, 15 Apr 2002 17:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313288AbSDOVTA>; Mon, 15 Apr 2002 17:19:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53767 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313268AbSDOVS7>; Mon, 15 Apr 2002 17:18:59 -0400
Date: Mon, 15 Apr 2002 14:17:22 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>, <wli@holomorphy.com>
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
In-Reply-To: <Pine.LNX.4.33.0204151400200.13034-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0204151415110.15353-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 15 Apr 2002, Linus Torvalds wrote:
> 
> Which requires the user to use something like
> 
> 	for_each_zone(zone) {
> 		...
> 	} end_zone;

Side note: I should probably have made this the standard notation for the 
"for_each_xxx ()" macros, because having an "end_xxx" macro means that you 
can start using things like "do { ... } while (x)" loops for the control 
flow, which is often easier for the compiler to optimize (ie if the first 
element is always valid, and you don't need a condition going in, which is 
often true).

It does, of course, end up polluting the name-space a bit more.

		Linus

