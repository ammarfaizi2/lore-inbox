Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263956AbTLOS5O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 13:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbTLOS5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 13:57:14 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:19097 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S263956AbTLOS5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 13:57:09 -0500
Date: Mon, 15 Dec 2003 10:57:01 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: More questions about 2.6 /proc/meminfo was: (Mem: and Swap: lines in /proc/meminfo)
Message-ID: <20031215185701.GC1769@matchmail.com>
Mail-Followup-To: Rik van Riel <riel@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20031214014429.GB1769@matchmail.com> <Pine.LNX.4.44.0312141915550.26386-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312141915550.26386-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 14, 2003 at 07:17:05PM -0500, Rik van Riel wrote:
> On Sat, 13 Dec 2003, Mike Fedyk wrote:
> 
> > > > Are Dirty: and Writeback: counted in Inactive: or are they seperate?
> > > 
> > > They're unrelated statistics to active/inactive and will
> > > overlap with active/inactive.
> > 
> > Do they count anonymous memory, or are they strictly dirty/writeback
> > pagecache?
> 
> Pagecache only, I think.
> 

That makes sence, since dirty anonymous memory should be swapped out, not
"written back".

Though dirty seems anbiguous, since it could contain dirty anon memory too.
But, I think you are right.  On my idle system (with kde running), there's
only 40KB "dirty" memory, so it's probably pagecache only.

Thanks.

> > > > Does Mapped: include all files mmap()ed, or only the executable ones?
> > > 
> > > Mapped: includes all mmap()ed pages, regardless of executable
> > > status.
> > 
> > Is mmap() always pagecache backed, or can it be backed with anonymous
> > memory?  IE, can I subtract mapped from pagecache?
> 
> Mapped includes all mapped memory, both pagecache and
> anonymous.
> 

Ok, then I can't subtract it from the pagecache value.  I'll have to graph
that differently (a line instead of a stack).

Thanks.

> > I'd love to find a more accurate way to get the amount of memory used for
> > apps, short of reading the output of ps and doing calculations on RSS,
> > VIRTUAL, and SHARED...
> 
> That would be great, it would really help with tuning
> the VM further (if that turns out to be needed for
> special workloads).

Any suggestions?
