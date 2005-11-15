Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbVKOWXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbVKOWXR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 17:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbVKOWXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 17:23:17 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:46060 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965045AbVKOWXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 17:23:16 -0500
Subject: Re: [PATCH] hugepages: fold find_or_alloc_pages into huge_no_page()
From: Adam Litke <agl@us.ibm.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-mm@kvack.org, ak@suse.de, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com, wli@holomorphy.com, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.62.0511151345470.11011@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0511151345470.11011@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: IBM
Date: Tue, 15 Nov 2005 16:22:09 -0600
Message-Id: <1132093329.22243.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-15 at 13:47 -0800, Christoph Lameter wrote:
> The number of parameters for find_or_alloc_page increases significantly after
> policy support is added to huge pages. Simplify the code by folding
> find_or_alloc_huge_page() into hugetlb_no_page().
> 
> Adam Litke objected to this piece in an earlier patch but I think this is a
> good simplification. Diffstat shows that we can get rid of almost half of the
> lines of find_or_alloc_page(). If we can find no consensus then lets simply drop
> this patch.

Okay.  Since I am the only objector I'll be willing to back down if
we're sure find_or_alloc_huge_page() has no extra value as a separate
function.  Five parameters is getting a bit unwieldy and suggests it's
usefulness outside of hugetlb_no_page() is near zero.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

