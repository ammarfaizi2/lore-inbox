Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbVIURrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbVIURrO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVIURrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:47:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:137 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751327AbVIURrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:47:11 -0400
Date: Wed, 21 Sep 2005 10:46:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: pavel@suse.cz, ebiederm@xmission.com, len.brown@intel.com,
       drzeus-list@drzeus.cx, acpi-devel@lists.sourceforge.net,
       ncunningham@cyclades.com, masouds@masoud.ir,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Message-Id: <20050921104615.2e8dd7d5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
	<20050921101855.GD25297@atrey.karlin.mff.cuni.cz>
	<Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Wed, 21 Sep 2005, Pavel Machek wrote:
> > 
> > I think you are not following the proper procedure. All the patches
> > should go through akpm.
> 
> One issue is that I actually worry that Andrew will at some point be where 
> I was a couple of years ago - overworked and stressed out by just tons and 
> tons of patches. 

Patches are very low overhead, really.  It's patches which don't work which
take lots of time - a single dud patch can take hours and can make me think
rude thoughts about its originator.

> Yes, he's written/modified tons of patch-tracking tools, and the git 
> merging hopefully avoids some of the pressures, but it still worries me. 
> If Andrew burns out, we'll all suffer hugely.
> 
> I'm wondering what we can do to offset those kinds of issues. I _do_ like 
> having -mm as a staging area and catching some problems there, so going 
> through andrew is wonderful in that sense, but it has downsides.
> 
> Andrew?
> 

I'm doin OK.

Patch volume isn't a problem wrt the simple mechanics of handling them. 
The problem we have at present is lack of patch reviewing bandwidth.  I'll
be tightening things up in that area.  Relatively few developers seem to
have the stomach to do a line-by-line through large patches, and it would
be nice to refocus people a bit on that.  Christoph's work is hugely
appreciated, thanks.

Famous last words, but the actual patch volume _has_ to drop off one day. 
In fact there doesn't seem to much happening out there wrt 2.6.15.

Bugs are a big problem - it takes 4 hours minimum to get a -mm out the door
and a single bug can cause it to slip to the next day in which case I have
to start again.  A couple of times it has taken over two days just to get
together a tree which boots on four architectures and compiles on seven.

I'm spending more and more time on bugs now.  We have hundreds of bugs
which people have taken the time to report, which the relevant developers
know about and NOTHING IS HAPPENING.  "I can't reproduce it" is not an
adequate reason when there are nice testers out there who are available to
work through the diagnosis process.  We have hundreds of machines out there
which we are known to have broken and developers just need to reapportion
some of their time to getting these things fixed.

The -mm tree does prevent a large amount of crap from hitting mainline -
I'd guess the bug leakthrough rate is ~10%, although that 90% tends to be
the easy stuff - often compile errors.  I'd like to release -mm's more
often and I'd like -mm to have less of a wild-and-crappy reputation.  Both
of these would happen if originators were to test ther stuff more
carefully.


