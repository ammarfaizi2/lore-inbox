Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266808AbUBEUQQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 15:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266809AbUBEUQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 15:16:15 -0500
Received: from mail.kroah.org ([65.200.24.183]:20896 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266808AbUBEUQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 15:16:09 -0500
Date: Thu, 5 Feb 2004 12:16:05 -0800
From: Greg KH <greg@kroah.com>
To: "Tillier, Fabian" <ftillier@infiniconsys.com>
Cc: "Hefty, Sean" <sean.hefty@intel.com>, linux-kernel@vger.kernel.org,
       Troy Benjegerdes <hozer@hozed.org>,
       "Woodruff, Robert J" <woody@co.intel.com>,
       "Magro, Bill" <bill.magro@intel.com>,
       "Woodruff, Robert J" <woody@jf.intel.com>,
       infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in the Linux kernel
Message-ID: <20040205201605.GC14646@kroah.com>
References: <08628CA53C6CBA4ABAFB9E808A5214CB01DB96C2@mercury.infiniconsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08628CA53C6CBA4ABAFB9E808A5214CB01DB96C2@mercury.infiniconsys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 02:44:07PM -0500, Tillier, Fabian wrote:
> 
> The component library (the abstraction layer used by IBAL) is in no way
> tied to InfiniBand.  Whatever is in there can be used by any other
> projects, and there's a lot of useful stuff in there that does provide
> value.

Great, if you think so, please provide patches to the main kernel tree
for all of us to see.  Just don't try to bury it in a driver subsystem.
That is my complaint.

> One goal of IBAL is to get InfiniBand support for Linux.  As such, it is
> a higher priority to get things working than to wait for changes to
> appear in the Linux kernel before making forward progress.

Isn't it a better idea to try to work with the community, instead of
ignoring them and thinking that you are progressing ahead of them?  :)

> Keep in mind also that InfiniBand is not a Linux-only technology.
> Sharing code between different operating systems accelerates development
> and reduces the cost of maintenance.

For your driver subsystem, possibly.  I know the whole history of ACPI,
and how that is developed too.  Also remember all of the man-hours that
were spent getting that acpi code into the proper shape for Linux...

> Lastly, there are things (like timers) that are blatantly missing from
> user-mode in Linux, and having an abstraction here allows code to be
> shared between kernel and user mode.

Again, patches are always appreciated to address anything that you feel
is missing in Linux.

> Keep in mind that we're not expecting you or the Linux community to
> blindly take the code as is.

That's good, as you have yet to even submit anything :)

> We're looking for constructive feedback to
> make it so that everyone goes home happy.  It's disappointing that the
> feedback we're getting from you is that any abstractions will be cause
> for rejection.  What are the grounds for this policy?

Um, "no one else does it as it is not necessary," is not enough?

> What does it accomplish?  Is portable code a problem for the Linux
> community in general?

Not at all.  Just look at the vast array of different hardware platforms
that Linux runs on!  And look at how almost all drivers work on all of
those platforms with no changes needed!  We are all for portability.

> Removing the abstraction from the IBAL project would require
> significant rework of the code that would add very little from a
> functional perspective, and make the code base more complicated and
> harder to maintain.

Harder for whom to maintain?  You, or the rest of the kernel community?
Remember, once your code is in the tree, everyone is free to make
changes to it, that's the power of a community effort.

That's enough of this, just submit a patch and we can work from there,
with real, technical answers for specific technical issues.

thanks,

greg k-h
