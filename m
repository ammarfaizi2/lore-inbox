Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbULWU5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbULWU5c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 15:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbULWU5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 15:57:32 -0500
Received: from waste.org ([216.27.176.166]:11940 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261289AbULWU53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 15:57:29 -0500
Date: Thu, 23 Dec 2004 12:57:13 -0800
From: Matt Mackall <mpm@selenic.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, linux-ia64@vger.kernel.org, torvalds@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V2 [0/3]: Why and When it works
Message-ID: <20041223205713.GE28322@waste.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com> <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2004 at 11:29:10AM -0800, Christoph Lameter wrote:
> 2. Hardware support for offloading zeroing from the cpu. This avoids
> the invalidation of the cpu caches by extensive zeroing operations.

I'm wondering if it would be possible to use typical video cards for
hardware zeroing. We could set aside a page's worth of zeros in video
memory and then use the card's DMA engines to clear pages on the host.

This could be done in fbdev drivers, which would register a zeroer
with the core.

-- 
Mathematics is the supreme nostalgia of our time.
