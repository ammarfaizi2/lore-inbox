Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVBKG63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVBKG63 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 01:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVBKG63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 01:58:29 -0500
Received: from waste.org ([216.27.176.166]:36562 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262203AbVBKG60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 01:58:26 -0500
Date: Thu, 10 Feb 2005 22:57:53 -0800
From: Matt Mackall <mpm@selenic.com>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Chris Wright <chrisw@osdl.org>,
       "Jack O'Quin" <jack.oquin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.11-rc3-mm2
Message-ID: <20050211065753.GE15058@waste.org>
References: <420C25D6.6090807@bigpond.net.au> <200502110341.j1B3fS8o017685@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502110341.j1B3fS8o017685@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 10:41:28PM -0500, Paul Davis wrote:
>   [ the best solution is .... ]
> 
>   [ my preferred solution is ... ]
> 
>   [ it would be better if ... ]
> 
>   [ this is a kludge and it should be done instead like ... ]
> 
> did nobody read what andrew wrote and what JOQ pointed out?
> 
> after weeks of debating this, no other conceptual solution emerged
> that did not have at least as many problems as the RT LSM module, and
> all other proposed solutions were also more invasive of other aspects
> of kernel design and operations than RT LSM is.

Eh? Chris Wright's original rlimits patch was very straightforward
(unlike some of the other rlimit-like patches that followed).
I haven't heard the downsides of it yet.

simple rlimits:
 logical extension of standard, flexible interface
 fine-grained per-process access to nice levels and priorities
 managed with standard tools
 fairly broad possible applications
 clean enough to be added unconditionally
 already doing mlock this way!

RT LSM:
 new, narrow magic group interface (module parameters!)
 boolean granularity of access to all RT levels and maybe mlock
 potential interesting interaction with other LSMs
 not orthogonal to mlock
 not appropriate for every box out there
 requires lsm and (sysfs or modprobe)

-- 
Mathematics is the supreme nostalgia of our time.
