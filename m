Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbULYCHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbULYCHw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 21:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbULYCHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 21:07:52 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:62336 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261470AbULYCHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 21:07:38 -0500
Date: Sat, 25 Dec 2004 03:07:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Robert_Hentosh@Dell.com, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
Message-ID: <20041225020707.GQ13747@dualathlon.random>
References: <Pine.LNX.4.61.0412201013080.13935@chimarrao.boston.redhat.com> <20041220125443.091a911b.akpm@osdl.org> <Pine.LNX.4.61.0412231420260.5468@chimarrao.boston.redhat.com> <20041224160136.GG4459@dualathlon.random> <Pine.LNX.4.61.0412241118590.11520@chimarrao.boston.redhat.com> <20041224164024.GK4459@dualathlon.random> <Pine.LNX.4.61.0412241711180.11520@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412241711180.11520@chimarrao.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2004 at 05:12:32PM -0500, Rik van Riel wrote:
> The process 'dd', and all the other processes, live in
> the highmem zone, which has 2.5GB of memory free. Now
> tell me again why you think the swap token has any
> relevance to those 950MB of pagecache that is filling
> up lowmem ?

If 2.5G of ram is really free, then how can the oom killer be invoked in
the first place? If that happens it means you're under a lowmem
shortage, something you apparently ruled out when you said
lowmem_reserve couldn't help your workload.

If you would post a vmstat before and after the oom killing plus the
exact oom killer syslog dump, it would help to see what's going on.

I sure can't reproduce your problem here with 2.6.10-rc3 + the 4 patches
I posted (so with swap-token disabled).
