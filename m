Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWDVUM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWDVUM5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWDVUM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:12:57 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:18633 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751138AbWDVUM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:12:56 -0400
Date: Sat, 22 Apr 2006 14:38:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [PATCH] 'make headers_install' kbuild target.
Message-ID: <20060422123835.GA5010@stusta.de>
References: <1145672241.16166.156.camel@shinybook.infradead.org> <20060422093328.GM19754@stusta.de> <1145707384.16166.181.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145707384.16166.181.camel@shinybook.infradead.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2006 at 01:03:03PM +0100, David Woodhouse wrote:
> On Sat, 2006-04-22 at 11:33 +0200, Adrian Bunk wrote:
>...
> Ideally, I'd like to proceed by splitting files into user-visible and
> kernel-private parts in _separate_ headers, so that the 'unifdef' part
> becomes unnecessary (and __KERNEL__ disappears entirely). I've done some
> of that already in include/mtd). It would also be nice if we could then
> put the user-visible files into a separate directory, so that the
> 'headers_export' step becomes nothing more than a 'cp -a'. We do need to
> do this incrementally though, and I think this is going to be the best
> way to do it, and to get it accepted.

This sounds like what I had in mind.

> > Unless someone can tell me a reason why this wouldn't work (except for 
> > being a bit more work than your approach), this is the approach I have 
> > in mind for working on.
> 
> Your approach is basically what we proposed at last year's Kernel
> Summit. It was shot down though, so we're trying to start simple and do
> it incrementally. 

What was the recommended way for getting userspace header at last year's 
kernel summit?

> The important thing is that we all get our editors out and clean up the
> _contents_ our own headers, and actually start to _think_ about the
> visibility of any new header-file content we introduce. Let's not
> concentrate too much on the implementation details of how we actually
> get those to userspace.

Currently, it's said the kernel headers aren't suitable for userspace.

After the cleanups you propose, the kernel headers will be suitable for 
userspace (the copy steps you propose are not required, distributions 
could equally start to copy the verbatim headers again).

If everyone is working in a different direction, this is only wasting 
work.

> dwmw2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

