Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266491AbUJAUc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266491AbUJAUc2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUJAUcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:32:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50887 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266491AbUJAUaS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:30:18 -0400
Date: Fri, 1 Oct 2004 16:04:30 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, piggin@cyberone.com.au, arjanv@redhat.com,
       linux-kernel@vger.kernel.org, haveblue@us.ibm.com
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
Message-ID: <20041001190430.GA4372@logos.cnet>
References: <20041001182221.GA3191@logos.cnet> <20041001131147.3780722b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041001131147.3780722b.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2004 at 01:11:47PM -0700, Andrew Morton wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> > The following patch implements a "coalesce_memory()" function 
> > which takes "zone" and "order" as a parameter. 
> > 
> > It tries to move enough physically nearby pages to form a free area
> > of "order" size.
> > 
> > It does that by checking whether the page can be moved, allocating a new page, 
> > unmapping the pte's to it, copying data to new page, remapping the ptes, 
> > and reinserting the page on the radix/LRU.
> 
> Presumably this duplicates some of the memory hot-remove patches.

As far as I have researched, the memory moving/remapping code 
on the hot remove patches dont work correctly. Please correct me.

And what I've seen (from the Fujitsu guys) was quite ugly IMHO.

> Apparently Dave Hansen has working and sane-looking hot remove code
> which is in a close-to-submittable state.

Dave?
