Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVBODBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVBODBx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 22:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVBODBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 22:01:53 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:6350 "EHLO
	mail.bitmover.com") by vger.kernel.org with ESMTP id S261572AbVBODBt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 22:01:49 -0500
Date: Mon, 14 Feb 2005 19:01:45 -0800
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BK] upgrade will be needed
Message-ID: <20050215030145.GB6288@bitmover.com>
Mail-Followup-To: lm@bitmover.com,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20050214174932.GB8846@bitmover.com> <1108406835.8413.20.camel@localhost.localdomain> <20050214190137.GB16029@bitmover.com> <1108415541.8413.48.camel@localhost.localdomain> <20050214231148.GP13174@bitmover.com> <1108425420.8413.78.camel@localhost.localdomain> <20050215000028.GS13174@bitmover.com> <1108426451.8413.84.camel@localhost.localdomain> <20050215003535.GB32158@bitmover.com> <1108429259.8413.99.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108429259.8413.99.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 08:00:59PM -0500, Steven Rostedt wrote:
> I guess you are dealing with three groups of people.
> 
> 1) The ones paying you. The companies that spend money to get things
> done.  -- Needs full version of BK.

Agreed.

> 2) The Open Source developers, Linus and others that like BK and will
> work with it with whatever license you give it. -- Needs strong version
> of BK. Probably no more than 100 users (or less).

We could handle these guys by selling/donating commercial seats.
But while we started out with the goal of helping the Linux effort,
specifically Linus, other open source projects have gotten past
the license and found value in the product: mysql, xaraya, xen, etc.
Whatever we do we can't do anything which would disrupt their efforts,
that's not reasonable.

> 3) The Open Source users, tweakers, hackers that are not the core
> developers. -- Needs only to checkout the kernel. Probably over 1000
> users.  I fall in this category.

Would the tarball + patch server suffice for you?  We could make a
ChangeSet file which had bk changes -v output in it and that would 
give you a fairly useful set of version information.  For those who
don't know, bk changes -v is output in time sorted order of changesets
with the changeset comments then each file's comments like the output
below.  

This server wouldn't be much use for someone trying to track down the
source of a bug, you'd really need the BK2CVS tree for that or a BK
tree.  In some ways, the BK2CVS tree is far nicer because you can do
binary search on it, but as Roman/Pavel/et al have pointed out sometimes
the commits in the CVS tree are too coarse if the cset you want is a
merge of 20 changesets on a branch.  In that case you want the BK tree.

But for people trying to easily track the head the tarball server might
be just the ticket.  Erik (codepoet guy) would probably love it (right?).
If it would help people feel better about us and/or make their lives easier
we can set up that server for all the repos on bkbits.net.  I suspect
that it would help at least some people out there.

--lm

ChangeSet@1.2044, 2005-02-14 18:09:02+00:00, rmk@flint.arm.linux.org.uk
+3 -0
  [ARM] Fix sparse warnings for Integrator builds.
  
  Add some missing __iomem annotations for Integrator machines.
  
  Signed-off-by: Russell King <rmk@arm.linux.org.uk>

  arch/arm/mach-integrator/impd1.c@1.9, 2005-02-14 18:03:31+00:00, rmk@flint.arm .linux.org.uk +1 -1
    Add sparse __iomem annotations.

  arch/arm/mach-integrator/time.c@1.9, 2005-02-14 18:03:31+00:00, rmk@flint.arm.  linux.org.uk +4 -4
    Add sparse __iomem annotations.
    Use "dev" rather than "rtc_base" for the device id when requesting
    the RTC interrupt.

  drivers/input/serio/ambakmi.c@1.13, 2005-02-14 18:03:31+00:00, rmk@flint.arm.l inux.org.uk +1 -1
    Add sparse __iomem annotations.


> This is why we have asked about three versions. Obviously, Linus and
> friends are the most important part for the Linux community, so even if
> it hurts 2000 other people that only want to download the lastest
> snapshots from BK, it really doesn't matter.  Let us complain, but
> unless Linus decides to go elsewhere, we are stuck.  So don't do the
> crippled version if it hurts Linus.
> 
> -- Steve
> 

-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
