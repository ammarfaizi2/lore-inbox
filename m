Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVAXRuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVAXRuI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 12:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVAXRuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 12:50:08 -0500
Received: from holomorphy.com ([66.93.40.71]:63144 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261544AbVAXRuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 12:50:02 -0500
Date: Mon, 24 Jan 2005 09:49:54 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Mark_H_Johnson@raytheon.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Query on remap_pfn_range compatibility
Message-ID: <20050124174954.GF10843@holomorphy.com>
References: <OF3F115AC8.F271AB73-ON86256F93.005BCD86@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF3F115AC8.F271AB73-ON86256F93.005BCD86@raytheon.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 10:54:22AM -0600, Mark_H_Johnson@raytheon.com wrote:
> I read the messages on lkml from September 2004 about the introduction of
> remap_pfn_range and have a question related to coding for it. What do you
> recommend for driver coding to be compatible with these functions
> (remap_page_range, remap_pfn_range)?
> For example, I see at least two (or three) combination I need to address:
>  - 2.4 (with remap_page_range) OR 2.6.x (with remap_page_range)
>  - 2.6.x-mm (with remap_pfn_range)
> Is there some symbol or #ifdef value I can depend on to determine which
> function I should be calling (and the value to pass in)?

Not sure. One on kernel version being <= 2.6.10 would probably serve
your purposes, though it's not particularly well thought of. I suspect
people would suggest splitting up the codebase instead of sharing it
between 2.4.x and 2.6.x, where I've no idea how well that sits with you.

I vaguely suspected something like this would happen, but there were
serious and legitimate concerns about new usage of the 32-bit unsafe
methods being reintroduced, so at some point the old hook had to go.


-- wli
