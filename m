Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290570AbSBKWOY>; Mon, 11 Feb 2002 17:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290574AbSBKWOP>; Mon, 11 Feb 2002 17:14:15 -0500
Received: from bitmover.com ([192.132.92.2]:6817 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290570AbSBKWOG>;
	Mon, 11 Feb 2002 17:14:06 -0500
Date: Mon, 11 Feb 2002 14:14:04 -0800
From: Larry McVoy <lm@bitmover.com>
To: Josh MacDonald <jmacd@CS.Berkeley.EDU>, Tom Lord <lord@regexps.com>,
        jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020211141404.A21336@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Josh MacDonald <jmacd@CS.Berkeley.EDU>, Tom Lord <lord@regexps.com>,
	jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202052328470.32146-100000@ash.penguinppc.org> <20020207165035.GA28384@ravel.coda.cs.cmu.edu> <200202072306.PAA08272@morrowfield.home> <20020207132558.D27932@work.bitmover.com> <20020211002057.A17539@helen.CS.Berkeley.EDU> <20020211070009.S28640@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020211070009.S28640@work.bitmover.com>; from lm@work.bitmover.com on Mon, Feb 11, 2002 at 07:00:09AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2002 at 12:20:57AM -0800, Josh MacDonald wrote:
> Bounding the chain length is easy, it just means that instead of
> storing 1000 deltas in a chain you store 50 fully-expanded versions
> and 50 delta chains of max length 20.  Of course this means a little
> extra storage, but really how much?  Observe that storing 50 out of
> 1000 versions is only 5%, which is pretty good as delta-compression
> ratios go.  A typical delta is usually larger than 5% of the file
> size.  I won't bore you all by carrying out the math, it can easily be
> found in either my report or his.  The point is that bounding the
> chain length by introducing full copies every once in a while does not
> dramatically hurt your compression ratio.

How about some numbers which contrast your claims?  Here are the diff
sizes for all the changes in Linus' BK tree.  Note that he is importing
patches which may actually be bigger than your typical checkin, but
no matter, the point stands even if they represent exactly one checkin
per patch.

In this tree, at least, a typical delta is less than .63% of the file
size.  And if you are measuring against the revision history size, 
then your numbers are even more off.

2198 >= 20.0000000%
1647 >= 10.0000000%
2240 >=  5.0000000%
2508 >=  2.5000000%
2879 >=  1.2500000%
2983 >=  0.6250000%
2962 >=  0.3125000%
2564 >=  0.1562500%
1581 >=  0.0781250%
 919 >=  0.0390625%
 400 >=  0.0195312%
 162 >=  0.0097656%
  50 >=  0.0048828%
  12 >=  0.0024414%
 105 >=  0.0012207%
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
