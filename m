Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbWD1JLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWD1JLD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 05:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965205AbWD1JLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 05:11:03 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52940 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965201AbWD1JLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 05:11:01 -0400
Date: Fri, 28 Apr 2006 11:10:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <npiggin@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org
Subject: Re: Lockless page cache test results
Message-ID: <20060428091006.GA12001@elf.ucw.cz>
References: <20060426135310.GB5083@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060426135310.GB5083@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 26-04-06 15:53:10, Jens Axboe wrote:
> Hi,
> 
> Running a splice benchmark on a 4-way IPF box, I decided to give the
> lockless page cache patches from Nick a spin. I've attached the results
> as a png, it pretty much speaks for itself.
> 
> The test in question splices a 1GiB file to a pipe and then splices that
> to some output. Normally that output would be something interesting, in
> this case it's simply /dev/null. So it tests the input side of things
> only, which is what I wanted to do here. To get adequate runtime, the
> operation is repeated a number of times (120 in this example). The
> benchmark does that number of loops with 1, 2, 3, and 4 clients each
> pinned to a private CPU. The pinning is mainly done for more stable
> results.

35GB/sec, AFAICS? Not sure how significant this benchmark is.. even
with 4 clients, you have 2.5GB/sec, and that is better than almost
anything you can splice to...
								Pavel
-- 
Thanks for all the (sleeping) penguins.
