Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268102AbTBYRet>; Tue, 25 Feb 2003 12:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268105AbTBYRet>; Tue, 25 Feb 2003 12:34:49 -0500
Received: from holomorphy.com ([66.224.33.161]:57270 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268102AbTBYRer>;
	Tue, 25 Feb 2003 12:34:47 -0500
Date: Tue, 25 Feb 2003 09:43:59 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, Hanna Linder <hannal@us.ibm.com>,
       lse-tech@lists.sf.et, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225174359.GA10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
	Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sf.et,
	linux-kernel@vger.kernel.org
References: <96700000.1045871294@w-hlinder> <20030222192424.6ba7e859.akpm@digeo.com> <20030225171727.GN29467@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225171727.GN29467@dualathlon.random>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 07:24:24PM -0800, Andrew Morton wrote:
>> So whole stole the remaining 1.85 seconds?   Looks like pte_highmem.

On Tue, Feb 25, 2003 at 06:17:27PM +0100, Andrea Arcangeli wrote:
> would you mind to add the line for 2.4.21-pre4aa3? it has pte-highmem so
> you can easily find it out for sure if it is pte_highmem that stole >10%
> of your fast cpu. A line for the 2.4-rmap patch would be also
> interesting.

On Sat, Feb 22, 2003 at 07:24:24PM -0800, Andrew Morton wrote:
>> Note one second spent in pte_alloc_one().

On Tue, Feb 25, 2003 at 06:17:27PM +0100, Andrea Arcangeli wrote:
> note the seconds spent in the rmap affected paths too.

The pagetable cache is gone in 2.5, so pte_alloc_one() takes the
bitblitting hit for pagetables.

I didn't catch the whole profile, so I'll need numbers for rmap paths.


-- wli
