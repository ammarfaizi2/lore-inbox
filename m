Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268266AbUIBMOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268266AbUIBMOt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 08:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268269AbUIBMOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 08:14:48 -0400
Received: from pD9E0EED0.dip.t-dialin.net ([217.224.238.208]:25736 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S268266AbUIBMOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 08:14:47 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q9
From: Thomas Charbonnel <thomas@undata.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040902111003.GA4256@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com>
	 <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu>
	 <20040902111003.GA4256@elte.hu>
Content-Type: text/plain
Message-Id: <1094127280.5652.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 02 Sep 2004 14:14:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote :
> i've released the -Q9 patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q9
> 
> ontop of:
> 
>   http://redhat.com/~mingo/voluntary-preempt/diff-bk-040828-2.6.8.1.bz2
> 
> Changes:
> 
>  - fixed the cond_resched_softirq() bug noticed by Mika Penttila.
> 
>  - updated the preemption-friendly network-RX code but 8193too.c still
>    produces delayed packets so netdev_backlog_granularity now defaults
>    to 2, which seems to be working fine on my testbox.

Thanks, network seems to be working fine with the new default value.
I still get > 140 us non-preemptible sections in rtl8139_pol, though :
http://www.undata.org/~thomas/q9_rtl8139.trace

Thomas


