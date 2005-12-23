Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161065AbVLWV7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161065AbVLWV7l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 16:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbVLWV7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 16:59:41 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:46237 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161065AbVLWV7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 16:59:40 -0500
Subject: Re: [PATCH] sched: Fix
	adverse	effects	of	NFS	client	on	interactive response
From: Lee Revell <rlrevell@joe-job.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Kyle Moffett <mrmacman_g4@mac.com>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1135372999.8555.19.camel@lade.trondhjem.org>
References: <43A8EF87.1080108@bigpond.net.au>
	 <1135145341.7910.17.camel@lade.trondhjem.org>
	 <43A8F714.4020406@bigpond.net.au>
	 <1135171280.7958.16.camel@lade.trondhjem.org>
	 <962C9716-6F84-477B-8B2A-FA771C21CDE8@mac.com>
	 <1135172453.7958.26.camel@lade.trondhjem.org>
	 <43AA0EEA.8070205@bigpond.net.au>
	 <1135289282.9769.2.camel@lade.trondhjem.org>
	 <43AB29B8.7050204@bigpond.net.au>
	 <1135292364.9769.58.camel@lade.trondhjem.org>
	 <AAF94E06-ACB9-4ABE-AC15-49C6B3BE21A0@mac.com>
	 <1135297525.3685.57.camel@lade.trondhjem.org>
	 <43AB69B8.4080707@bigpond.net.au>
	 <1135330757.8167.44.camel@lade.trondhjem.org>
	 <1135364822.22177.13.camel@mindpipe>
	 <1135372090.8555.9.camel@lade.trondhjem.org>
	 <1135372661.22177.46.camel@mindpipe>
	 <1135372999.8555.19.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 17:04:11 -0500
Message-Id: <1135375452.22177.62.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 22:23 +0100, Trond Myklebust wrote:
> On Fri, 2005-12-23 at 16:17 -0500, Lee Revell wrote:
> > On Fri, 2005-12-23 at 22:08 +0100, Trond Myklebust wrote:
> > > On Fri, 2005-12-23 at 14:07 -0500, Lee Revell wrote:
> > > 
> > > > By your logic it's also broken to use cond_resched() in filesystem code.
> > > 
> > > ...and your point is?
> > 
> > Reductio ad absurdum.  Subsystems not using cond_resched would render
> > Linux unusable for even trivial soft realtime applications like AV
> > playback and recording.
> 
> It may surprise you to learn that some people don't use their computers
> for AV playback and recording. However absurd it may seem to you, those
> people are quite happy to use 2.4.x kernels without a cond_resched
> lurking in every nook and cranny.

Of course, but I think a reasonable goal for 2.6 is to maintain the
server side performance of 2.4 but also enable desktop type applications
to work well.

cond_resched is really a temporary hack to make the desktop usable until
the kernel becomes fully preemptible.

Lee

