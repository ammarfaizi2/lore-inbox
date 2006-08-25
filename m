Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWHYXDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWHYXDz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 19:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWHYXDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 19:03:55 -0400
Received: from ns.suse.de ([195.135.220.2]:41872 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964789AbWHYXDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 19:03:54 -0400
Date: Fri, 25 Aug 2006 16:03:16 -0700
From: Greg KH <greg@kroah.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, stable@kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Nix <nix@esperi.org.uk>,
       linux-kernel@vger.kernel.org, Neil Brown <neilb@suse.de>,
       netdev@vger.kernel.org
Subject: Re: [2.6.17.8] NFS stall / BUG in UDP fragment processing / SKB trimming
Message-ID: <20060825230316.GA3254@kroah.com>
References: <87zme9fy94.fsf@hades.wkstn.nix> <20060813125910.GA18463@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813125910.GA18463@gondor.apana.org.au>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 10:59:11PM +1000, Herbert Xu wrote:
> On Sat, Aug 12, 2006 at 09:19:19PM +0000, Nix wrote:
> > 
> > The kernel log showed a heap of BUGs from somewhere inside the skb
> > management layer, somewhere in UDP fragment processing while
> > handling NFS requests. It starts like this:
> > 
> > Aug 12 21:31:08 hades warning: kernel: BUG: warning at include/linux/skbuff.h:975/__skb_trim()
> > Aug 12 21:31:08 hades warning: kernel: <c030ed39> ip_append_data+0x5b3/0x951  <c030fc18> ip_generic_getfrag+0x0/0x96
> 
> Oops, I missed this code path when I disallowed skb_trim from operating
> on a paged skb.  This patch should fix the problem.
> 
> Greg, we need this for 2.6.17 stable as well if Dave is OK with it.

This patch doesn't apply at all to the latest 2.6.17-stable kernel tree.
Care to rediff it?

thanks,

greg k-h
