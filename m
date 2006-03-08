Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWCHCSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWCHCSU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 21:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWCHCST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 21:18:19 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:26792 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932241AbWCHCSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 21:18:17 -0500
Subject: Re: [PATCH] mm: yield during swap prefetching
From: Lee Revell <rlrevell@joe-job.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, ck@vds.kolivas.org
In-Reply-To: <200603081312.51058.kernel@kolivas.org>
References: <200603081013.44678.kernel@kolivas.org>
	 <200603081228.05820.kernel@kolivas.org> <1141783711.767.121.camel@mindpipe>
	 <200603081312.51058.kernel@kolivas.org>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 21:18:14 -0500
Message-Id: <1141784295.767.126.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 13:12 +1100, Con Kolivas wrote:
> On Wed, 8 Mar 2006 01:08 pm, Lee Revell wrote:
> > On Wed, 2006-03-08 at 12:28 +1100, Con Kolivas wrote:
> > > I can't distinguish between when cpu activity is important (game) and
> > > when it is not (compile), and assuming worst case scenario and not doing
> > > any swap prefetching is my intent. I could add cpu accounting to
> > > prefetch_suitable() instead, but that gets rather messy and yielding
> > > achieves the same endpoint.
> >
> > Shouldn't the game be running with RT priority or at least at a low nice
> > value?
> 
> No way. Games run nice 0 SCHED_NORMAL.

Maybe this is a stupid/OT question (answer off list if you think so) but
why not?  Isn't that the standard way of telling the scheduler that you
have a realtime constraint?  It's how pro audio stuff works which I
would think has similar RT requirements.

How is the scheduler supposed to know to penalize a kernel compile
taking 100% CPU but not a game using 100% CPU?

Lee

