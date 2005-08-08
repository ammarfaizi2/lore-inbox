Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbVHHPYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbVHHPYU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 11:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbVHHPYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 11:24:20 -0400
Received: from gold.veritas.com ([143.127.12.110]:62655 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750921AbVHHPYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 11:24:20 -0400
Date: Mon, 8 Aug 2005 16:26:11 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Manfred Spraul <manfred@colorfullife.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: two 2.6.13-rc3-mm3 oddities
In-Reply-To: <20050808140536.GC4558@in.ibm.com>
Message-ID: <Pine.LNX.4.61.0508081613120.5078@goblin.wat.veritas.com>
References: <20050803095644.78b58cb4.akpm@osdl.org> <20050808140536.GC4558@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 08 Aug 2005 15:24:19.0725 (UTC) FILETIME=[3F2C33D0:01C59C2D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2005, Dipankar Sarma wrote:
> On Wed, Aug 03, 2005 at 09:56:44AM +1000, Andrew Morton forwarded from Hugh:
> > 
> > Subject: two 2.6.13-rc3-mm3 oddities
> > 
> > One time my tmpfs-and-looped-tmpfs-kernel-builds collapsed with lots of
> > VFS: file-max limit 49778 reached
> > messages, which I imagine was a side-effect of the struct file RCU
> > patches you've dropped from -rc4-mm1, perhaps a grace period problem.
> 
> Hugh, could you please try this with the experimental patch below ?

I'll give it a go.  But first I ought to try to reproduce the problem
more easily - it happened after about two hours of a test which had run
for two or more hours (before hitting the apparently unrelated problem)
at least twice each on at least two machines.  So until I can reproduce
the problem more easily, it'll take some while to have confidence that
your patch addresses it.  Therefore worth a little effort at my end to
cut it down (and if I can't cut it down, I may have to solve the odder
locked page issue to get the original test to run long enough to hit
the file-max problem with any likelihood).

> Hugh, can you mail me the exact test you run ? I would like to run
> it myself and see if I can reproduce it.

It'll waste less of both our time if I at least try to reproduce it
more quickly first.  Hold on...

Hugh
