Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbVL2IC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbVL2IC2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 03:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbVL2IC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 03:02:28 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:52170 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932588AbVL2IC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 03:02:27 -0500
Date: Thu, 29 Dec 2005 09:02:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] CPU scheduler: Simplified interactive bonus mechanism
Message-ID: <20051229080206.GA22814@elte.hu>
References: <43B22FBA.5040008@bigpond.net.au> <200512281735.00992.kernel@kolivas.org> <43B242F4.3050004@yahoo.com.au> <43B35D43.40902@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B35D43.40902@bigpond.net.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Williams <pwil3058@bigpond.net.au> wrote:

> > So, as Con seems to imply, it is JASW (just another scheduler
> > rewrite).
> 
> Not a rewrite just some major surgery to one small part (at least when 
> compared to nicksched, staircase and the SPA schedulers).  This 
> doesn't effect the run queue structure or the load balancing 
> mechanisms.  Or, for that matter, even the bonus mechanism itself 
> other than the calculation of the bonus as the way the bonus is 
> applied once calculated is unchanged.

given the experience, i'm quite reluctant to do that. We should rather 
concentrate on trying to fix the rare odd case that gets misjudged, than 
trying to invent totally new mechanism that happen to get _that_ case 
right. (and most likely get alot of other cases wrong.)

	Ingo
