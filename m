Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267580AbUG3CXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267580AbUG3CXN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 22:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267513AbUG3CXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 22:23:13 -0400
Received: from tomts22-srv.bellnexxia.net ([209.226.175.184]:62351 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S267580AbUG3CXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 22:23:07 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Eric St-Laurent <ericstl34@sympatico.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, Scott Wood <scott@timesys.com>,
       Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
In-Reply-To: <20040728064547.GA16176@elte.hu>
References: <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au>
	 <20040721183415.GC2206@yoda.timesys> <20040721184650.GA27375@elte.hu>
	 <20040721195650.GA2186@yoda.timesys> <20040721214534.GA31892@elte.hu>
	 <20040722022810.GA3298@yoda.timesys> <20040722074034.GC7553@elte.hu>
	 <20040722185308.GC4774@yoda.timesys>
	 <20040722194513.GA32377@nietzsche.lynx.com>
	 <20040728064547.GA16176@elte.hu>
Content-Type: text/plain
Message-Id: <1091154185.12149.5.camel@orbiter>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Jul 2004 22:23:05 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-28 at 02:45, Ingo Molnar wrote:
> i'd agree with turning most of the finegrained per-task (non-irq-safe)
> spinlocks into mutexes (or spin-mutexes). But the central locks that an
> RT task would likely hit need to remain spinlocks i believe.
> 
> plus there are central mutexes too that are in 'hiding' currently but
> could cause latencies just as much.

Here are patches that convert spinlocks into kernel mutexes with
priority inheritance.  They look reasonably clean, and might be
interesting to try.

http://inf3-www.informatik.unibw-muenchen.de/research/linux/mutex/mutex.html


Best regards,

Eric St-Laurent

