Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311430AbSCSQih>; Tue, 19 Mar 2002 11:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311431AbSCSQi3>; Tue, 19 Mar 2002 11:38:29 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:9996 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S311430AbSCSQiK>; Tue, 19 Mar 2002 11:38:10 -0500
Date: Tue, 19 Mar 2002 11:35:39 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <E16mMcT-0000m9-00@starship>
Message-ID: <Pine.LNX.3.96.1020319113155.1772C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2002, Daniel Phillips wrote:

> It breaks down somewhat as virtual memory range goes way beyond 4GB.  
> There's the relatively minor issue of extra levels of tree traversal, 
> currently limited to 4 by AMD's architecture but not so limited on other 
> architectures.  A bigger problem is what to do about internal fragmentation 
> in the page table tree, say if somebody mmaps a 2 TB sparse file, then writes 
> one byte every 2 meg.  Bang, 4 gig worth of page tables, this is probably not 
> what we want.  IMHO, 'don't do that then' isn't a reasonable response.

  Perhaps not, but "if you do that it will be slow" is a reasonable
response when any operation requires an unusual resource to complete. The
best solution is to reduce the resources needed by being clever, but the
next best is to prevent one process from beating the machine to death for
all others (if any).

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

