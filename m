Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbUJ0F6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbUJ0F6N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 01:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUJ0F56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 01:57:58 -0400
Received: from ozlabs.org ([203.10.76.45]:49611 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261660AbUJ0F4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 01:56:50 -0400
Date: Wed, 27 Oct 2004 15:23:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Christoph Lameter <clameter@sgi.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V2 [0/8]: Discussion and overview
Message-ID: <20041027052317.GG1676@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Christoph Lameter <clameter@sgi.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 06:26:42PM -0700, Christoph Lameter wrote:
> Changes from V1:
> - support huge pages in flush_dcache_page on various architectures
> - revised simple numa allocation
> - do not include update_mmu_cache in set_huge_pte. Require huge_update_mmu_cache
> 
> This is a revised edition of the hugetlb demand page patches by
> Kenneth Chen which were discussed in the following thread in August 2004
> 
> http://marc.theaimsgroup.com/?t=109171285000004&r=1&w=2
> 
> The initial post by Ken was in April in
> 
> http://marc.theaimsgroup.com/?l=linux-ia64&m=108189860401704&w=2
> 
> Hugetlb demand paging has been part of SuSE SLES 9 for awhile now
> and this patchset is intended to help hugetlb demand paging also get
> into the official Linux kernel. Huge pages are referred to as
> "compound" pages in terms of "struct page" in the Linux kernel. The
> term "compund page" may be used alternatively to huge page.

I wish we could start calling this "lazy allocation" instead of
"demand paging".  "Demand paging" makes people think of swapping
hugepages, or mapping files on real filesystems with hugepages, which
is not what these patches do, and probably something we don't want to
do.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
