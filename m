Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWIUFHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWIUFHx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 01:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWIUFHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 01:07:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25512 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750825AbWIUFHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 01:07:52 -0400
Date: Wed, 20 Sep 2006 22:07:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.19 -mm merge plans
Message-Id: <20060920220744.0427539d.akpm@osdl.org>
In-Reply-To: <45121382.1090403@garzik.org>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	<45121382.1090403@garzik.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 00:22:26 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Andrew Morton wrote:
> > A wander through the -mm patch queue, along with some commentary on my
> > intentions.
> > 
> > 
> > When replying to this email, please rewrite the Subject: to something
> > appropriate.  Please also attempt to cc the appropriate developer(s).
> > 
> > 
> > There are quite a lot of patches here which belong in subsystem trees. 
> > I'll patchbomb the relevant maintainers soon.  Could I pleeeeeze ask that
> > they either merge the patches or solidly nack them (with reasons)?  Don't
> > just ignore it all and leave me hanging onto this stuff for ever.  Thanks.
> 
> I know this is probably heresy, but what would happen if we didn't merge 
> all that stuff at once, and then committed to having a real 4-week cycle?

(where'd 4 weeks come from?)

Why would a shorter cycle be better?  What are we trying to achieve?

> The cycles seem to be stretching out again, and I don't really think 
> it's worth it to hold up the entire kernel for every single piddly 
> little regression to get fixed.  We'll _never_ be perfect, even if we 
> weren't slackers.
> 

People seem to treat the stabilisation period as a wonderful quiet time in
which to run off and develop new features, rather than participating in the
stabilisation.  This has the following effects:

1: release cycles get longer

2: the kernel has more bugs

3: we put new features into the kernel faster than we otherwise would
   (see 2:, above).


Furthermore, in this period we have 60-odd disjoint trees which are based
on a relatively-slowly-changing mainline.  This makes people think they are
free to go berzerk, leaving me bemusedly wondering why there are VFS and
NFS changes in the OCFS2 tree, SATA changes in the powerpc tree, SATA
changes in the scsi tree, configfs changes in the GFS2 tree,
every-goddam-thing changes in the driver tree, MM changes in the parisc
tree, etc, etc, etc.

If you think that shortening the release cycle will cause people to be more
disciplined in their changes, to spend less time going berzerk and to spend
more time working with our users and testers on known bugs then I'm all
ears.



So...  it again comes down to "what are we trying to achieve"?  Me, I'd
like to see people spending less time developing whizzy new things and more
time fixing bugs, tuning performance, etc.  That would fix the lengthy
release cycle problem automatically.

What do _you_ want to achieve by making changes?


And a question.  The current batch of git trees has:

 2611 files changed, 295643 insertions(+), 130150 deletions(-)

How much of this has been suitably reviewed?

