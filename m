Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422730AbVLONpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422730AbVLONpr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 08:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422729AbVLONpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 08:45:47 -0500
Received: from smtp-relay.dca.net ([216.158.48.66]:42453 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S1422728AbVLONpq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 08:45:46 -0500
Date: Thu, 15 Dec 2005 08:45:45 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [BUG] Xserver startup locks system... git bisect results
Message-ID: <20051215134545.GB12327@jupiter.solarsys.private>
References: <20051215043212.GA4479@jupiter.solarsys.private> <1134622384.16880.26.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134622384.16880.26.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin:

* Benjamin Herrenschmidt <benh@kernel.crashing.org> [2005-12-15 15:53:03 +1100]:
> On Wed, 2005-12-14 at 23:32 -0500, Mark M. Hoffman wrote:
> > Hello:
> > 
> > git bisect said:
> > > 47807ce381acc34a7ffee2b42e35e96c0f322e52 is first bad commit
> > > diff-tree 47807ce381acc34a7ffee2b42e35e96c0f322e52 (from 0e670506668a43e1355b8f10c33d081a676bd521)
> > > Author: Dave Airlie <airlied@linux.ie>
> > > Date:   Tue Dec 13 04:18:41 2005 +0000
> > > 
> > >     [drm] fix radeon aperture issue
> > 
> > With this one applied, my machine locks up tight just after starting the
> > Xserver.  Some info (dmesg, lspci, config) is here:
> > 
> > http://members.dca.net/mhoffman/lkml-20051214/
> > 
> > I can put a serial console on it if necessary, but not until about this
> > time tomorrow.
> 
> You have to love this X radeon driver ... you can't fix one bug without
> breaking something else, it's one of the worst piece of crap I've ever
> seen...
> 
> What would be useful now is the X version and maybe trying a little hack
> in the X driver. Do you have ways to rebuild the X driver at all ?

Check the link again for log & config.  I have not built any part of X
from source before.  But if it's necessary, I will try it.

> The problem is, that patch actually fixes some users... Ah, also, could
> you maybe add some printk's around the code that is modified by that
> patch and try to catch the value it tries to use before the lockup ?
> 
> That is, print the values of:
> 
> dev_priv->fb_location
> 
> and
> 
> RADEON_READ(RADEON_CONFIG_APER_SIZE)

These suggestions, along with later ones that involve recompiles... I will try
them late this evening (EST).

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

