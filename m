Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265648AbTLIHkM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 02:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265649AbTLIHkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 02:40:12 -0500
Received: from mhub-w5.tc.umn.edu ([160.94.160.35]:6109 "EHLO
	mhub-w5.tc.umn.edu") by vger.kernel.org with ESMTP id S265648AbTLIHkF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 02:40:05 -0500
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
From: Matthew Reppert <repp0017@tc.umn.edu>
To: Bob <recbo@nishanet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, witukind@nsbm.kicks-ass.org
In-Reply-To: <3FD577E7.9040809@nishanet.com>
References: <200312081536.26022.andrew@walrond.org>
	 <20031208154256.GV19856@holomorphy.com>	<3FD4CC7B.8050107@nishanet.com>
	 <20031208233755.GC31370@kroah.com>
	 <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org>
	 <3FD577E7.9040809@nishanet.com>
Content-Type: text/plain
Message-Id: <1070955596.25311.19.camel@minerva>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 01:39:56 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-09 at 01:21, Bob wrote:
> Witukind wrote:
> 
> >From the udev FAQ:
> >
> >Q: But udev will not automatically load a driver if a /dev node is opened
> >   when it is not present like devfs will do.
> >A: If you really require this functionality, then use devfs.  It is still
> >   present in the kernel.
> >
> >Will it have this 'equivalent functionality' some day?
> >
> >
> >  
> >
> Shouldn't hotplug handle it?

How would hotplug handle it?

Or, more directly ... on my system, /dev is just a normal directory
on an ext2 filesystem. If something tries to open a file on it that
doesn't exist, open will just return ENOENT. How is open supposed to
know that someone is trying to open a device node? The naive solution
is to conditionally check for the presence of "/dev" at the beginning
of all requested filenames that don't exist, which strikes me as ...
well, not necessarily a good idea. (I can't really say why beyond gut
feeling.)

My guess is, unfortunately, udev probably won't handle this any time
soon. (Or, if it does, through some possibly clever mechanism that, as
someone unfamiliar with the relevant bits of the system, I can't see.)
I'd be interested in a solution to this, mostly out of curiosity since
it seems like it might be interesting, but I don't see a nice one coming
easily. I wouldn't mind someone more clueful telling me I'm wrong,
though. At the least, it means more people being receptive to moving
to udev.

Matt

