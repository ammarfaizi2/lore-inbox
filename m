Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbUJYNL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbUJYNL5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 09:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbUJYNL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 09:11:56 -0400
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:35527 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S261165AbUJYNLl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 09:11:41 -0400
Date: Mon, 25 Oct 2004 16:11:32 +0300
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9 latencies: scheduler bug?
Message-ID: <20041025131132.GD9917@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041024212618.GA19377@m.safari.iki.fi> <20041025120021.GA9917@m.safari.iki.fi> <20041025125807.GA8432@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025125807.GA8432@elte.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 02:58:07PM +0200, Ingo Molnar wrote:
> 
> * Sami Farin <7atbggg02@sneakemail.com> wrote:
> 
> > forget this stupid ip_tables.c patch, latencies have nothing to do with
> > netfilter code, but bad interaction between xmms, rtc_latencytest
> > and iptables.  I now get at max 3.1s (yup, 3100000us) latencies.
> > http://safari.iki.fi/2.6.9-xmms-fun-1.png
> > if you want to reproduce this:
> > 1) run "rtc_latencytest 1024" (can't reproduce with "rtc_latencytest 512")
> > 2) press play in xmms
> > 3) start iptables-script
> 
> to further debug any latencies please apply the -RT patchset

which includes also -mm1...

> and enable PREEMPT_TIMING (and LATENCY_TRACING), that enables us to tell us more

I guess those are not available as individual patches which could be
applied to 2.6.9?

Could someone with LATENCY_TRACING+PREEMPT_TIMING try to reproduce
that xmms/rtc_latencytest/iptables thing...  takes only a minute.

Pretty please?

> about the latencies. You dont have to enable PREEMPT_REALTIME (the most
> experimental feature of the patchset) to measure latencies.
> 
> 	Ingo

-- 
