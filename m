Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbUEJXhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUEJXhB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbUEJXdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 19:33:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:17110 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261752AbUEJXdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 19:33:20 -0400
Date: Mon, 10 May 2004 16:33:17 -0700
From: Chris Wright <chrisw@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-ID: <20040510163317.Y22989@build.pdx.osdl.net>
References: <20040510024506.1a9023b6.akpm@osdl.org> <20040510223755.A7773@infradead.org> <20040510150203.3257ccac.akpm@osdl.org> <20040510231146.GA5168@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040510231146.GA5168@taniwha.stupidest.org>; from cw@f00f.org on Mon, May 10, 2004 at 04:11:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wedgwood (cw@f00f.org) wrote:
> On Mon, May 10, 2004 at 03:02:03PM -0700, Andrew Morton wrote:
> 
> > Capabilities are broken and don't work.  Nobody has a clue how to
> > provide the required services with SELinux and nobody has any code
> > and we need the feature *now* before vendors go shipping even more
> > ghastly stuff.
> 
> eh? magic groups are nasty...  and why is this needed?  can't
> oracle/whatever just run with a wrapper to give the capabilities out
> as required until a better solution is available

I agree.  I have a patch that at least fixes this bit of capabilities
(currently, what you suggest doesn't work right), which could easily be
dusted off and resent.

And while we're at it, it would be nice to have the working bits of
memlock rlimits going.  At least the mlock() users would get some help
(i.e. gpg).  Another bit I could resend (removing the broken shm bits,
of course).  It's just those pesky shm segs having their own lifecycle
which breaks the hugetlb and SHM_LOCK attempts to use memlock rlimits.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
