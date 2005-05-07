Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVEGCCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVEGCCv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 22:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVEGCCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 22:02:51 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:37069 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261498AbVEGCCr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 22:02:47 -0400
To: Andrew Morton <akpm@osdl.org>
cc: sharada@in.ibm.com, paulus@samba.org, torvalds@osdl.org, anton@samba.org,
       linux-kernel@vger.kernel.org, miltonm@bga.com, fastboot@lists.osdl.org,
       maneesh@in.ibm.com, varap@us.ibm.com, rddunlap@osdl.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] ppc64: kexec support for ppc64 
In-reply-to: Your message of Fri, 06 May 2005 17:32:11 PDT.
             <20050506173211.0bc2db7e.akpm@osdl.org> 
Date: Fri, 06 May 2005 19:02:40 -0700
Message-Id: <E1DUEeO-0006lx-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 06 May 2005 17:32:11 PDT, Andrew Morton wrote:
> Gerrit Huizenga <gh@us.ibm.com> wrote:
> >
> > [ ... ]
> >
> 
> But you didn't address the question of whether the kexec feature is
> sufficiently useful in its own right to justify merging.

Yeah - I skirted that.  I like kexec by itself for quick reboots but
I honestly haven't used it much for that.  I am *really* interested
in kdump + kexec, and kdump depends on kexec.  Working with two moving
targets has been a bit more challenging, hence I'd prefer to see kexec
stable as a provider technology so we can address the bugs and build
the kdump support on top.

> >   If it takes a little list or test matrix of platforms tested over the
> >   short term to help verify what machines work, we might be able to set
> >   something like that up as well.
> 
> Yes, please do that.  But remember that Linux has a distributed test team
> of thousands.  I have a separate proposal:

I'll see if we can find a way to make this happen - even tracking
a little web page of "My IBM T41p successfully ran kexec" or "My
G5 ran kexec" would be useful info, I think as a starting point.

Something like:

Hardware	Ran kexec	Ran kdump	Kdump was useful

should be enough to record some success, as at least a starting point.

> My big checkbox for kdump is "can I personally use kdump to diagnose and
> solve testers' bug reports?".
 
Now *this* I completely agree with.  That is the ultimate goal.  And,
we've had challenges with this internally because kexec & kdump have
been under so much churn.  We have a grid of machines for testing, and
I *know* we get a bunch of Oopses during development.  We have someone
looking into integrating kexec/kdump into that environment so that every
Ooops leads to a crash dump.  It has been rough going with kexec & kdump
in churn, so stabilizing will actually help us with this.

> If we can reach the stage where a random person downloads a -mm kernel,
> hits a bug and, with a reasonable success rate, can send me a kernel core
> file which I find useful then yeah, it's proven.

Completely agreed.

> Problem is, I haven't gotten around to moving this idea an inch forward and
> am unlikely to do so.
 
Understood.  We'll do what we can from our end but as always, help from
any quarter is appreciated.

> It would really help if some of the kdump developers could assist: make
> sure the instructions are easy, that the tools are available, work with
> people on the mailing list to get a core file from them, then, using the
> core file, work with the relevant maintainer to identify and solve the bug.
> We did this a few weeks ago with the -mm timer deadlock.  Off-list, I think.
> 
> Possible?

Yes.  I'll push this a little more on Monday from our side and maybe we
can get a little independent help/verification from Randy, Eric, etc.

gerrit
