Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270380AbTGRWdU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 18:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270373AbTGRWdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 18:33:19 -0400
Received: from holomorphy.com ([66.224.33.161]:6537 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270393AbTGRWcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 18:32:20 -0400
Date: Fri, 18 Jul 2003 15:48:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22pre6aa1
Message-ID: <20030718224824.GP15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <20030717102857.GA1855@dualathlon.random> <20030718191853.A11052@infradead.org> <20030718222750.GL3928@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718222750.GL3928@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 12:27:50AM +0200, Andrea Arcangeli wrote:
> bigpages= is a documented API that has to be used in production, so I
> can easily add the hugetlbfs API but I guess I've to keep this one
> anyways. I also would need to verify the performance of hugetlbfs before
> suggesting migrating to it, for example I don't want
> preallocation/prefaulting (IIRC hugetlbfs preallocates everything). I
> also like the single huge array of page pointers, that is very hardwired
> but optimal for those workloads.

Most of the complaints I've gotten are about lack of support for mixed
PSE and non-PSE mappings, not preallocation or performance (generally
its usage doesn't involve creation/destruction cycle performance
requirements, and most of the time they intend to use 100% of the memory).

It's basically too stupid and operating on too small a data set to
screw up performance-wise apart from creation/destruction, which is not
intended to be performant (and will never be; it blits oversized areas).

I wouldn't mind hearing of what you believe is missing, so long as it's
within the constraints of what's mergeable. =(


-- wli
