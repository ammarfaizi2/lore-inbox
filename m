Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266777AbUG1EuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266777AbUG1EuV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 00:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266780AbUG1EuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 00:50:21 -0400
Received: from mx2.elte.hu ([157.181.151.9]:7876 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266777AbUG1EuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 00:50:16 -0400
Date: Wed, 28 Jul 2004 06:51:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
Message-ID: <20040728045130.GA14363@elte.hu>
References: <40F3F0A0.9080100@vision.ee> <20040726204720.GA26561@elte.hu> <20040727162759.GA32548@elte.hu> <200407271841.11629.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407271841.11629.dtor_core@ameritech.net>
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


* Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> On Tuesday 27 July 2004 11:27 am, Ingo Molnar wrote:
> > other changes in -L2:
> > 
> > i've done a softirq lock-break in the atkbd and ps2mouse drivers - this
> > should fix the big latencies triggered by NumLock/CapsLock, reported by
> > Lee Revell.
> > 
> 
> Actually the following seems to be working on my laptop and I was
> thinking about pushing it to Vojtech. Any reason why this should not
> be done?
> 
> (The patch is on top of Vojtech's tee + my other changes so it won't
> apply to anything.)

your solution of pushing completion work into a workqueue is of course
the right approach! My change was just papering over this artificial
softirq latency. Please push it to Vojtech ASAP.

	Ingo
