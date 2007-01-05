Return-Path: <linux-kernel-owner+w=401wt.eu-S1750747AbXAEUqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbXAEUqZ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 15:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbXAEUqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 15:46:25 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:12143 "EHLO
	extu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbXAEUqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 15:46:24 -0500
X-AuditID: d80ac21c-9e939bb00000021a-38-459eb91f08f2 
Date: Fri, 5 Jan 2007 20:46:42 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Pekka J Enberg <penberg@cs.helsinki.fi>
cc: clameter@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: fix double-free in fallback_alloc
In-Reply-To: <Pine.LNX.4.64.0701051127180.17184@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0701052037100.4444@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0701051127180.17184@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 05 Jan 2007 20:46:23.0176 (UTC) FILETIME=[8F961480:01C7310A]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2007, Pekka J Enberg wrote:
> 
> Here's an alternative fix for the double-free bug you hit. I have only 
> compile-tested this on NUMA so can you please confirm it fixes the problem 
> for you? Thanks.

It looks nice, and I'm giving it a spin: though hardly worth waiting
a week or so to see if it hits the old double-free (took 3.5 days of
load when I saw it before), since you've fairly clearly rearranged
that out of existence - any bugs will be new ones all your own ;)

And I don't really have any NUMA anyway, just build that way ever
since testing some mempolicy change.  So don't pay much attention to
my results, though of course I'll let you know if I see it go wrong.

The main thing is to make sure that your patch doesn't end up applied
to a tree with my patch in, since that would then be a (rare) leak.

Hugh
