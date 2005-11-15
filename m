Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbVKOXiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbVKOXiH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 18:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbVKOXiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 18:38:06 -0500
Received: from mail.suse.de ([195.135.220.2]:60848 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965076AbVKOXiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 18:38:05 -0500
From: Andi Kleen <ak@suse.de>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 2/5] Light Fragmentation Avoidance V20: 002_usemap
Date: Wed, 16 Nov 2005 00:36:53 +0100
User-Agent: KMail/1.8.2
Cc: linux-mm@kvack.org, mingo@elte.hu, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie> <20051115164957.21980.8731.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051115164957.21980.8731.sendpatchset@skynet.csn.ul.ie>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511160036.54461.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 November 2005 17:49, Mel Gorman wrote:
> This patch adds a "usemap" to the allocator. Each bit in the usemap indicates
> whether a block of 2^(MAX_ORDER-1) pages are being used for kernel or
> easily-reclaimed allocations. This enumerates two types of allocations;

This will increase cache line footprint, which is costly.
Why can't this be done in the page flags?

-Andi

