Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965159AbVKPBvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbVKPBvJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 20:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbVKPBvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 20:51:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:60640 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965159AbVKPBvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 20:51:07 -0500
From: Andi Kleen <ak@suse.de>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 2/5] Light Fragmentation Avoidance V20: 002_usemap
Date: Wed, 16 Nov 2005 02:52:04 +0100
User-Agent: KMail/1.8.2
Cc: linux-mm@kvack.org, mingo@elte.hu, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie> <200511160036.54461.ak@suse.de> <Pine.LNX.4.58.0511160137540.8470@skynet>
In-Reply-To: <Pine.LNX.4.58.0511160137540.8470@skynet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511160252.05494.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 November 2005 02:43, Mel Gorman wrote:

> 1. I was using a page flag, valuable commodity, thought I would get kicked
>    for it. Usemap uses 1 bit per 2^(MAX_ORDER-1) pages. Page flags uses
>    2^(MAX_ORDER-1) bits at worse case.

Why does it need multiple bits? A page can only be in one order at a
time, can't it?

> 2. Fragmentation avoidance tended to break down, very fast.

Why? The algorithm should the same, no?

> 3. When changing a block of pages from one type to another, there was no
>    fast way to make sure all pages currently allocation would end up on
>    the correct free list

If you can change the bitmap you can change as well mem_map

-Andi
