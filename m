Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbUJYM6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbUJYM6t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 08:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbUJYM6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 08:58:49 -0400
Received: from mx2.elte.hu ([157.181.151.9]:21392 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261788AbUJYM4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 08:56:51 -0400
Date: Mon, 25 Oct 2004 14:58:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Sami Farin <7atbggg02@sneakemail.com>
Subject: Re: Linux 2.6.9 latencies: scheduler bug?
Message-ID: <20041025125807.GA8432@elte.hu>
References: <20041024212618.GA19377@m.safari.iki.fi> <20041025120021.GA9917@m.safari.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025120021.GA9917@m.safari.iki.fi>
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


* Sami Farin <7atbggg02@sneakemail.com> wrote:

> forget this stupid ip_tables.c patch, latencies have nothing to do with
> netfilter code, but bad interaction between xmms, rtc_latencytest
> and iptables.  I now get at max 3.1s (yup, 3100000us) latencies.
> http://safari.iki.fi/2.6.9-xmms-fun-1.png
> if you want to reproduce this:
> 1) run "rtc_latencytest 1024" (can't reproduce with "rtc_latencytest 512")
> 2) press play in xmms
> 3) start iptables-script

to further debug any latencies please apply the -RT patchset and enable
PREEMPT_TIMING (and LATENCY_TRACING), that enables us to tell us more
about the latencies. You dont have to enable PREEMPT_REALTIME (the most
experimental feature of the patchset) to measure latencies.

	Ingo
