Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWIXTuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWIXTuw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 15:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWIXTuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 15:50:52 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:694 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1750782AbWIXTuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 15:50:51 -0400
Message-ID: <4516E089.4000004@s5r6.in-berlin.de>
Date: Sun, 24 Sep 2006 21:46:17 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Willy Tarreau <w@1wt.eu>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-pre1
References: <20060922222300.GA5566@stusta.de> <20060922223859.GB21772@kroah.com> <20060922224735.GB5566@stusta.de> <20060922230928.GB22830@kroah.com> <20060923045610.GM541@1wt.eu> <20060923232150.GK5566@stusta.de> <20060923235315.GB24214@1wt.eu> <20060924181641.GA4547@stusta.de>
In-Reply-To: <20060924181641.GA4547@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> But having:
> - two saa7134 cards in your computer and
> - one of them formerly not supported and
> - depending on one of them being the first one
> is a case you can theoretically construct, but then there's the point 
> that this is highly unlikely,

Yes, this is an unlikely scenario.

> and OTOH the value of the added support is more realistic.

But then I think people don't really expect additional hardware support
from a stable kernel series.

> If I was as extremely regarding regressions as you describe regarding 
> hardware updates, I would also have to reject any bugfixes that are not 
> security fixes since they might cause regressions.
> 
> I do know that the only value of the 2.6.16 tree lies in a lack of 
> regressions and act accordingly, but I'm trying to do this in a 
> pragmatic way.

If there was more manpower, driver updates could be maintained as extra
patchkits separately to the kernel. I know that some people would like
to have exactly this: A minimally updated base plus a choice of specific
driver updates as add-ons.

In fact that's what I do with the IEEE 1394 drivers --- although not
primarily to support this kind of user base but rather to make it easier
to get bugfixes tested by bug reporters. However I can only afford to do
this by an all-or-nothing approach: I put almost _all_ driver changes
into these patchkits. That means full risk of regressions but also
complete feature updates and minimal divergence from mainline. This was
trivial to do so far.
-- 
Stefan Richter
-=====-=-==- =--= ==---
http://arcgraph.de/sr/
