Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265298AbTL0Crb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 21:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265301AbTL0Crb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 21:47:31 -0500
Received: from imladris.surriel.com ([66.92.77.98]:44436 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S265298AbTL0Cra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 21:47:30 -0500
Date: Fri, 26 Dec 2003 21:47:55 -0500 (EST)
From: Rik van Riel <riel@surriel.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: Page aging broken in 2.6
In-Reply-To: <Pine.LNX.4.58.0312261649070.14874@home.osdl.org>
Message-ID: <Pine.LNX.4.55L.0312262147030.7686@imladris.surriel.com>
References: <1072423739.15458.62.camel@gaston>  <Pine.LNX.4.58.0312260957100.14874@home.osdl.org>
  <1072482941.15458.90.camel@gaston>  <Pine.LNX.4.58.0312261626260.14874@home.osdl.org>
 <1072485899.15456.96.camel@gaston> <Pine.LNX.4.58.0312261649070.14874@home.osdl.org>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Dec 2003, Linus Torvalds wrote:

> I'll let Rik and Andrea argue that part - it's entirely possible that
> getting lots of positive results is a _good_ thing, if the same page is
> mapped multiple times. That would just make us less eager to unmap it,
> which sounds like potentially the right thign to do (it's also how the
> old non-rmap code worked, and I know Rik thought it was "unfair", but
> whatever).

I'm really not sure which of the two behaviours would
perform better.  Chances are both behaviours will show
some performance improvement over the other, depending
on the workload...

Rik
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
