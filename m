Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276591AbRKFFgj>; Tue, 6 Nov 2001 00:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277012AbRKFFga>; Tue, 6 Nov 2001 00:36:30 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:27408 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S276591AbRKFFgX>; Tue, 6 Nov 2001 00:36:23 -0500
Message-ID: <3BE77599.9CFB5CA9@zip.com.au>
Date: Mon, 05 Nov 2001 21:31:05 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <Pine.GSO.4.21.0111052306150.27713-100000@weyl.math.psu.edu> <Pine.LNX.4.33.0111052037240.1061-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> I do believe that there are probably more "high-level" heuristics that can
> be useful, though. Looking at man common big trees, the ownership issue is
> one obvious clue. Sadly the trees obviously end up being _created_ without
> owner information, and the chown/chgrp happens later, but it might still
> be useable for some clues.
> 

I didn't understand your objection to the heuristic "was the
parent directory created within the past 30 seconds?". If the
parent and child were created at the same time, chances are that
they'll be accessed at the same time?

And there's always the `chattr' cop-out, to alter the allocation
policy at a chosen point in the tree by administrative act.

Any change in ext2 allocation policy at this point in time really,
really worries me.  If it screws up we'll have 10,000,000 linux
boxes running like dead dogs in a year. So if we _do_ make a change, I'd
suggest that it be opt-in.  Call me a wimp.

-
