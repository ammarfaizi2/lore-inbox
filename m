Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSHIQON>; Fri, 9 Aug 2002 12:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314634AbSHIQON>; Fri, 9 Aug 2002 12:14:13 -0400
Received: from dsl-213-023-043-103.arcor-ip.net ([213.23.43.103]:2445 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314529AbSHIQOM>;
	Fri, 9 Aug 2002 12:14:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: large page patch (fwd) (fwd)
Date: Fri, 9 Aug 2002 18:15:51 +0200
X-Mailer: KMail [version 1.3.2]
Cc: frankeh@watson.ibm.com, <davidm@hpl.hp.com>,
       David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, <gh@us.ibm.com>,
       <Martin.Bligh@us.ibm.com>, <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208090854001.1547-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0208090854001.1547-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17dCQa-0001Nv-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 August 2002 17:56, Linus Torvalds wrote:
> On Fri, 9 Aug 2002, Daniel Phillips wrote:
> > This reference describes roughly what I had in mind for active 
> > defragmentation, which depends on reverse mapping.
> 
> Note that even active defrag won't be able to handle the case where you 
> want have lots of big pages, consituting a large percentage of available 
> memory.

Perhaps I'm missing something, but I don't see why.

> Not unless you think I am crazy enough to do garbage collection on kernel
> data structures (repeat after me: "garbage collection is stupid, slow, bad
> for caches, and only for people who cannot count").

Slab allocations would not have GFP_DEFRAG (I mistakenly wrote GFP_LARGE 
earlier) and so would be allocated outside ZONE_LARGE.

> Also, I think the jury (ie Andrew) is still out on whether rmap is worth 
> it.

Tell me about it.  Well, I feel strongly enough about it to spend the next
week coding yet another pte chain optimization.

-- 
Daniel
