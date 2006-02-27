Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWB0UNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWB0UNW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWB0UNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:13:21 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:3216 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S932332AbWB0UNV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:13:21 -0500
Date: Mon, 27 Feb 2006 12:13:23 -0800
From: Greg KH <gregkh@suse.de>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060227201323.GB12111@suse.de>
References: <20060227190150.GA9121@kroah.com> <20060227193654.GA12788@kvack.org> <20060227194623.GC9991@suse.de> <20060227200107.GA14011@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227200107.GA14011@kvack.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 03:01:07PM -0500, Benjamin LaHaise wrote:
> On Mon, Feb 27, 2006 at 11:46:23AM -0800, Greg KH wrote:
> > Then I suggest you work with the ALSA developers to come up with such a
> > "stable" api that never changes.  They have been working at this for a
> > number of years, if it was a "simple" problem, it would have been done
> > already...
> 
> That depends on how it's being approached.  Writing an ABI takes effort, 
> while it tends to be easier to simply write new code.

I agree.

> > Anyway, netlink is in the same category, with a backing userspace
> > library tie :)
> > 
> > And, I have nothing against shipping userspace libraries with the kernel
> > like this, if people think that's the easiest way to do it.  But even
> > then, the raw interface is still "private" and you need to use the
> > library to access it properly.
> 
> That's a lot easier if it gets installed with the kernel version as part of 
> the path.  That might need some hacking in the dynamic linker.  Before going 
> that far, it should really be a question of putting the ABI and necessary 
> extensions under a microscope to see how much stability in an ABI is 
> possible.  Perhaps we've been too lax in reviewing extensions to the kernel's 
> ABI, resulting in things getting to the point where it now needs to be a 
> more explicit part of the review process.
> 
> Half the problem is that the bits that actually form an ABI tend to be 
> spread over random .c source files, include/asm and include/linux, so 
> catching a change is rather difficult even for experienced reviewers.  It 
> might make sense to start splitting out the structure definitions into an 
> include/abi/ structure to make changes easier to spot.  It'll be a lot of 
> work, but along the lines of the whole ioctl mess the end result will be 
> an easier system for users to cope with (which is the main concern in 
> maintaining an ABI -- making needless updates necessary for users and 
> software authors is something I feel we should try to avoid).

Again, I agree.  People (including Linus) have said they will accept
something like include/abi/ (it was a different name last time that I
can't remember), but no one has done the work yet...

thanks,

greg k-h
