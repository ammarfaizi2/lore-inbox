Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbUJYV7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbUJYV7n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 17:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbUJYV4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 17:56:31 -0400
Received: from holomorphy.com ([207.189.100.168]:61918 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261847AbUJYVzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 17:55:41 -0400
Date: Mon, 25 Oct 2004 14:52:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V1 [4/4]: Numa patch
Message-ID: <20041025215219.GY17038@holomorphy.com>
References: <20041022194040.GC17038@holomorphy.com> <200410252122.i9PLMYq08987@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410252122.i9PLMYq08987@unix-os.sc.intel.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 12:37:13PM -0700, Christoph Lameter wrote:
>> How about this variation following __alloc_page:

William Lee Irwin III wrote on Friday, October 22, 2004 12:41 PM
>> Looks reasonable. The bit that struck me as quirky was the mpol_* on
>> the NULL vma. This pretty much eliminates the hidden dispatch, so I'm
>> happy.

On Mon, Oct 25, 2004 at 02:25:09PM -0700, Chen, Kenneth W wrote:
> The allocate from next best node is orthogonal to hugetlb demand paging.
> This should be merged once all the bugs are fixed and later when demand
> paging goes in, we can add the mpol_* stuff.

I'm not too picky about this. It appears to be the 4th of the series,
so assuming they go in in order that should meet your expectations. I
am significantly more concerned about the flush_dcache_page() issue in
general, though. I guess this should light a fire under my backside to
dredge up the docs describing the proper TLB flushing methods to use
in conjunction with large page extensions for the affected arches.


-- wli
