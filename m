Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbWDCFa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbWDCFa2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 01:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbWDCFa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 01:30:27 -0400
Received: from mail.gmx.de ([213.165.64.20]:56517 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751551AbWDCFa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 01:30:26 -0400
X-Authenticated: #14349625
Subject: Re: lowmem_reserve question
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, ck@vds.kolivas.org,
       Andrew Morton <akpm@osdl.org>,
       linux list <linux-kernel@vger.kernel.org>
In-Reply-To: <200604031518.49184.kernel@kolivas.org>
References: <200604021401.13331.kernel@kolivas.org>
	 <200604031448.01391.kernel@kolivas.org> <1144041247.8198.8.camel@homer>
	 <200604031518.49184.kernel@kolivas.org>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 07:31:12 +0200
Message-Id: <1144042272.8198.16.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-03 at 15:18 +1000, Con Kolivas wrote:
> On Monday 03 April 2006 15:14, Mike Galbraith wrote:
> > If that dinky 16MB zone still exists, and always appears nearly full, be
> > happy.  It used to be a real PITA.
> 
> That's not the point. If you try to do any allocation anywhere else it also 
> checks that zone, and it will find it full (always) leading to reclaim all 
> over the place for no good reason. This has nothing to do with actually 
> wanting to use that space or otherwise.

That doesn't make any sense.  Why would you scan/reclaim if the zone is
not depleted?

Like I said, I'm _way_ out of date.  The problem scenario used to be
that you run low on memory, dip into dinky dma zone, pin it, then grind
to powder trying to find a reclaimable dma page.

	-Mike

