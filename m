Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265690AbUFXVL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265690AbUFXVL5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265747AbUFXVL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:11:57 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:13345 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S265690AbUFXVKQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:10:16 -0400
Date: Thu, 24 Jun 2004 23:23:11 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Testing for kernel features in external modules
Message-ID: <20040624212311.GB4700@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040624203043.GA4557@mars.ravnborg.org> <20040624203516.GV31203@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624203516.GV31203@schnapps.adilger.int>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 02:35:16PM -0600, Andreas Dilger wrote:
> On Jun 24, 2004  22:30 +0200, Sam Ravnborg wrote:
> > +if [ -f remap4.o ]; then
> > +	echo "#define REMAP4 1" > $2
> > +elif [ -f remap5.o ]; then
> > +	echo "#define REMAP5 1" > $2
> > +fi
> 
> I would prefer that these be called something like HAVE_REMAP5, or
> better yet something descriptive like HAVE_REMAP_PAGE_RANGE_VMA.

Agreed - the above was just to give intro to the concept.
> 
> This obviously needs to be smarter also, to handle adding multiple
> #defines to a single .h file.
Agreed again - using >> would do the trick here.


The idea was to have a common way for external modules to detect
certain API changes, type changes etc. that would cause the build
to fail otherwise.

Also the code fragment shown were supposed to be part of the
external modules - not the main steram kernel.

> Ideally, when people make an incompatible kernel API change like this
> they would just #define HAVE_REMAP_PAGE_RANGE_VMA in the header that
> declares remap_page_range() directly (e.g. KERNEL_AS_O_DIRECT was added
> for this reason) instead of external builds having to figure this out
> themselves.  Adding the check script is no less work than just adding
> the #define to the appropriate header directly.

That practice would be nice.

	Sam
