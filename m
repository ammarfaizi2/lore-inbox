Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWIXUKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWIXUKM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 16:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWIXUKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 16:10:12 -0400
Received: from 1wt.eu ([62.212.114.60]:15635 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751294AbWIXUKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 16:10:10 -0400
Date: Sun, 24 Sep 2006 21:44:09 +0200
From: Willy Tarreau <w@1wt.eu>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Adrian Bunk <bunk@stusta.de>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-pre1
Message-ID: <20060924194409.GA31404@1wt.eu>
References: <20060922222300.GA5566@stusta.de> <20060922223859.GB21772@kroah.com> <20060922224735.GB5566@stusta.de> <20060922230928.GB22830@kroah.com> <20060923045610.GM541@1wt.eu> <20060923232150.GK5566@stusta.de> <20060923235315.GB24214@1wt.eu> <20060924181641.GA4547@stusta.de> <4516E089.4000004@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4516E089.4000004@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 09:46:17PM +0200, Stefan Richter wrote:
> Adrian Bunk wrote:
> > But having:
> > - two saa7134 cards in your computer and
> > - one of them formerly not supported and
> > - depending on one of them being the first one
> > is a case you can theoretically construct, but then there's the point 
> > that this is highly unlikely,
> 
> Yes, this is an unlikely scenario.
> 
> > and OTOH the value of the added support is more realistic.
> 
> But then I think people don't really expect additional hardware support
> from a stable kernel series.
> 
> > If I was as extremely regarding regressions as you describe regarding 
> > hardware updates, I would also have to reject any bugfixes that are not 
> > security fixes since they might cause regressions.
> > 
> > I do know that the only value of the 2.6.16 tree lies in a lack of 
> > regressions and act accordingly, but I'm trying to do this in a 
> > pragmatic way.
> 
> If there was more manpower, driver updates could be maintained as extra
> patchkits separately to the kernel. I know that some people would like
> to have exactly this: A minimally updated base plus a choice of specific
> driver updates as add-ons.

If there was more manpower, the same principle as I adopted for the
2.4-hotfix series would be applicable :

  - maintain multiple older versions in parallel
  - only apply critical fixes.

=> That way, people choose the version they will work with based on a
   feature set, and they benefit from fixes only. But this is an ideal
   world, and as Greg told us (and demonstrated), 2.6 is moving too fast
   to permit the maintenance of multiple branches in parallel. We won't
   clone Adrian for every new 2.6 which comes out :-)

However, I noticed (in 2.4) that raising the patch acceptance threshold
for a hotfix reduces the conflicts between versions and reduces the
amount of work needed to maintain multiple versions in parallel. I have
only 192 patches to cover all identified fixes between 2.4.28 and 2.4.33
and only one or two of them did require manual merging for old versions.
Anyway, this is still boring work.

> In fact that's what I do with the IEEE 1394 drivers --- although not
> primarily to support this kind of user base but rather to make it easier
> to get bugfixes tested by bug reporters. However I can only afford to do
> this by an all-or-nothing approach: I put almost _all_ driver changes
> into these patchkits. That means full risk of regressions but also
> complete feature updates and minimal divergence from mainline. This was
> trivial to do so far.
> -- 
> Stefan Richter
> -=====-=-==- =--= ==---
> http://arcgraph.de/sr/

Regards,
Willy

