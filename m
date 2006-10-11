Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161068AbWJKO4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbWJKO4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 10:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161069AbWJKO4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 10:56:50 -0400
Received: from ns2.suse.de ([195.135.220.15]:29852 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161068AbWJKO4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 10:56:49 -0400
Date: Wed, 11 Oct 2006 16:56:43 +0200
From: Nick Piggin <npiggin@suse.de>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] mm: add arch_alloc_page
Message-ID: <20061011145643.GA5259@wotan.suse.de>
References: <20061007105758.14024.70048.sendpatchset@linux.site> <20061007105824.14024.85405.sendpatchset@linux.site> <20061007134345.0fa1d250.akpm@osdl.org> <452856E4.60705@yahoo.com.au> <1160578104.634.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160578104.634.2.camel@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 04:48:24PM +0200, Martin Schwidefsky wrote:
> On Sun, 2006-10-08 at 11:39 +1000, Nick Piggin wrote:
> > >On Sat,  7 Oct 2006 15:06:04 +0200 (CEST)
> > >Nick Piggin <npiggin@suse.de> wrote:
> > >
> > >
> > >>Add an arch_alloc_page to match arch_free_page.
> > >>
> > >
> > >umm.. why?
> > >
> > 
> > I had a future patch to more kernel_map_pages into it, but couldn't
> > decide if that's a generic kernel feature that is only implemented in
> > 2 architectures, or an architecture speicifc feature. So I left it out.
> > 
> > But at least Martin wanted a hook here for his volatile pages patches,
> > so I thought I'd submit this patch anyway.
> 
> With Nicks patch I can use arch_alloc_page instead of page_set_stable,
> but I can still not use arch_free_page instead of page_set_unused
> because it is done before the check for reserved pages. If reserved
> pages go away or the arch_free_page call would get moved after the check
> I could replace page_set_unused as well. So with Nicks patch we are only
> halfway there..

Ahh, but with my patchSET I think we are all the way there ;)

Nick
