Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUHJI5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUHJI5D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUHJI46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:56:58 -0400
Received: from holomorphy.com ([207.189.100.168]:10983 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263626AbUHJIzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:55:50 -0400
Date: Tue, 10 Aug 2004 01:55:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Seth, Rohit" <rohit.seth@intel.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Hugetlb demanding paging for -mm tree
Message-ID: <20040810085531.GI11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Seth, Rohit" <rohit.seth@intel.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	Hirokazu Takahashi <taka@valinux.co.jp>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <01EF044AAEE12F4BAAD955CB750649430200560D@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01EF044AAEE12F4BAAD955CB750649430200560D@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <> wrote on Monday, August 09, 2004 11:59 AM:
>> As things stand in mainline, it's not an obvious issue. Ken appears to
>> be calling it for hugetlb in the ZFOD fault handling patches, which
>> have the issue that it may behave badly in several respects when
>> acting on large pages. The cache coherency bits in update_mmu_fault()
>> are necessary in general, but mainline omits them. It should only
>> result in intermittent failures on machines with sufficiently
>> incoherent caches. 

On Tue, Aug 10, 2004 at 01:52:02AM -0700, Seth, Rohit wrote:
> Will the flush_dcache_page for hugepages even on incoherent caches be
> not enough.  And that flush_dcache_page should be done in alloc_hugepage
> after clearing the page(or change the clear_highpage to
> clear_user_high_page).

Could you rephrase that? I'm having trouble figuring out what you meant.


-- wli
