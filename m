Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbTLOARK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 19:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbTLOARK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 19:17:10 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:19562 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262794AbTLOARH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 19:17:07 -0500
Date: Sun, 14 Dec 2003 19:17:05 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Mike Fedyk <mfedyk@matchmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: More questions about 2.6 /proc/meminfo was: (Mem: and Swap:
 lines in /proc/meminfo)
In-Reply-To: <20031214014429.GB1769@matchmail.com>
Message-ID: <Pine.LNX.4.44.0312141915550.26386-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0312141915552.26386@chimarrao.boston.redhat.com>
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Dec 2003, Mike Fedyk wrote:

> > > Are Dirty: and Writeback: counted in Inactive: or are they seperate?
> > 
> > They're unrelated statistics to active/inactive and will
> > overlap with active/inactive.
> 
> Do they count anonymous memory, or are they strictly dirty/writeback
> pagecache?

Pagecache only, I think.

> > > Does Mapped: include all files mmap()ed, or only the executable ones?
> > 
> > Mapped: includes all mmap()ed pages, regardless of executable
> > status.
> 
> Is mmap() always pagecache backed, or can it be backed with anonymous
> memory?  IE, can I subtract mapped from pagecache?

Mapped includes all mapped memory, both pagecache and
anonymous.

> I'd love to find a more accurate way to get the amount of memory used for
> apps, short of reading the output of ps and doing calculations on RSS,
> VIRTUAL, and SHARED...

That would be great, it would really help with tuning
the VM further (if that turns out to be needed for
special workloads).

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

