Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWGRVJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWGRVJU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 17:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWGRVJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 17:09:20 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:53120 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1750707AbWGRVJT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 17:09:19 -0400
Date: Tue, 18 Jul 2006 14:09:50 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: David Miller <davem@davemloft.net>
Cc: chrisw@sous-sol.org, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       jeremy@goop.org, ak@suse.de, akpm@osdl.org, rusty@rustcorp.com.au,
       zach@vmware.com, ian.pratt@xensource.com,
       Christian.Limpach@cl.cam.ac.uk, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 32/33] Add the Xen virtual network device driver.
Message-ID: <20060718210950.GG2654@sequoia.sous-sol.org>
References: <20060718091807.467468000@sous-sol.org> <20060718091958.414414000@sous-sol.org> <20060718.134219.48395353.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060718.134219.48395353.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Miller (davem@davemloft.net) wrote:
> From: Chris Wright <chrisw@sous-sol.org>
> Date: Tue, 18 Jul 2006 00:00:32 -0700
> 
> > +#ifdef CONFIG_XEN_BALLOON
> > +#include <xen/balloon.h>
> > +#endif
> 
> Let's put the ifdefs in xen/balloon.h not in the files
> including it.
> 
> > +#ifdef CONFIG_XEN_BALLOON
> > +	/* Tell the ballon driver what is going on. */
> > +	balloon_update_driver_allowance(i);
> > +#endif
> 
> Similarly let's define empty do-nothing functions in
> xen/balloon.h when the config option isn't set so we
> don't need to crap up the C sources with these ifdefs.

Yeah, sorry it's kept more as a reminder to me.  Upstream Xen doesn't do
this, but this patchset doesn't support ballooning yet, so there just is
not xen/balloon.h in the set.  When merging with upstream Xen there's
patch rejects either way, so I agree, better to just drop this since
it's just future placeholder.

thanks,
-chris
