Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268083AbUJSJDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268083AbUJSJDM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 05:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUJSJDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:03:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:20620 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268083AbUJSJDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:03:09 -0400
Date: Tue, 19 Oct 2004 11:04:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
Message-ID: <20041019090428.GA17204@elte.hu>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <1098173546.12223.737.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098173546.12223.737.camel@thomas>
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


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, 2004-10-18 at 16:50, Ingo Molnar wrote:
> > i have released the -U5 Real-Time Preemption patch:
> 
> All sleep_on variants trigger the irqs_disabled() check in schedule(). 
> tglx

ah, forgot that the waitqueue lock is a raw lock. Is there _any_
scenario where sleep_on() is actually correct kernel code?

	Ingo
