Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVBWVEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVBWVEu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 16:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVBWVEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 16:04:50 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:45305 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261588AbVBWVEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 16:04:40 -0500
Date: Wed, 23 Feb 2005 21:03:55 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: More latency regressions with 2.6.11-rc4-RT-V0.7.39-02
In-Reply-To: <1109190614.3126.1.camel@krustophenia.net>
Message-ID: <Pine.LNX.4.61.0502232053320.14747@goblin.wat.veritas.com>
References: <1109182061.16201.6.camel@krustophenia.net> 
    <Pine.LNX.4.61.0502231908040.13491@goblin.wat.veritas.com> 
    <1109187381.3174.5.camel@krustophenia.net> 
    <Pine.LNX.4.61.0502231952250.14603@goblin.wat.veritas.com> 
    <1109190614.3126.1.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2005, Lee Revell wrote:
> > > 
> > > Thanks, your patch fixes the copy_pte_range latency.
> 
> clear_page_range is also problematic.

Yes, I saw that from your other traces too.  I know there are plans
to improve clear_page_range during 2.6.12, but I didn't realize that
it had become very much worse than its antecedent clear_page_tables,
and I don't see missing latency fixes for that.  Nick's the expert.

Hugh
