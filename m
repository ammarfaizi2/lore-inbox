Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265305AbUGMPI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265305AbUGMPI1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 11:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbUGMPI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 11:08:27 -0400
Received: from mail.ccur.com ([208.248.32.212]:52234 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S265305AbUGMPIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 11:08:10 -0400
Date: Tue, 13 Jul 2004 11:08:08 -0400
From: Joe Korty <joe.korty@ccur.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: preempt-timing-2.6.8-rc1
Message-ID: <20040713150808.GA23127@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040713122805.GZ21066@holomorphy.com> <20040713143600.GA22758@tsunami.ccur.com> <20040713144028.GH21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040713144028.GH21066@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 07:40:28AM -0700, William Lee Irwin III wrote:
> On Tue, Jul 13, 2004 at 05:28:05AM -0700, William Lee Irwin III wrote:
> >> This patch uses the preemption counter increments and decrements to time
> >> non-preemptible critical sections.
> >> This is an instrumentation patch intended to help determine the causes of
> >> scheduling latency related to long non-preemptible critical sections.
> >> Changes from 2.6.7-based patch:
> >> (1) fix unmap_vmas() check correctly this time
> >> (2) add touch_preempt_timing() to cond_resched_lock()
> >> (3) depend on preempt until it's worked out wtf goes wrong without it
> 
> On Tue, Jul 13, 2004 at 10:36:00AM -0400, Joe Korty wrote:
> > You preemption-block hold times will improve *enormously* if you move all
> > softirq processing down to the daemon (and possibly raise the daemon to
> > one of the higher SCHED_RR priorities, to compensate for softirq processing
> > no longer happening at interrupt level).
> 
> Plausible. Got a patch?

I can scrape one up.  It'll be a day or so.
Joe
