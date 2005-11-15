Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbVKOM0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbVKOM0b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 07:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbVKOM0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 07:26:31 -0500
Received: from holomorphy.com ([66.93.40.71]:2511 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S932420AbVKOM0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 07:26:30 -0500
Date: Tue, 15 Nov 2005 04:18:22 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Adam Litke <agl@us.ibm.com>, linux-mm@kvack.org, ak@suse.de,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: [RFC] NUMA memory policy support for HUGE pages
Message-ID: <20051115121822.GB6916@holomorphy.com>
References: <Pine.LNX.4.62.0511111051080.20589@schroedinger.engr.sgi.com> <Pine.LNX.4.62.0511111225100.21071@schroedinger.engr.sgi.com> <1131980814.13502.12.camel@localhost.localdomain> <Pine.LNX.4.62.0511141340160.4663@schroedinger.engr.sgi.com> <1132007410.13502.35.camel@localhost.localdomain> <Pine.LNX.4.62.0511141523100.4676@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0511141523100.4676@schroedinger.engr.sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2005, Adam Litke wrote:
>> IMHO this is not really a cleanup.  When the demand fault patch stack
>> was first accepted, we decided to separate out find_or_alloc_huge_page()
>> because it has the page_cache retry loop with several exit conditions.
>> no_page() has its own backout logic and mixing the two makes for a
>> tangled mess.  Can we leave that hunk out please?

On Mon, Nov 14, 2005 at 03:25:00PM -0800, Christoph Lameter wrote:
> It seemed to me that find_or_alloc_huge_pages has a pretty simple backout 
> logic that folds nicely into no_page(). Both functions share a lot of 
> variables and putting them together not only increases the readability of 
> the code but also makes the function smaller and execution more efficient.

Looks like this is on the road to inclusion and so on. I'm not picky
about either approach wrt. nopage/etc. and find_or_alloc_huge_page()
affairs. Just get a consensus together and send it in.

Thanks.


-- wli
