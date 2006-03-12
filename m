Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWCLWa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWCLWa1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 17:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWCLWa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 17:30:27 -0500
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:59316 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751105AbWCLWa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 17:30:26 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: [ck] Re: Faster resuming of suspend technology.
Date: Mon, 13 Mar 2006 09:30:11 +1100
User-Agent: KMail/1.9.1
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060312213228.GA27693@rhlx01.fht-esslingen.de>
In-Reply-To: <20060312213228.GA27693@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603130930.11800.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 March 2006 08:32, Andreas Mohr wrote:
> And... well... this sounds to me exactly like a prime task
> for the newish swap prefetch work, no need for any other
> special solutions here, I think.
> We probably want a new flag for swap prefetch to let it know
> that we just resumed from software suspend and thus need
> prefetching to happen *much* faster than under normal
> conditions for a short while, though (most likely by
> enabling prefetching on a *non-idle* system for a minute).

Adding a resume_swap_prefetch() called just before the resume finishes that 
aggressively prefetches from swap would be easy. Please tell me if you think 
adding such a function would be worthwhile.

Cheers,
Con
