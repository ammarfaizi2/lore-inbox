Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbVKOXiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbVKOXiI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 18:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbVKOXiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 18:38:08 -0500
Received: from ns2.suse.de ([195.135.220.15]:6866 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965077AbVKOXiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 18:38:06 -0500
From: Andi Kleen <ak@suse.de>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 5/5] Light Fragmentation Avoidance V20: 005_configurable
Date: Wed, 16 Nov 2005 00:39:20 +0100
User-Agent: KMail/1.8.2
Cc: linux-mm@kvack.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, lhms-devel@lists.sourceforge.net
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie> <20051115165012.21980.51131.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051115165012.21980.51131.sendpatchset@skynet.csn.ul.ie>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511160039.21243.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 November 2005 17:50, Mel Gorman wrote:
> The anti-defragmentation strategy has memory overhead. This patch allows
> the strategy to be disabled for small memory systems or if it is known the
> workload is suffering because of the strategy. It also acts to show where
> the anti-defrag strategy interacts with the standard buddy allocator.

If anything this should be a boot time option or perhaps sysctl, not a config.
In general CONFIGs that change runtime behaviour are evil - just makes
changing the option more painful, causes problems for distribution
users, doesn't make much sense, etc.etc.

Also #ifdef as a documentation device is a really really scary concept.
Yuck.

-Andi

