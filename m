Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbTDHJni (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 05:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTDHJni (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 05:43:38 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:14089 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261242AbTDHJnh (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 05:43:37 -0400
Date: Tue, 8 Apr 2003 11:55:11 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Scott A Crosby <scrosby@cs.rice.edu>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
Subject: Re: Better hash functions (was Re: Route cache performance under stress)
Message-ID: <20030408095511.GA19428@alpha.home.local>
References: <oydznn1okqh.fsf@bert.cs.rice.edu> <20030408050145.GA16516@alpha.home.local> <oydvfxpo71x.fsf@bert.cs.rice.edu> <20030408075950.GA18222@alpha.home.local> <oydn0j1nyed.fsf_-_@bert.cs.rice.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oydn0j1nyed.fsf_-_@bert.cs.rice.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> As stated, I was assuming that you masked off the lowest 12 bits and
> used that for the bucket number. This is typical in most code; if your
> function doesn't do that, you should have said so.

OK
 
> On a P2 benchmark system, hashing one byte at a time this approach
> with 64 bit multiplies and 32-bit modulation operation is just as fast
> as Perl's shift-based hash function.

I agree for recent x86 processors, but older or smaller designs would suffer
from multiply and divide.

> > the initial random, you will not exploit it. That's the whole
> > point. Try to find a generic attack against this part of code, where
> > 0x12345678 is a random number. Perhaps you can, but I couldn't.
> 
> Actually, this is relatively strightforward to break.

OK, I agree with your demo, you convinced me.

> Trust me. Find a good universal hash function in the literature and
> use it. I don't know about you, but inventing my own is beyond my
> skill. I already tried it once, in my earlier message, and made a
> mistake; I've already elided out two others I was about to make in
> this message.

well, the only hash function I wrote myself only had to suit my needs, and
didn't have to be resistant to hash attacks. But I agree that the strongest
functions you'll find are those which have been publicly available for years
and still remain uncracked.

Regards,
Willy

