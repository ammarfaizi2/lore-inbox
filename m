Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbUCLSse (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 13:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUCLSse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 13:48:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21898 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262471AbUCLSsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 13:48:32 -0500
Date: Fri, 12 Mar 2004 13:48:21 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, Hugh Dickins <hugh@veritas.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
In-Reply-To: <Pine.LNX.4.58.0403120956370.1045@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.44.0403121346580.6494-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004, Linus Torvalds wrote:

> I think your approach could work (reverse map by having separate address
> spaces for unrelated processes), but I don't see any good "page->index"  
> allocation scheme that is implementable.

> Or did I totally mis-understand what you were proposing?

You're absolutely right.  I am still trying to come up with
a way to do this.

Note that since we count page->index in PAGE_SIZE unit we
have PAGE_SIZE times as much space as a process can take,
so we definately have enough address space to come up with
a creative allocation scheme.

I just can't think of any now ...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

