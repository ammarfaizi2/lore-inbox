Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267548AbTBRC1E>; Mon, 17 Feb 2003 21:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267552AbTBRC1E>; Mon, 17 Feb 2003 21:27:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64772 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267548AbTBRC1D>; Mon, 17 Feb 2003 21:27:03 -0500
Date: Mon, 17 Feb 2003 18:33:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Wedgwood <cw@f00f.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Linux v2.5.62 --- spontaneous reboots
In-Reply-To: <20030218021614.GA7924@f00f.org>
Message-ID: <Pine.LNX.4.44.0302171828350.3558-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Feb 2003, Chris Wedgwood wrote:
> 
> The only thing I can think of is a triple-fault...  I'm wondering
> about using gcc-3.2 instead of 2.95.4 (Debian blah blort blem) on the
> off chance it's a weird compiler problem.

A lot of people seem to be using gcc-3.2 these days, since it's what RH-8 
comes with as standard. I don't think there are any _known_ problems with 
that compiler, at least on x86.

Now, interestingly enough, the mjb patch _does_ contain a change to 
mm/memory.c that really makes no sense _except_ in the case of a compiler 
bug. So you could check whether that (small) mm/memory.c patch is the 
thing that makes a difference for you..

It would also be interesting to see if you can check just the scheduler 
part of the mjb patch. On the whole the mjb patch looks like it should be 
fairly easy to cut into specific parts, and Martin may actually have it 
somewhere as separate patches.

		Linus

