Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265264AbUGMOgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUGMOgE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 10:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265265AbUGMOgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 10:36:04 -0400
Received: from mail.ccur.com ([208.248.32.212]:37641 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S265264AbUGMOgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 10:36:01 -0400
Date: Tue, 13 Jul 2004 10:36:00 -0400
From: Joe Korty <joe.korty@ccur.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: preempt-timing-2.6.8-rc1
Message-ID: <20040713143600.GA22758@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040713122805.GZ21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040713122805.GZ21066@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 05:28:05AM -0700, William Lee Irwin III wrote:
> This patch uses the preemption counter increments and decrements to time
> non-preemptible critical sections.
> 
> This is an instrumentation patch intended to help determine the causes of
> scheduling latency related to long non-preemptible critical sections.
> 
> Changes from 2.6.7-based patch:
> (1) fix unmap_vmas() check correctly this time
> (2) add touch_preempt_timing() to cond_resched_lock()
> (3) depend on preempt until it's worked out wtf goes wrong without it

You preemption-block hold times will improve *enormously* if you move all
softirq processing down to the daemon (and possibly raise the daemon to
one of the higher SCHED_RR priorities, to compensate for softirq processing
no longer happening at interrupt level).

Joe
