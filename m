Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161017AbWAXSTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbWAXSTl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 13:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWAXSTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 13:19:40 -0500
Received: from gold.veritas.com ([143.127.12.110]:35845 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932478AbWAXSTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 13:19:40 -0500
Date: Tue, 24 Jan 2006 18:20:18 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Dave McCracken <dmccr@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
In-Reply-To: <321DE6430A7C77745B5B8275@[10.1.1.4]>
Message-ID: <Pine.LNX.4.61.0601241816430.5373@goblin.wat.veritas.com>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
 <Pine.LNX.4.61.0601202020001.8821@goblin.wat.veritas.com>
 <6F40FCDC9FFDE7B6ACD294F5@[10.1.1.4]> <Pine.LNX.4.61.0601241604550.4262@goblin.wat.veritas.com>
 <321DE6430A7C77745B5B8275@[10.1.1.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Jan 2006 18:19:39.0788 (UTC) FILETIME=[BD6E2CC0:01C62112]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2006, Dave McCracken wrote:
> --On Tuesday, January 24, 2006 17:50:17 +0000 Hugh Dickins
> <hugh@veritas.com> wrote:
> > On Mon, 23 Jan 2006, Dave McCracken wrote:
> > 
> >> I needed a function that returns a struct page for pgd and pud, defined
> >> in each architecture.  I decided the simplest way was to redefine
> >> pgd_page and pud_page to match pmd_page and pte_page.  Both functions
> >> are pretty much used one place per architecture, so the change is
> >> trivial.  I could come up with new functions instead if you think it's
> >> an issue.  I do have a bit of a fetish about symmetry across levels :)
> > 
> > Sounds to me like you made the right decision.
> 
> I had a thought... would it be preferable for me to make this change as a
> separate patch across all archictures in the name of consistency?  Or

Yes - but don't expect it to be taken if your shared pagetables aren't:
just submit it as the first(ish) patch in your shared pagetables series.

> should I continue to roll it into the shared pagetable patch as we enable
> each architecture?

Hugh
