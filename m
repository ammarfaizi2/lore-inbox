Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264293AbUDUBil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264293AbUDUBil (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 21:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUDUBil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 21:38:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:57560 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264293AbUDUBiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 21:38:18 -0400
Date: Tue, 20 Apr 2004 18:38:08 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Chris Wright <chrisw@osdl.org>, Ken Ashcraft <ken@coverity.com>,
       linux-kernel@vger.kernel.org, mc@cs.stanford.edu,
       dri-devel@lists.sourceforge.net
Subject: Re: [CHECKER] Probable security holes in 2.6.5
Message-ID: <20040420183808.J21045@build.pdx.osdl.net>
References: <1082134916.19301.7.camel@dns.coverity.int> <20040416115406.X22989@build.pdx.osdl.net> <20040421013402.GI29954@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040421013402.GI29954@dualathlon.random>; from andrea@suse.de on Wed, Apr 21, 2004 at 03:34:02AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrea Arcangeli (andrea@suse.de) wrote:
> On Fri, Apr 16, 2004 at 11:54:06AM -0700, Chris Wright wrote:
> > +	if (mc.idx >= dma->buf_count)
> > +		return -EINVAL;
> > +
> >  	i810_dma_dispatch_mc(dev, dma->buflist[mc.idx], mc.used,
> >  		mc.last_render );
> 
> this is wrong, idx is signed, so you've to check for negative values
> too. Credit for noticing this doesn't belong to me though.

Yes, you are right.  I thought I had specifically checked and found it
unsigned.  Thanks for catching that.

> Could you just in case review the other fixes too for other potential
> errors like this? thanks.

Yes, I'll do a double check.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
