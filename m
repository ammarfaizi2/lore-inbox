Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbTHaQw1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 12:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbTHaQw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 12:52:26 -0400
Received: from smtp1.vsnl.net ([203.200.235.231]:13933 "EHLO smtp1.vsnl.net")
	by vger.kernel.org with ESMTP id S262436AbTHaQwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 12:52:25 -0400
Date: Sun, 31 Aug 2003 22:26:54 -0400
From: Parag Warudkar <warudkar@vsnl.net>
Subject: Re: Re: 2.6.0-test4-mm1 - kswap hogs cpu OO takes ages to start!
To: riel@redhat.com
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       warudkar@vsnl.net, linux-kernel@vger.kernel.org
Message-id: <0HKH00602TI8IB@smtp1.vsnl.net>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But eventually, kswapd does stop scanning and machine is back to normal after a 2 min freeze.
BTW, how is it cured at swappiness ==100?
> 
> 
> On Thu, 28 Aug 2003, Con Kolivas wrote:
> 
> > > Does this make a difference?
> > 
> > Tried it. No change. 
> > 
> > kswapd0 can hit 90% cpu at times unless the swappiness is increased.
> 
> Looks like the problem is that cache and process pages are on
> the same lists, forcing kswapd to scan the lists endlessly.
> 
> One thing you could try is splitting the lists, at least the
> active list, like done in 2.4-rmap15...
> 
> -- 
> "Debugging is twice as hard as writing the code in the first place.
> Therefore, if you write the code as cleverly as possible, you are,
> by definition, not smart enough to debug it." - Brian W. Kernighan
> 
