Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266646AbUG1Wao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266646AbUG1Wao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266284AbUG1W3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:29:50 -0400
Received: from gprs214-195.eurotel.cz ([160.218.214.195]:4480 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266603AbUG1W2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:28:10 -0400
Date: Thu, 29 Jul 2004 00:27:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reduce swsusp casting
Message-ID: <20040728222753.GA16494@elf.ucw.cz>
References: <1091043436.2871.320.camel@nighthawk> <Pine.LNX.4.50.0407281405090.31994-100000@monsoon.he.net> <1091049624.2871.464.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091049624.2871.464.camel@nighthawk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I noticed that swsusp uses quite a few interesting casts for __pa() and
> > > cousins.  This patch moves some types around to eliminate some of those
> > > casts in the normal code.  The casts that it adds are around alloc's and
> > > frees, which is a much more usual place to see them.
> > >
> > > Pavel also noticed that there's a superfluous PAGE_ALIGN() right before
> > > a >>PAGE_SHIFT in pfn_is_nosave(), so that's been removed as well.
> > 
> > What are these patches against? I released a bunch of patches to swsusp
> > and pmdisk two weeks ago. I'm not sure if Andrew has picked them up yet.
> > It would be nice if you would patch against those.
> 
> It was against 2.6.8-rc1-mm1, but I can patch against whatever.  Do you
> have those patches consolidated somewhere, or is it best that I look in
> the archives?

-rc1-mm1 includes all (or nearly all) patches from patrick, it should
be okay ....

wait, no, sorry, you really need to patch against 2.6.8-rc2-mm1.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
