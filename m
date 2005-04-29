Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbVD2EVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbVD2EVM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 00:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVD2EVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 00:21:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:28324 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262380AbVD2EUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 00:20:43 -0400
Date: Thu, 28 Apr 2005 21:14:33 -0700
From: Greg KH <greg@kroah.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Chris Wright <chrisw@osdl.org>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Rules about the -stable tree
Message-ID: <20050429041433.GA25474@kroah.com>
References: <20050427171446.GA3195@kroah.com> <42702AC4.2030500@yahoo.com.au> <20050428013342.GM23013@shell0.pdx.osdl.net> <42703FB5.3050408@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42703FB5.3050408@yahoo.com.au>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 11:43:17AM +1000, Nick Piggin wrote:
> Chris Wright wrote:
> >* Nick Piggin (nickpiggin@yahoo.com.au) wrote:
> >
> >>Wanna take some buffer fixes?
> >
> >
> >Do they meet the -stable criteria?  If so, please send 'em over.
> >
> 
> Where do I find the -stable criteria?

Here they are again, I will send a patch that adds them to the kernel
tree.

thanks,

greg k-h

------

Everything you ever wanted to know about Linux 2.6 -stable releases.

Rules on what kind of patches are accepted, and what ones are not, into
the "-stable" tree:

 - It must be obviously correct and tested.
 - It can not bigger than 100 lines, with context.
 - It must fix only one thing.
 - It must fix a real bug that bothers people (not a, "This could be a
   problem..." type thing.)
 - It must fix a problem that causes a build error (but not for things
   marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
   security issue, or some "oh, that's not good" issue.  In short,
   something critical.
 - No "theoretical race condition" issues, unless an explanation of how
   the race can be exploited.
 - It can not contain any "trivial" fixes in it (spelling changes,
   whitespace cleanups, etc.)
 - It must be accepted by the relevant subsystem maintainer.
 - It must be accepted to mainline, or the accepted mainline patch be
   deemed too complex or risky to backport and thus a simple obvious
   alternative fix applied to stable ONLY.
 - It must follow Documentation/SubmittingPatches rules.

Procedure for submitting patches to the -stable tree:

 - Send the patch, after verifying that it follows the above rules, to
   stable@kernel.org.
 - The sender will receive an ack when the patch has been accepted into
   the queue, or a nak if the patch is rejected.  This response might
   take a few days, according to the developer's schedules.
 - If accepted, the patch will be added to the -stable queue, for review
   by other developers.
 - Security patches should not be sent to this alias, but instead to the
   documented security@kernel.org.  
   
Review cycle:

 - When the -stable maintainers decide for a review cycle, the patches
   will be sent to the review committee, and the maintainer of the
   affected area of the patch (unless the submitter is the maintainer of
   the area) and CC: to the linux-kernel mailing list.
 - The review committee has 48 hours in which to ack or nak the patch.
 - If the patch is rejected by a member of the committee, or linux-kernel
   members object to the patch, bringing up issues that the maintainers
   and members did not realize, the patch will be dropped from the
   queue.
 - At the end of the review cycle, the acked patches will be added to
   the latest -stable release, and a new -stable release will happen.
 - Security patches will be accepted into the -stable tree directly from
   the security kernel team, and not go through the normal review cycle.
   Contact the kernel security team for more details on this procedure.

Review committe:

 - This will be made up of a number of kernel developers who have
   volunteered for this task, and a few that haven't.

