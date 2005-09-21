Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbVIUSDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVIUSDA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbVIUSDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:03:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34190 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751278AbVIUSC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:02:59 -0400
Date: Wed, 21 Sep 2005 11:02:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: torvalds@osdl.org, pavel@suse.cz, len.brown@intel.com,
       drzeus-list@drzeus.cx, acpi-devel@lists.sourceforge.net,
       ncunningham@cyclades.com, masouds@masoud.ir,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Message-Id: <20050921110201.1cc7fca2.akpm@osdl.org>
In-Reply-To: <m1slvycotk.fsf@ebiederm.dsl.xmission.com>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
	<20050921101855.GD25297@atrey.karlin.mff.cuni.cz>
	<Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>
	<m1slvycotk.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Wed, 21 Sep 2005, Pavel Machek wrote:
> >> 
> >> I think you are not following the proper procedure. All the patches
> >> should go through akpm.
> 
> Ok.  I thought it was fine to send simple and obviously correct bug
> fixes to Linus.

I habitually scoop up patches and will get them into Linus (preferably
after 1-2 -mm cycles) if he ducks them.

> > One issue is that I actually worry that Andrew will at some point be where 
> > I was a couple of years ago - overworked and stressed out by just tons and 
> > tons of patches. 
> >
> > Yes, he's written/modified tons of patch-tracking tools, and the git 
> > merging hopefully avoids some of the pressures, but it still worries me. 
> > If Andrew burns out, we'll all suffer hugely.
> >
> > I'm wondering what we can do to offset those kinds of issues. I _do_ like 
> > having -mm as a staging area and catching some problems there, so going 
> > through andrew is wonderful in that sense, but it has downsides.
> 
> It is especially challenging for people like me who typically work on
> parts of the kernel without a maintainer.  So there frequently isn't
> an intermediate I can submit my patches to.

Yup.  And MAINTAINERS has quite a few omissions.  I generally know who
should be poked and if there's nobody obvious I have 26000 patches to grep
through to find out who might know a bit about that code.  Low-level x86 is
a bit of a problem really because it has many cooks and no obvious chef.

Individual maintainers have differing response times, differing
attentiveness and differing patchloss ratios.

There's also confusion once I've cc'ed a maintainer on a patch over whether
I'll be sending it to Linus or whether I want them to.

If a maintainer has a tree in -mm then I'll autodrop the patch if they
merge it, so there's no confusion there.

If the maintainer says "thanks, merged" and I don't have their tree in -mm
then I'll tend to hang onto the patch indefinitely until it finally hits
-linus.  Or I'll eventually forget and merge it up anyway ;) 

If the maintainer just acks the patch I'll send it in to Linus.

If the maintainer nacks the patch I'll either drop it or I'll mark it
not-for-merging and hang onto it anwyay, as a reminder that we have some
bug which needs fixing.

If the maintainer has a tree in -mm and doesn't merge the patch I'll hang
onto it and periodically resend to the maintainer until some definite
response comes back.

