Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVB0VZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVB0VZu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 16:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVB0VZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 16:25:50 -0500
Received: from waste.org ([216.27.176.166]:32952 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261307AbVB0VZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 16:25:45 -0500
Date: Sun, 27 Feb 2005 13:25:36 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort()
Message-ID: <20050227212536.GG3120@waste.org>
References: <2.416337461@selenic.com> <200502271417.51654.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502271417.51654.agruen@suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2005 at 02:17:51PM +0100, Andreas Gruenbacher wrote:
> Matt,
> 
> On Monday 31 January 2005 08:34, Matt Mackall wrote:
> > This patch adds a generic array sorting library routine. This is meant
> > to replace qsort, which has two problem areas for kernel use.
> 
> the sort function is broken. When sorting the integer array {1, 2, 3, 4, 5}, 
> I'm getting {2, 3, 4, 5, 1} as a result. Can you please have a look?

Which kernel? There was an off-by-one for odd array sizes in the
original posted version that was quickly spotted:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc4/2.6.11-rc4-mm1/broken-out/sort-fix.patch

I've since tested all sizes 1 - 1000 with 100 random arrays each, so
I'm fairly confident it's now fixed.

-- 
Mathematics is the supreme nostalgia of our time.
