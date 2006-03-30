Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWC3LHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWC3LHj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 06:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWC3LHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 06:07:39 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:15373 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932173AbWC3LHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 06:07:38 -0500
Date: Thu, 30 Mar 2006 13:07:21 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Mike Galbraith <efault@gmx.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>
Subject: Re: [rfc][patch] improved interactive starvation patch against 2.6.16
Message-ID: <20060330110721.GA4851@w.ods.org>
References: <1143713997.9381.28.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143713997.9381.28.camel@homer>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Thu, Mar 30, 2006 at 12:19:57PM +0200, Mike Galbraith wrote:
> Greetings,
> 
> The patch below alone makes virgin 2.6.16 usable in the busy apache
> server scenario, and should help quite a bit with other situations as
> well.
> 
> The original version helps a lot, but not enough, and the latency of
> being awakened in the expired array can be needlessly painful.  Ergo,
> speed up the array switch, and instead of unconditionally plunking all
> awakening tasks (including rt tasks, oops) into the expired array, check
> to see if the task has run since the last array switch first.  This
> leaves a theoretical hole for a stream of one-time waking tasks to
> starve the expired array indefinitely, but it deals with the real
> problem pretty nicely I think. 

Interesting.

> For the one or two folks on the planet testing my anti-starvation
> patches, I've attached an incremental to my 2.6.16 test release.

Thanks, I'll test this ASAP, though I'm clearly busy right now.

Cheers,
Willy

