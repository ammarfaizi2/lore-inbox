Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbUKVXTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbUKVXTs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbUKVXRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:17:37 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:48595 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261862AbUKVXNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:13:34 -0500
Date: Mon, 22 Nov 2004 15:13:25 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, hugh@veritas.com, torvalds@osdl.org,
       benh@kernel.crashing.org, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: deferred rss update instead of sloppy rss
In-Reply-To: <41A271AE.7090802@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0411221510470.24333@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
 <20041122141148.1e6ef125.akpm@osdl.org> <Pine.LNX.4.58.0411221408540.22895@schroedinger.engr.sgi.com>
 <20041122144507.484a7627.akpm@osdl.org> <Pine.LNX.4.58.0411221444410.22895@schroedinger.engr.sgi.com>
 <41A271AE.7090802@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004, Nick Piggin wrote:

> > The timer tick occurs every 1 ms. The maximum pagefault frequency that I
> > have  seen is 500000 faults /second. The max deviation is therefore
> > less than 500 (could be greater if page table lock / mmap_sem always held
> > when the tick occurs).
> I think that by the time you get the spilling code in, the mm-list method
> will be looking positively elegant!

I do not care what gets in as long as something goes in to address the
performance issues. So far everyone seems to have their pet ideas. By all
means do the mm-list method and post it. But we have already seen
objections by other against loops in proc. So that will also cause
additional controversy.
