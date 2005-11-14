Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVKNWbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVKNWbQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 17:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbVKNWbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 17:31:16 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:45996 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932208AbVKNWbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 17:31:15 -0500
Subject: Re: [RFC] NUMA memory policy support for HUGE pages
From: Adam Litke <agl@us.ibm.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-mm@kvack.org, ak@suse.de, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com, wli@holomorphy.com
In-Reply-To: <Pine.LNX.4.62.0511141340160.4663@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0511111051080.20589@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.62.0511111225100.21071@schroedinger.engr.sgi.com>
	 <1131980814.13502.12.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0511141340160.4663@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: IBM
Date: Mon, 14 Nov 2005 16:30:10 -0600
Message-Id: <1132007410.13502.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-14 at 13:46 -0800, Christoph Lameter wrote:
> This is V2 of the patch.
> 
> Changes:
> 
> - Cleaned up by folding find_or_alloc() into hugetlb_no_page().

IMHO this is not really a cleanup.  When the demand fault patch stack
was first accepted, we decided to separate out find_or_alloc_huge_page()
because it has the page_cache retry loop with several exit conditions.
no_page() has its own backout logic and mixing the two makes for a
tangled mess.  Can we leave that hunk out please?

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

