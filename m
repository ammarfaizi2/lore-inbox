Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbUKWAur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbUKWAur (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 19:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbUKWAsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 19:48:31 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:47575 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262226AbUKVXTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:19:44 -0500
Date: Mon, 22 Nov 2004 15:19:36 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: hugh@veritas.com, torvalds@osdl.org, benh@kernel.crashing.org,
       nickpiggin@yahoo.com.au, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: deferred rss update instead of sloppy rss
In-Reply-To: <20041122151628.77ab87ca.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0411221517090.24333@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
 <20041122141148.1e6ef125.akpm@osdl.org> <Pine.LNX.4.58.0411221408540.22895@schroedinger.engr.sgi.com>
 <20041122144507.484a7627.akpm@osdl.org> <Pine.LNX.4.58.0411221444410.22895@schroedinger.engr.sgi.com>
 <20041122151628.77ab87ca.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2004, Andrew Morton wrote:

> > The timer tick occurs every 1 ms.
>
> That only works if the task happens to have the CPU when the timer tick
> occurs.  There remains no theoretical upper bound to the error in mm->rss,
> and that's very easy to fix.

Page fault intensive programs typically hog the cpu. But you are in
principle right.

The "easy fix" that you propose is to add additional logic to some very
hot code paths. Then we are probably better off with another approach.

