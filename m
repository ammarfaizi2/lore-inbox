Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264031AbUCZM0v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 07:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264035AbUCZM0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 07:26:51 -0500
Received: from holomorphy.com ([207.189.100.168]:14732 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264031AbUCZM0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 07:26:49 -0500
Date: Fri, 26 Mar 2004 04:26:36 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>, akpm@osdl.org,
       torvalds@osdl.org, hugh@veritas.com, mbligh@aracnet.com,
       riel@redhat.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040326122636.GX791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Rajesh Venkatasubramanian <vrajesh@umich.edu>, akpm@osdl.org,
	torvalds@osdl.org, hugh@veritas.com, mbligh@aracnet.com,
	riel@redhat.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <Pine.LNX.4.44.0403150527400.28579-100000@localhost.localdomain> <Pine.GSO.4.58.0403211634350.10248@azure.engin.umich.edu> <20040325225919.GL20019@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040325225919.GL20019@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 11:59:19PM +0100, Andrea Arcangeli wrote:
> btw, the truncate of hugetlbfs didn't serialize correctly against the
> do_no_page page faults, that's fixed too.

If a fault on hugetlb ever got as far as do_no_page() on ia32, the
kernel would oops on the bogus struct page it gets out of the bogus
pte.  I believe the way faults are handled in out-of-tree patches if by
calling hugetlb-specific fault handling stacks instead of
handle_mm_fault() if hugetlb vmas are found by arch code.


-- wli
