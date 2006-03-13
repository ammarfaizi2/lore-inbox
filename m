Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWCMKg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWCMKg1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 05:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWCMKg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 05:36:27 -0500
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:29888 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932120AbWCMKg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 05:36:26 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: [ck] Re: Faster resuming of suspend technology.
Date: Mon, 13 Mar 2006 21:35:59 +1100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060312213228.GA27693@rhlx01.fht-esslingen.de> <20060313100619.GA2136@elf.ucw.cz>
In-Reply-To: <20060313100619.GA2136@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603132136.00210.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 March 2006 21:06, Pavel Machek wrote:
> On Ne 12-03-06 22:32:28, Andreas Mohr wrote:
> > And... well... this sounds to me exactly like a prime task
> > for the newish swap prefetch work, no need for any other
> > special solutions here, I think.
> > We probably want a new flag for swap prefetch to let it know
> > that we just resumed from software suspend and thus need
> > prefetching to happen *much* faster than under normal
> > conditions for a short while, though (most likely by
> > enabling prefetching on a *non-idle* system for a minute).
>
> Yep, that would be nice. We are actually able to save up-to half of
> pagecache, so situation is not as bad as it used to be.

I would be happy to extend swap prefetch's capabilities to improve resume. It 
wouldn't be too hard to add a special post_resume_swap_prefetch() which 
aggressively prefetches for a while. Excuse my ignorance, though, as I know 
little about swsusp. Are there pages still on swap space after a resume 
cycle?

Cheers,
Con
