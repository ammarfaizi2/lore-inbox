Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269240AbUJKUsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269240AbUJKUsd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 16:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269242AbUJKUsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 16:48:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:3280 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269240AbUJKUsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 16:48:31 -0400
Date: Mon, 11 Oct 2004 22:49:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, sdietrich@mvista.com,
       linux-kernel@vger.kernel.org, abatyrshin@ru.mvista.com,
       amakarov@ru.mvista.com, emints@ru.mvista.com, ext-rt-dev@mvista.com,
       hzhang@ch.mvista.com, yyang@ch.mvista.com
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Message-ID: <20041011204959.GB16366@elte.hu>
References: <41677E4D.1030403@mvista.com> <20041010084633.GA13391@elte.hu> <1097437314.17309.136.camel@dhcp153.mvista.com> <20041010142000.667ec673.akpm@osdl.org> <20041010215906.GA19497@elte.hu> <1097517191.28173.1.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097517191.28173.1.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> On Sun, 2004-10-10 at 14:59, Ingo Molnar wrote:
> > * Andrew Morton <akpm@osdl.org> wrote:
> > 
> > > Lockmeter gets in the way of all this activity in a big way.  I'll
> > > drop it.
> > 
> > great. Daniel, would you mind to merge your patchkit against the
> > following base:
> > 
> > 	-mm3, minus lockmeter, plus the -T3 patch
> 
> 
> No problem. Next release will be without lockmeter. Thanks for the
> patches.

what do you think about the PREEMPT_REALTIME stuff in -T4? Ideally, if
you agree with the generic approach, the next step would be to add your
priority inheritance handling code to Linux semaphores and
rw-semaphores. The sched.c bits for that looked pretty straightforward.
The list walking is a bit ugly but probably unavoidable - the only other
option would be 100 priority queues per semaphore -> yuck.

	Ingo
