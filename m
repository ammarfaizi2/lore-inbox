Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267916AbUIBSmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267916AbUIBSmN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 14:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268036AbUIBSmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 14:42:13 -0400
Received: from peabody.ximian.com ([130.57.169.10]:21198 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267916AbUIBSmI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 14:42:08 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@ximian.com>
To: Daniel Stekloff <dsteklof@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, kay.sievers@vrfy.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1094150112.1316.55.camel@DYN319498.beaverton.ibm.com>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
	 <20040831145643.08fdf612.akpm@osdl.org>
	 <1093989513.4815.45.camel@betsy.boston.ximian.com>
	 <20040831150645.4aa8fd27.akpm@osdl.org>
	 <1093989924.4815.56.camel@betsy.boston.ximian.com>
	 <20040902083407.GC3191@kroah.com>
	 <1094142321.2284.12.camel@betsy.boston.ximian.com>
	 <1094150112.1316.55.camel@DYN319498.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 02 Sep 2004 14:41:32 -0400
Message-Id: <1094150493.2284.19.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 11:35 -0700, Daniel Stekloff wrote:

> The only problem I see is making an app sift through all of the events
> to get to a specific type of event. They'd have to parse and match the
> signal, that could be costly. 

I'd hope that they were not that many events that it would ever be
costly.

But this should be mitigated by your event aggregator in user-space,
whether that is D-BUS or whatever else.  If it is D-BUS, you could then
subscribe via D-BUS only to the events you care about.

> Will there be small single purpose applications listening on the netlink
> socket or off dbus for specific signals? Or do you see this mainly
> handled by a single kevent daemon? 

Whatever you want to do.

I think they way we would set up our Linux desktop product would have D-
BUS listening on the kevent socket and propagating the events up the
stack (or have a separate daemon listen and funnel the events to D-BUS.
whatever).

Then applications up the stack would respond to and handle the D-BUS
signals.

	Robert Love


