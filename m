Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVBXDEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVBXDEI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 22:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVBXDEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 22:04:08 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:16351 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261699AbVBXDEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 22:04:04 -0500
Subject: Re: More latency regressions with 2.6.11-rc4-RT-V0.7.39-02
From: Lee Revell <rlrevell@joe-job.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <421D3ED1.9040409@yahoo.com.au>
References: <1109182061.16201.6.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502231908040.13491@goblin.wat.veritas.com>
	 <1109187381.3174.5.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502231952250.14603@goblin.wat.veritas.com>
	 <1109190614.3126.1.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502232053320.14747@goblin.wat.veritas.com>
	 <421D1171.7070506@yahoo.com.au> <1109207024.4516.6.camel@krustophenia.net>
	 <421D2DEE.8070209@yahoo.com.au> <1109211897.4831.2.camel@krustophenia.net>
	 <421D3ED1.9040409@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 22:03:58 -0500
Message-Id: <1109214238.4957.6.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-24 at 13:41 +1100, Nick Piggin wrote:
> Lee Revell wrote:
> > 
> > Agreed, it would be much better to optimize this away than just add a
> > scheduling point.  It seems like we could do this lazily.
> > 
> 
> Oh? What do you mean by lazy? IMO it is sort of implemented lazily now.
> That is, we are too lazy to refcount page table pages in fastpaths, so
> that pushes a lot of work to unmap time. Not necessarily a bad trade-off,
> mind you. Just something I'm looking into.
> 

I guess I was thinking we could be even more lazy, and somehow defer it
until after unmap time (in lieu of memory pressure that is).  Actually
that's kind of what a lock break would do.

Lee

