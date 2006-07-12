Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWGLPOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWGLPOV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 11:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWGLPOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 11:14:18 -0400
Received: from navgwout.symantec.com ([198.6.49.12]:63699 "EHLO
	navgwout.symantec.com") by vger.kernel.org with ESMTP
	id S1751404AbWGLPOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 11:14:15 -0400
Date: Wed, 12 Jul 2006 16:13:35 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: "Serge E. Hallyn" <serue@us.ibm.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: please revert kthread from loop.c
In-Reply-To: <20060711194932.GA27176@sergelap.austin.ibm.com>
Message-ID: <Pine.LNX.4.64.0607121602120.13239@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0606261920440.1330@blonde.wat.veritas.com>
 <20060627054612.GA15657@sergelap.austin.ibm.com>
 <Pine.LNX.4.64.0606281933300.24170@blonde.wat.veritas.com>
 <20060711194932.GA27176@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 12 Jul 2006 15:14:01.0249 (UTC) FILETIME=[CE27C110:01C6A5C5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006, Serge E. Hallyn wrote:
> > But not good for me.  Gets further e.g. 170 iterations,
> > but then hangs while kthread_stop waits for completion.
> 
> After getting much more familiar with the code, here is a more invasive,
> but pretty heavily tested patch.

I didn't study your patch in detail: as you say, more invasive,
but if it really does the job then it's an improvement, removing
some mystery from loop_thread().  And it does work fine for me -
well, I tested with your next little race addition, and Andrew's
on top of that (with lo->state typo fixed to lo->lo_state); but
I haven't tried your latest refinement from today.

Thanks,
Hugh
