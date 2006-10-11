Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030446AbWJKOsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbWJKOsZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 10:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030451AbWJKOsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 10:48:24 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:16327 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030446AbWJKOsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 10:48:24 -0400
Subject: Re: [patch 3/3] mm: add arch_alloc_page
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <452856E4.60705@yahoo.com.au>
References: <20061007105758.14024.70048.sendpatchset@linux.site>
	 <20061007105824.14024.85405.sendpatchset@linux.site>
	 <20061007134345.0fa1d250.akpm@osdl.org>  <452856E4.60705@yahoo.com.au>
Content-Type: text/plain
Organization: IBM Corporation
Date: Wed, 11 Oct 2006 16:48:24 +0200
Message-Id: <1160578104.634.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 11:39 +1000, Nick Piggin wrote:
> >On Sat,  7 Oct 2006 15:06:04 +0200 (CEST)
> >Nick Piggin <npiggin@suse.de> wrote:
> >
> >
> >>Add an arch_alloc_page to match arch_free_page.
> >>
> >
> >umm.. why?
> >
> 
> I had a future patch to more kernel_map_pages into it, but couldn't
> decide if that's a generic kernel feature that is only implemented in
> 2 architectures, or an architecture speicifc feature. So I left it out.
> 
> But at least Martin wanted a hook here for his volatile pages patches,
> so I thought I'd submit this patch anyway.

With Nicks patch I can use arch_alloc_page instead of page_set_stable,
but I can still not use arch_free_page instead of page_set_unused
because it is done before the check for reserved pages. If reserved
pages go away or the arch_free_page call would get moved after the check
I could replace page_set_unused as well. So with Nicks patch we are only
halfway there..

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


