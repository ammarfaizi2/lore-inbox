Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbVBKJkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVBKJkm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 04:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVBKJkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 04:40:42 -0500
Received: from waste.org ([216.27.176.166]:45031 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262223AbVBKJkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 04:40:36 -0500
Date: Fri, 11 Feb 2005 01:40:21 -0800
From: Matt Mackall <mpm@selenic.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, "Jack O'Quin" <jack.oquin@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com
Subject: Re: 2.6.11-rc3-mm2
Message-ID: <20050211094021.GJ15058@waste.org>
References: <a075431a050210125145d51e8c@mail.gmail.com> <20050211000425.GC2474@waste.org> <20050210164727.M24171@build.pdx.osdl.net> <20050211020956.GC15058@waste.org> <20050211081422.GB2287@elte.hu> <20050211084107.GG15058@waste.org> <20050211085942.GB3980@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211085942.GB3980@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 09:59:42AM +0100, Ingo Molnar wrote:
> 
> think of SCHED_FIFO on the desktop as an ugly wart, a hammer, that
> destroys the careful balance of priorities of SCHED_OTHER tasks. Yes, it
> can be useful if you _need_ a scheduling guarantee due to physical
> constraints, and it can be useful if the hardware (or the kernel) cannot
> buffer enough, but otherwise, it only causes problems.

Agreed. I think something short of full SCHED_FIFO will make most
desktop folks happy. But a) we still have to figure out exactly how to
do that and b) we still have to make everyone else happy. The embedded
folks (me included) would prefer to not run our realtime bits as root
too..

> but i'm not sure how rlimits will contain the whole problem - can
> rlimits be restricted to a single app (jackd)?

Yes. There's also the whole soft limit thing.

-- 
Mathematics is the supreme nostalgia of our time.
