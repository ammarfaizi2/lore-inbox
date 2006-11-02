Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWKBEFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWKBEFI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 23:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWKBEFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 23:05:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:50639 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750734AbWKBEFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 23:05:04 -0500
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/11] Avoiding fragmentation with subzone groupings v26
References: <20061101111620.18798.34778.sendpatchset@skynet.skynet.ie>
From: Andi Kleen <ak@suse.de>
Date: 02 Nov 2006 05:04:57 +0100
In-Reply-To: <20061101111620.18798.34778.sendpatchset@skynet.skynet.ie>
Message-ID: <p734ptilcie.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mel@csn.ul.ie> writes:
> 
> Our tests show that about 60-70% of physical memory can be allocated on
> a desktop after a few days uptime. In benchmarks and stress tests, we are
> finding that 80% of memory is available as contiguous blocks at the end of
> the test. To compare, a standard kernel was getting < 1% of memory as large
> pages on a desktop and about 8-12% of memory as large pages at the end of
> stress tests.

If you don't have a fixed limit on the unreclaimable memory you could
still get into a situation where all memory is fragmented and unreclaimable,
right?

It might be much harder to hit, but we have so many users that at least
a few will eventually.

> Performance tests are within 0.1% for kbuild on a number of test machines. aim9
> is usually within 1% 

1% is a lot.

-Andi
