Return-Path: <linux-kernel-owner+w=401wt.eu-S1754658AbWL0JHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658AbWL0JHR (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 04:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754670AbWL0JHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 04:07:17 -0500
Received: from koto.vergenet.net ([210.128.90.7]:59851 "EHLO koto.vergenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754450AbWL0JHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 04:07:15 -0500
Date: Wed, 27 Dec 2006 18:07:02 +0900
From: Horms <horms@verge.net.au>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [patch] linux/preempt.h needs linux/thread_info.h
Message-ID: <20061227090700.GB4761@verge.net.au>
References: <20061227081701.GA19379@verge.net.au> <20061227082702.GO17561@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061227082702.GO17561@ftp.linux.org.uk>
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2006 at 08:27:02AM +0000, Al Viro wrote:
> On Wed, Dec 27, 2006 at 05:17:02PM +0900, Horms wrote:
> > It seems that linux/preempt.h needs to include linux/thread_info.h
> > in order to access current_thread_info(), which is used in
> > preempt_count().
> > 
> > I guess that all callers of preempt_count() must include
> > both linux/thread_info.h and linux/preempt.h directly or indirectly,
> > as this does not cause a compile error. I noticed the problem while
> > working on an unrelated issue in xen-land.
> > 
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > 
> > Index: linux-2.6/include/linux/preempt.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/preempt.h	2006-12-27 16:58:46.000000000 +0900
> > +++ linux-2.6/include/linux/preempt.h	2006-12-27 17:13:12.000000000 +0900
> > @@ -8,6 +8,7 @@
> >  
> >  #include <linux/thread_info.h>
> >  #include <linux/linkage.h>
> > +#include <linux/thread_info.h>
> 
> Huh?  It's just been included two lines above...

Sorry about that. I mucked around with this for a while
and ended up missing the obvious when doing the forward-port.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/

