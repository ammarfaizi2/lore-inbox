Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVBXCZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVBXCZo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 21:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVBXCZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 21:25:20 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:8925 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261694AbVBXCY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 21:24:59 -0500
Subject: Re: More latency regressions with 2.6.11-rc4-RT-V0.7.39-02
From: Lee Revell <rlrevell@joe-job.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <421D2DEE.8070209@yahoo.com.au>
References: <1109182061.16201.6.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502231908040.13491@goblin.wat.veritas.com>
	 <1109187381.3174.5.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502231952250.14603@goblin.wat.veritas.com>
	 <1109190614.3126.1.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502232053320.14747@goblin.wat.veritas.com>
	 <421D1171.7070506@yahoo.com.au> <1109207024.4516.6.camel@krustophenia.net>
	 <421D2DEE.8070209@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 21:24:57 -0500
Message-Id: <1109211897.4831.2.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-24 at 12:29 +1100, Nick Piggin wrote:
> Lee Revell wrote:
> > 
> > IIRC last time I really tested this a few months ago, the worst case
> > latency on that machine was about 150us.  Currently its 422us from the
> > same clear_page_range code path.
> > 
> Well it should be pretty trivial to add a break in there.
> I don't think it can get into 2.6.11 at this point though,
> so we'll revisit this for 2.6.12 if the clear_page_range
> optimisations don't get anywhere.
> 

Agreed, it would be much better to optimize this away than just add a
scheduling point.  It seems like we could do this lazily.

IMHO it's not critical that these latency fixes be merged until the VP
feature gets merged, until then people will be using Ingo's patches
anyway.

Lee

