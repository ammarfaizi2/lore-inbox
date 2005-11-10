Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbVKJEWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbVKJEWD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 23:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbVKJEWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 23:22:03 -0500
Received: from holomorphy.com ([66.93.40.71]:59872 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S1751030AbVKJEWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 23:22:01 -0500
Date: Wed, 9 Nov 2005 20:20:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Rohit Seth <rohit.seth@intel.com>, Adam Litke <agl@us.ibm.com>,
       akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       hugh@veritas.com, kenneth.w.chen@intel.com
Subject: Re: [PATCH 4/4] Hugetlb: Copy on Write support
Message-ID: <20051110042020.GP29402@holomorphy.com>
References: <1131578925.28383.9.camel@localhost.localdomain> <1131579596.28383.25.camel@localhost.localdomain> <1131587564.16514.53.camel@akash.sc.intel.com> <20051110035403.GM17840@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110035403.GM17840@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 05:52:44PM -0800, Rohit Seth wrote:
>> lazy_mmu_prot_update will need to called here to make caches coherent
>> for some archs.

On Thu, Nov 10, 2005 at 02:54:03PM +1100, David Gibson wrote:
> Ah, yes indeed.  Revised version below.  While I was at it, I moved
> set_huge_ptep_writable() into mm/hugetlb.c, since there's no actual
> need for it to be in the .h, and abolished huge_ptep_set_wrprotect()
> since there's no need for the macro at all.
> Hugetlb: Copy on Write support

Re-acking. Good catch, thanks Rohit.

Acked-by: William Irwin <wli@holomorphy.com>


-- wli
