Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289191AbSBSBZQ>; Mon, 18 Feb 2002 20:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289210AbSBSBZG>; Mon, 18 Feb 2002 20:25:06 -0500
Received: from dsl-213-023-040-169.arcor-ip.net ([213.23.40.169]:3730 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289191AbSBSBYy>;
	Mon, 18 Feb 2002 20:24:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Page table sharing
Date: Tue, 19 Feb 2002 02:29:29 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Hugh Dickins <hugh@veritas.com>, <dmccr@us.ibm.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Robert Love <rml@tech9.net>, <mingo@redhat.com>,
        Andrew Morton <akpm@zip.com.au>, <manfred@colorfullife.com>,
        <wli@holomorphy.com>
In-Reply-To: <Pine.LNX.4.33L.0202182221040.1930-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0202182221040.1930-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16cz61-0000ya-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 19, 2002 02:22 am, Rik van Riel wrote:
> On Mon, 18 Feb 2002, Linus Torvalds wrote:
> > On Tue, 19 Feb 2002, Daniel Phillips wrote:
> > >
> > > Thanks, here it is again.
> >
> > Daniel, there's something wrong in the locking.
> 
> > Does anybody see any reason why this doesn't work totally without the
> > lock?
> 
> We'll need protection from the swapout code.  It would be
> embarassing if the page fault handler would run for one
> mm while kswapd was holding the page_table_lock for another
> mm.
> 
> I'm not sure how the page_table_share_lock is supposed
> to fix that one, though.

It doesn't, at present.  This needs to be addressed.

-- 
Daniel
