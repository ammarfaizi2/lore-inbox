Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSHIVTE>; Fri, 9 Aug 2002 17:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315988AbSHIVTE>; Fri, 9 Aug 2002 17:19:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55052 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315946AbSHIVTD>; Fri, 9 Aug 2002 17:19:03 -0400
Date: Fri, 9 Aug 2002 14:23:22 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Larson <plars@austin.ibm.com>
cc: Hubertus Franke <frankeh@us.ibm.com>, Rik van Riel <riel@conectiva.com.br>,
       Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@zip.com.au>,
       <andrea@suse.de>, Dave Jones <davej@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
In-Reply-To: <1028921658.19434.365.camel@plars.austin.ibm.com>
Message-ID: <Pine.LNX.4.33.0208091420240.19267-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 9 Aug 2002, Paul Larson wrote:
>
> I suspect that it would actually require more than just this. 

There are various /proc paths, Andries had a full patch at some point a 
long time ago.

My point was not so much that this is sufficient, but that the approach is 
valid. I'd rather go with the simple approach (that solves two problems) 
than with a much more complex approach (that solves only one).

And yes, I doubt I actually want to give all 30 bits to pid space in the 
long run (the per-node pid space argument is still valid), but it's better 
to start with 30 bits and actively trying to break things and then phasing 
it down later than to be timid and never even see the stuff that breaks.

		Linus

