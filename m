Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264260AbUG1VUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbUG1VUs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUG1VUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:20:47 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:16844 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264260AbUG1VUg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:20:36 -0400
Subject: Re: [PATCH] reduce swsusp casting
From: Dave Hansen <haveblue@us.ibm.com>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0407281405090.31994-100000@monsoon.he.net>
References: <1091043436.2871.320.camel@nighthawk>
	 <Pine.LNX.4.50.0407281405090.31994-100000@monsoon.he.net>
Content-Type: text/plain
Message-Id: <1091049624.2871.464.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 14:20:24 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-28 at 14:07, Patrick Mochel wrote:
> On Wed, 28 Jul 2004, Dave Hansen wrote:
> 
> > I noticed that swsusp uses quite a few interesting casts for __pa() and
> > cousins.  This patch moves some types around to eliminate some of those
> > casts in the normal code.  The casts that it adds are around alloc's and
> > frees, which is a much more usual place to see them.
> >
> > Pavel also noticed that there's a superfluous PAGE_ALIGN() right before
> > a >>PAGE_SHIFT in pfn_is_nosave(), so that's been removed as well.
> 
> What are these patches against? I released a bunch of patches to swsusp
> and pmdisk two weeks ago. I'm not sure if Andrew has picked them up yet.
> It would be nice if you would patch against those.

It was against 2.6.8-rc1-mm1, but I can patch against whatever.  Do you
have those patches consolidated somewhere, or is it best that I look in
the archives?

> > I haven't had a chance to do anything but test it, because that would
> > involve me setting up a swsusp rig, which I'm more prone to screw up
> > than the patch itself :)  I'd appreciate if anyone with a stable setup
> > could make sure I didn't do anything too stupid.
> 
> I don't understand - have you really tested it or just compile-tested it?
> If not, please do try it out for real. There is no reason to be scared of
> swsusp, and the more people that use it, the more stable it will get.

I'm not scared, just lazy :)  I'll give it a shot.

-- Dave

