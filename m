Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbUKLHln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbUKLHln (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 02:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbUKLHln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 02:41:43 -0500
Received: from [195.135.223.242] ([195.135.223.242]:1408 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262470AbUKLHll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 02:41:41 -0500
Date: Thu, 11 Nov 2004 20:22:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Broken kunmap calls in rc4-mm1.
Message-ID: <20041111192251.GB997@elf.ucw.cz>
References: <1100135825.7402.32.camel@desktop.cunninghams> <20041111012919.GD3217@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111012919.GD3217@holomorphy.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > That oops in kunmap got me thinking of my recent DEBUG_HIGHMEM
> > additions, so I want for a walk through the -mm4 patch, and found plenty
> > of instances of people making the same mistake I did... using the struct
> > page * in the call to kunmap, rather than the virtual address.
> > I guess the best way to handle it is find/notify the respective authors
> > of patches in the tree? The problems are in:
> > Reiser4 (lots)
> > CacheFS (lots)
> > afs
> > binfmt_elf
> > libata_core
> > (I'm hoping some of the above people will see this message and save me
> > some effort :>)
> 
> That only applies to kunmap_atomic(); kunmap()'s argument should be a page.

Is it just me or is having two very similar functions
(kunmap/kunmap_atomic) pretty counter-intuitive? Perhaps kunmap should
be renamed to kunmap_page() or something?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
