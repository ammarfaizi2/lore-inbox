Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbTKFNkh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 08:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbTKFNkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 08:40:37 -0500
Received: from uni02du.unity.ncsu.edu ([152.1.13.102]:42880 "EHLO
	uni02du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S263596AbTKFNkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 08:40:32 -0500
From: jlnance@unity.ncsu.edu
Date: Thu, 6 Nov 2003 08:40:31 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Over used cache memory?
Message-ID: <20031106134031.GA2720@ncsu.edu>
References: <BAY4-F41WYf5UPHvAo10001c90f@hotmail.com> <3FAA1056.6020003@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAA1056.6020003@aitel.hist.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06, 2003 at 10:11:50AM +0100, Helge Hafting wrote:
> 
> Yes - _use_ the memory for something else. 
> 1. All unused memory will be put to good use as cache.
> 2. Memory is taken from the cache whenever you need it for
>   something else, so (1) is not a problem at all.

This is the way it is susposed to work, but I am working on a problem
where this does not seem to be happening.  We have a machine with 6G
of ram.  It reads some huge files (~5G) and cache fills up.  Then
it starts to process the data and goes into a swap storm because it
can not get any memory for the process because it all is in the cache.
If you run top, you see kswapd stuck at the top.

If anyone has any ideas about this, I would love to hear them.

Thanks,

Jim
