Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSHIRKV>; Fri, 9 Aug 2002 13:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSHIRKV>; Fri, 9 Aug 2002 13:10:21 -0400
Received: from dsl-213-023-043-103.arcor-ip.net ([213.23.43.103]:49293 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315266AbSHIRKU>;
	Fri, 9 Aug 2002 13:10:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: large page patch (fwd) (fwd)
Date: Fri, 9 Aug 2002 19:11:56 +0200
X-Mailer: KMail [version 1.3.2]
Cc: frankeh@watson.ibm.com, <davidm@hpl.hp.com>,
       David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, <gh@us.ibm.com>,
       <Martin.Bligh@us.ibm.com>, <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208090949240.1436-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0208090949240.1436-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17dDIr-0001OR-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 August 2002 18:51, Linus Torvalds wrote:
> On Fri, 9 Aug 2002, Daniel Phillips wrote:
> > Slab allocations would not have GFP_DEFRAG (I mistakenly wrote GFP_LARGE 
> > earlier) and so would be allocated outside ZONE_LARGE.
> 
> .. at which poin tyou then get zone balancing problems.
> 
> Or we end up with the same kind of special zone that we have _anyway_ in
> the current large-page patch, in which case the point of doing this is
> what?

The current large-page patch doesn't have any kind of defragmentation in the 
special zone and that memory is just not available for other uses.  The thing 
is, when demand for large pages is low the zone should be allowed to fragment.

All of highmem also qualifies as defraggable memory, so certainly on these 
big memory machines we can easily get a majority of memory in large pages.

I don't see a fundamental reason for new zone balancing problems.  The fact 
that balancing has sucked by tradition is not a fundamental reason ;-)

-- 
Daniel
