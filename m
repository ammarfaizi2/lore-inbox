Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbUB0WY2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 17:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbUB0WY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 17:24:28 -0500
Received: from 64-186-161-006.cyclades.com ([64.186.161.6]:11193 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263151AbUB0WYU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 17:24:20 -0500
Date: Fri, 27 Feb 2004 20:18:29 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Andrew Morton <akpm@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
In-Reply-To: <20040227122936.4c1be1fd.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58L.0402272016170.19454@logos.cnet>
References: <20040227173250.GC8834@dualathlon.random>
 <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com>
 <20040227122936.4c1be1fd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Feb 2004, Andrew Morton wrote:

> Oh, and can we please have testcases?  It's all very well to assert "it
> sucks doing X and I fixed it" but it's a lot more useful if one can
> distrubute testcases as well so others can evaluate the fix and can explore
> alternative solutions.
>
> Andrea, this shmem problem is a case in point, please.
>
> > > in small machines the current 2.4 stock algo works just fine too, it's
> > > only when the lru has the million pages queued that without my new vm
> > > algo you'll do million swapouts before freeing the memleak^Wcache.
> >
> > Same for Arjan's O(1) VM.  For machines in the single and low
> > double digit number of gigabytes of memory either would work
> > similarly well ...
>
> Case in point.  We went round the O(1) page reclaim loop a year ago and I
> was never able to obtain a testcase which demonstrated the problem on 2.4,
> let alone on 2.6.
>
> I had previously found some workloads in which the 2.4 VM collapsed for
> similar reasons and those were fixed with the rotate_reclaimable_page()
> logic.  Without testcases we will not be able to verify that anything else
> needs doing.

Btw,

Andrew, are your testcases online somewhere?

I heard once someone was going to collect VM tests to make a "official
testing package", but that has never happened AFAIK.

