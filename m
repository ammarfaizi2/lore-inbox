Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUGXRy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUGXRy4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 13:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUGXRy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 13:54:56 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:43494 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261685AbUGXRyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 13:54:53 -0400
Date: Sat, 24 Jul 2004 10:54:42 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Robert Love <rml@ximian.com>
Cc: Michael Clark <michael@metaparadigm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
Message-ID: <20040724175442.GA26222@plexity.net>
Reply-To: dsaxena@plexity.net
References: <1090604517.13415.0.camel@lucy> <4101D14D.6090007@metaparadigm.com> <1090638881.2296.14.camel@localhost> <20040724150838.GA24765@plexity.net> <1090683953.2296.78.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090683953.2296.78.camel@localhost>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 24 2004, at 11:45, Robert Love was caught saying:
> 
> > > The easiest way to avoid that is simply to use a name similar to the
> > > path name.
> > 
> > What is the path name of a device from the kernels point of view?
> > Since device naming in /dev is left up to userland now, it has to
> > be something else that the kernel is aware of.
> 
> I might not of been clear - path name of the file in the kernel source
> tree.  So if you add an event to fs/open.c the path is
> "/org/kernel/fs/open".  This is a pretty generic naming scheme that
> ensures names will be unique within the kernel and will not conflict
> with names outside the kernel (e.g. the global URI space of whatever is
> used in user-space).

Oh ok, that makes much more sense now. "arch/kerne/cpu" is the
name of the file, from which that message came.

> > an incredibly arbitrary string), we pass the object name and attribute name 
> > to user space.  User space can then go read the appropriate sysfs file or take 
> > whatever other action is required to determine what the state change actually 
> > is.
> 
> Agreed.  Not passing the data and just passing a "change occurred" flag
> is a good idea in many cases.  For example, for "new filesystem mounted"
> I think it makes most sense to just send out a "new filesystem mounted"
> signal and not include the data.  Let user-space rescan /proc/mtab in
> response.
> 
> But we cannot do that for everything.
> 
> "high" is only an arbitrary string if it is not standardized.  If the
> temperature event is defined to come from such and such an interface,
> with such and such values, it is all very easy to use.  I mean, this is
> how object systems work today.

I think we agree.  So are there some existing docs that you/Ximian has 
on reccomended usage and object naming? I didn't see anything on 
freedesktop.org.  That's where a lot of my questions are coming from. We 
have this really simple events system, but how do we expect it to be used
in the kernel.

~Deepak


~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
