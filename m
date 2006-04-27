Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751757AbWD0XDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbWD0XDL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 19:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWD0XDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 19:03:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:29857 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751757AbWD0XDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 19:03:10 -0400
Date: Thu, 27 Apr 2006 16:02:50 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: dsp@llnl.gov, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       riel@surriel.com, nickpiggin@yahoo.com.au, ak@suse.de
Subject: Re: [PATCH 1/2 (repost)] mm: serialize OOM kill operations
Message-Id: <20060427160250.a72cae11.pj@sgi.com>
In-Reply-To: <20060427140921.249a00b0.akpm@osdl.org>
References: <200604271308.10080.dsp@llnl.gov>
	<20060427134442.639a6d19.pj@sgi.com>
	<20060427140921.249a00b0.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> Note that these will occupy the same machine word.

That's why I did it.  Yup.

> So they'll need
> locking.  (Good luck trying to demonstrate the race though!)

Oops.  Good catch.  Thanks, Andrew.

Probably solvable (lockable) but this line of thought is
getting to be more trouble than I suspect it's worth.

I'm still a little surprised that this per-mm 'oom_notify' bit
was needed to implement what I thought was a single, global
system wide oom killer serializer.

But I'm too ignorant and lazy, and too distracted by other
tasks, to actually think that surprise through.

Good luck with it, Dave.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
