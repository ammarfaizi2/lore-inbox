Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268096AbTBYRHD>; Tue, 25 Feb 2003 12:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268097AbTBYRHD>; Tue, 25 Feb 2003 12:07:03 -0500
Received: from [195.223.140.107] ([195.223.140.107]:51334 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S268096AbTBYRHC>;
	Tue, 25 Feb 2003 12:07:02 -0500
Date: Tue, 25 Feb 2003 18:17:27 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sf.et,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225171727.GN29467@dualathlon.random>
References: <96700000.1045871294@w-hlinder> <20030222192424.6ba7e859.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030222192424.6ba7e859.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 07:24:24PM -0800, Andrew Morton wrote:
> 2.4.21-pre4:                    8.10 seconds
> 2.5.62-mm3 with objrmap:        9.95 seconds	(+1.85)
> 2.5.62-mm3 without objrmap:     10.86 seconds   (+0.91)
> 
> Current 2.5 is 2.76 seconds slower, and this patch reclaims 0.91 of those
> seconds.
> 
> 
> So whole stole the remaining 1.85 seconds?   Looks like pte_highmem.

would you mind to add the line for 2.4.21-pre4aa3? it has pte-highmem so
you can easily find it out for sure if it is pte_highmem that stole >10%
of your fast cpu. A line for the 2.4-rmap patch would be also
interesting.

> Note one second spent in pte_alloc_one().

note the seconds spent in the rmap affected paths too.

Andrea
