Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVBQX55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVBQX55 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVBQX5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 18:57:46 -0500
Received: from news.suse.de ([195.135.220.2]:22973 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261218AbVBQX52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 18:57:28 -0500
Date: Fri, 18 Feb 2005 00:57:19 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andi Kleen <ak@suse.de>, benh@kernel.crashing.org, nickpiggin@yahoo.com.au,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] page table iterators
Message-ID: <20050217235719.GB31591@wotan.suse.de>
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au> <20050217194336.GA8314@wotan.suse.de> <1108680578.5665.14.camel@gaston> <20050217230342.GA3115@wotan.suse.de> <20050217153031.011f873f.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050217153031.011f873f.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 03:30:31PM -0800, David S. Miller wrote:
> On Fri, 18 Feb 2005 00:03:42 +0100
> Andi Kleen <ak@suse.de> wrote:
> 
> > And to be honest we only have about 6 or 7 of these walkers
> > in the whole kernel. And 90% of them are in memory.c
> > While doing 4level I think I changed all of them around several
> > times and it wasn't that big an issue.  So it's not that we
> > have a big pressing problem here... 
> 
> It's super error prone.  A regression added by your edit of these

Actually it was in Nick's code (PUD layer ;-).  But I won't argue
that my code didn't have bugs too...

> walkers for the 4level changes was only discovered and fixed
> yesterday by the ppc folks.
> 
> I absolutely support any change which consolidates these things.

The problem is just that these walker macros when they
do all the lazy walking stuff will be quite complicated.
And I don't really want another uaccess.h-like macro mess.

Yes currently they look simple, but that will change.

Open coding is probably the smaller evil.

And they're really not changed that often.

-Andi
