Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268097AbUJSJLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268097AbUJSJLg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 05:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268092AbUJSJLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:11:36 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:63137
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S268097AbUJSJLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:11:33 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041019090428.GA17204@elte.hu>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
	 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
	 <20041018145008.GA25707@elte.hu> <1098173546.12223.737.camel@thomas>
	 <20041019090428.GA17204@elte.hu>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098176615.12223.753.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Oct 2004 11:03:35 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 11:04, Ingo Molnar wrote:
> > All sleep_on variants trigger the irqs_disabled() check in schedule(). 
> > tglx
> 
> ah, forgot that the waitqueue lock is a raw lock. Is there _any_
> scenario where sleep_on() is actually correct kernel code?

Hmm, the sleep_on() variants are used quite a lot over the kernel. Whats
wrong with them and to what should they be converted ?

tglx


