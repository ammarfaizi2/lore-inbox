Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbUKNNdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbUKNNdr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 08:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUKNNbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 08:31:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:385 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261304AbUKNNa7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 08:30:59 -0500
Date: Sun, 14 Nov 2004 07:44:17 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Chris Ross <chris@tebibyte.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Nick Piggin <piggin@cyberone.com.au>,
       Rik van Riel <riel@redhat.com>,
       Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
Message-ID: <20041114094417.GC29267@logos.cnet>
References: <20041111112922.GA15948@logos.cnet> <4193E056.6070100@tebibyte.org> <4194EA45.90800@tebibyte.org> <20041113233740.GA4121@x30.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041113233740.GA4121@x30.random>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 12:37:40AM +0100, Andrea Arcangeli wrote:
> On Fri, Nov 12, 2004 at 05:52:21PM +0100, Chris Ross wrote:
> > 
> > 
> > Chris Ross escreveu:
> > >It seems good.
> > 
> > Sorry Marcelo, I spoke to soon. The oom killer still goes haywire even 
> > with your new patch. I even got this one whilst the machine was booting!
> 
> On monday I'll make a patch to place the oom killer at the right place.
> 
> Marcelo's argument that kswapd is a localized place isn't sound to me,
> kswapd is still racing against all other task contexts, so if the task
> context isn't reliable, there's no reason why kswapd should be more
> reliable than the task context. the trick is to check the _right_
> watermarks before invoking the oom killer, it's not about racing against
> each other, 2.6 is buggy in not checking the watermarks. Moving the oom
> killer in kswapd can only make thing worse, fix is simple, and it's the
> opposite thing: move the oom killer up the stack outside vmscan.c.

Its hard to detect OOM situation with zone->all_unreclaimable logic.

Well, I'll wait for your correct and definitive approach.


