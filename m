Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbULXWMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbULXWMs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 17:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbULXWMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 17:12:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39085 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261449AbULXWMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 17:12:46 -0500
Date: Fri, 24 Dec 2004 17:12:32 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Robert_Hentosh@Dell.com, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
In-Reply-To: <20041224164024.GK4459@dualathlon.random>
Message-ID: <Pine.LNX.4.61.0412241711180.11520@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0412201013080.13935@chimarrao.boston.redhat.com>
 <20041220125443.091a911b.akpm@osdl.org> <Pine.LNX.4.61.0412231420260.5468@chimarrao.boston.redhat.com>
 <20041224160136.GG4459@dualathlon.random> <Pine.LNX.4.61.0412241118590.11520@chimarrao.boston.redhat.com>
 <20041224164024.GK4459@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2004, Andrea Arcangeli wrote:

>> I am already running with akpm's total_scanned, my lowering of
>> the dirty limit for non-highmem capable mappings and my "do not
>> OOM kill if we had to skip writes due to congestion" patch.
>
> Did you apply Con's disable-swap-token leaving the sysctl to the default
> value after applying that patch?
>
> Of course I know if you don't apply Con's fix it will run oom, you don't
> need a cp for that.

The process 'dd', and all the other processes, live in
the highmem zone, which has 2.5GB of memory free. Now
tell me again why you think the swap token has any
relevance to those 950MB of pagecache that is filling
up lowmem ?


-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
