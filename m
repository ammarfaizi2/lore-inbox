Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbVBKI7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbVBKI7B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 03:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVBKI7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 03:59:01 -0500
Received: from waste.org ([216.27.176.166]:9186 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262037AbVBKI6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 03:58:54 -0500
Date: Fri, 11 Feb 2005 00:58:32 -0800
From: Matt Mackall <mpm@selenic.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Chris Wright <chrisw@osdl.org>,
       "Jack O'Quin" <jack.oquin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com
Subject: Re: 2.6.11-rc3-mm2
Message-ID: <20050211085832.GH15058@waste.org>
References: <420C25D6.6090807@bigpond.net.au> <200502110341.j1B3fS8o017685@localhost.localdomain> <20050211065753.GE15058@waste.org> <20050211075417.GA2287@elte.hu> <20050211082536.GF15058@waste.org> <20050211084843.GA3980@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211084843.GA3980@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 09:48:43AM +0100, Ingo Molnar wrote:
> 
> * Matt Mackall <mpm@selenic.com> wrote:
> 
> > Here's Chris' patch for reference:
> > 
> > http://groups-beta.google.com/group/linux.kernel/msg/6408569e13ed6e80
> 
> how does this patch solve the separation of 'negative nice values' and
> 'RT priority rlimits'? In one piece of code it handles the rlimit value
> as a 0-39 nice value, in another place it handles it as a limit for a
> 1-100 RT priority range. The two ranges overlap and have nothing to do
> with each other. [*]

Read more closely: there are two independent limits in the patch,
RLIMIT_NICE and RLIMIT_RTPRIO. This lets us grant elevated nice
without SCHED_FIFO.

-- 
Mathematics is the supreme nostalgia of our time.
