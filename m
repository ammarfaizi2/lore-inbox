Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVBXFAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVBXFAC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 00:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVBXFAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 00:00:01 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:50824 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261808AbVBXE54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 23:57:56 -0500
Date: Thu, 24 Feb 2005 04:56:51 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: More latency regressions with 2.6.11-rc4-RT-V0.7.39-02
In-Reply-To: <1109196824.4009.1.camel@krustophenia.net>
Message-ID: <Pine.LNX.4.61.0502240441260.5427@goblin.wat.veritas.com>
References: <1109182061.16201.6.camel@krustophenia.net> 
    <Pine.LNX.4.61.0502231908040.13491@goblin.wat.veritas.com> 
    <1109187381.3174.5.camel@krustophenia.net> 
    <Pine.LNX.4.61.0502231952250.14603@goblin.wat.veritas.com> 
    <Pine.LNX.4.61.0502232048330.14747@goblin.wat.veritas.com> 
    <1109196824.4009.1.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2005, Lee Revell wrote:
> On Wed, 2005-02-23 at 20:53 +0000, Hugh Dickins wrote:
> > On Wed, 23 Feb 2005, Hugh Dickins wrote:
> > > Please replace by new patch below, which I'm now running through lmbench.
> > 
> > That second patch seems fine, and I see no lmbench regression from it.
> 
> Should go into 2.6.11, right?

That's up to Andrew (and Linus).

I was thinking that way when I rushed you the patch.  But given that
you have remaining unresolved latency issues nearby (zap_pte_range,
clear_page_range), and given the warning shot that I screwed up my
first attempt, I'd be inclined to say hold off.

It's a pity: for a while we were thinking 2.6.11 would be a big step
forward for mainline latency; but it now looks to me like these tests
have come too late in the cycle to be dealt with safely.

In other mail, you do expect people still to be using Ingo's patches,
so probably this patch should stick there (and in -mm) for now.

Hugh
