Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266240AbUGJM5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266240AbUGJM5y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 08:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266241AbUGJM5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 08:57:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:46524 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266240AbUGJM5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 08:57:52 -0400
Date: Sat, 10 Jul 2004 14:55:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dave Jones <davej@redhat.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040710125535.GA27644@elte.hu>
References: <20040709182638.GA11310@elte.hu> <40EF3FAA.5000907@kolivas.org> <20040710010429.GB6386@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040710010429.GB6386@redhat.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=0, required 5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dave Jones <davej@redhat.com> wrote:

> On Sat, Jul 10, 2004 at 11:00:26AM +1000, Con Kolivas wrote:
> 
>  > >  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.7-bk20-H2
>  > Looks nice.
>  > 
>  > I think you may have mixed up your trees. I think this change is the cfq 
>  > bad allocation fix which I dont think is part of your voluntary 
>  > preemption patch:
>  > 
>  > --- linux/drivers/block/cfq-iosched.c.orig	
>  
> It was this patch that found this bug 8-)  Without voluntary-preempt
> it had been lying there unexposed for a while.  It's sort of must-have
> if you use this patch, so I guess that's why Ingo rolled it in until
> mainline gets the same fix.

correct. E.g. 2.6.7-mm7 already has the patch so for that tree there's
no cfq-iosched.c change in the voluntary-preempt patch. And for
2.6.7-vanilla there's a big cfq-iosched.c delta to include the other
improvements from Jens as well on which the bugfix depends.

the patch didnt really trigger the bug itself, it triggered an annoying
debugging message instead ;)
 
	Ingo
