Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbTIXVTT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 17:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbTIXVTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 17:19:19 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:64724 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261559AbTIXVTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 17:19:18 -0400
Date: Wed, 24 Sep 2003 15:11:05 -0600
From: yodaiken@fsmlabs.com
To: Rik van Riel <riel@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
       Andrea Arcangeli <andrea@suse.de>, andrea@kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: log-buf-len dynamic
Message-ID: <20030924211105.GA18149@hq.fsmlabs.com>
References: <Pine.LNX.4.44.0309232051330.27940-100000@home.osdl.org> <Pine.LNX.4.44.0309240007040.17335-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309240007040.17335-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If people would just wake up to the lossy memory compression algorithms that
Steve Tweedie invented, the whole problem could be solved in a moment.

On Wed, Sep 24, 2003 at 12:12:51AM -0400, Rik van Riel wrote:
> On Tue, 23 Sep 2003, Linus Torvalds wrote:
> 
> > Yeah, SunOS was nice. But I really think it's the access patterns that 
> > changed.
> 
> Absolutely.  Garbage collection and object orientation have
> obsoleted LRU and related algorithms.
> 
> Huge memory sizes also have done their share to obsolete
> recency based replacement algorithms.
> 
> I suspect we'll want something closer to a frequency based
> replacement scheme in the future. Possibly something like 
> LIRS or ARC, but adapted to work in a general purpose OS in 
> a very light weight way.
> 
> The argument that because we have more memory replacement
> is no longer as important doesn't quite hold because the
> cost of page replacement, measured in cpu cycles, has gone
> completely through the roof in the last decades.
> 
> Then there's the whole different bag of cookies that is the
> caching of filesystem metadata, like our inode and dentry
> caches.  I'm not sure what would be a good replacement
> strategy for those, but I do know that we'll want a good
> algorithm here because hard disks (and the number of files
> on them) are growing so much faster than anything else in
> our computers...
> 
> -- 
> "Debugging is twice as hard as writing the code in the first place.
> Therefore, if you write the code as cleverly as possible, you are,
> by definition, not smart enough to debug it." - Brian W. Kernighan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
www.fsmlabs.com  www.rtlinux.com
1+ 505 838 9109

