Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSHIQEr>; Fri, 9 Aug 2002 12:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSHIQEr>; Fri, 9 Aug 2002 12:04:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39181 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314278AbSHIQEq>; Fri, 9 Aug 2002 12:04:46 -0400
Date: Fri, 9 Aug 2002 08:56:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@arcor.de>
cc: frankeh@watson.ibm.com, <davidm@hpl.hp.com>,
       David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, <gh@us.ibm.com>,
       <Martin.Bligh@us.ibm.com>, <wli@holomorpy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <E17dBZN-0001Ng-00@starship>
Message-ID: <Pine.LNX.4.44.0208090854001.1547-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Aug 2002, Daniel Phillips wrote:
> 
> This reference describes roughly what I had in mind for active 
> defragmentation, which depends on reverse mapping.

Note that even active defrag won't be able to handle the case where you 
want have lots of big pages, consituting a large percentage of available 
memory.

Not unless you think I am crazy enough to do garbage collection on kernel
data structures (repeat after me: "garbage collection is stupid, slow, bad
for caches, and only for people who cannot count").

Also, I think the jury (ie Andrew) is still out on whether rmap is worth 
it.

		Linus

