Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266341AbUJAUPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbUJAUPG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUJAULS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:11:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:646 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266308AbUJAUII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:08:08 -0400
Date: Fri, 1 Oct 2004 13:11:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-mm@kvack.org, piggin@cyberone.com.au, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
Message-Id: <20041001131147.3780722b.akpm@osdl.org>
In-Reply-To: <20041001182221.GA3191@logos.cnet>
References: <20041001182221.GA3191@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> The following patch implements a "coalesce_memory()" function 
> which takes "zone" and "order" as a parameter. 
> 
> It tries to move enough physically nearby pages to form a free area
> of "order" size.
> 
> It does that by checking whether the page can be moved, allocating a new page, 
> unmapping the pte's to it, copying data to new page, remapping the ptes, 
> and reinserting the page on the radix/LRU.

Presumably this duplicates some of the memory hot-remove patches.

Apparently Dave Hansen has working and sane-looking hot remove code
which is in a close-to-submittable state.
