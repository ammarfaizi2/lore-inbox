Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277046AbRJDAiV>; Wed, 3 Oct 2001 20:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277049AbRJDAiL>; Wed, 3 Oct 2001 20:38:11 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:5892 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S277046AbRJDAh5>;
	Wed, 3 Oct 2001 20:37:57 -0400
Date: Wed, 3 Oct 2001 21:38:07 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Rob Landley <landley@trommello.org>
Cc: Alexander Viro <viro@math.psu.edu>, Christoph Hellwig <hch@ns.caldera.de>,
        <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Whining about 2.5 (was Re: [PATCH] Re: bug? in using generic
 read/write functions to read/write block devices in 2.4.11-pre2)
In-Reply-To: <01100315551100.00728@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L.0110032134320.4835-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2001, Rob Landley wrote:

> (Oh, and what's the deal with "classzones"?  Linus told Andrea
> classzones were a dumb idea, and we'd regret it when we tried to
> inflict NUMA architecture on 2.5, but then went with Andrea's VM
> anyway, which I thought was based on classzones...  Was that ever
> resolved?  What the problem avoided?  What IS a classzone, anyway?
> I'd be happy to RTFM, if anybody could tell me where TF the M is
> hiding...)

Classzones used to be a superset of the memory zones, so
if you have memory zones A, B and C you'd have classzone
Ac consisting of memory zone A, classzone Bc = {A + B}
and Cc = {A + B + C}.

This gives obvious problems for NUMA, suppose you have 4
nodes with zones 1A, 1B, 1C, 2A, 2B, 2C, 3A, 3B, 3C, 4A,
4B and 4C.  Putting together classzones for these isn't
quite obvious and memory balancing will be complex ;)

Of course, nobody knows the exact definitions of classzones
in the new 2.4 VM since it's completely undocumented; lets
hope Andrea will document his code or we'll see a repeat of
the development chaos we had with the 2.2 VM...

cheers,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

