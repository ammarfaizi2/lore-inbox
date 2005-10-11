Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbVJKSoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbVJKSoa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 14:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVJKSoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 14:44:30 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:18144 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932296AbVJKSo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 14:44:29 -0400
Subject: Re: 2.6.13-rt12: irqs hard off for 657 usecs
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1129048106.12702.21.camel@mindpipe>
References: <1128724690.17981.57.camel@mindpipe>
	 <20051011112043.GB15995@elte.hu>  <1129048106.12702.21.camel@mindpipe>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 14:44:28 -0400
Message-Id: <1129056268.4718.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-11 at 12:28 -0400, Lee Revell wrote:
> On Tue, 2005-10-11 at 13:20 +0200, Ingo Molnar wrote:
> > * Lee Revell <rlrevell@joe-job.com> wrote:
> > 
> > > Something appears to have disabled IRQs for 657 usecs.
> > 
> > how hard is it to reproduce this latency?
> 
> Very easy.  Here's the current max latency.
> 
> The max latency is close to the period of the timer IRQ.  So either it's
> an instrumentation bug or something really disables IRQs for up to 1/HZ
> seconds.

I can no longer reproduce this with 2.6.14-rc4-rt1.  It seems to have
been a real IRQs disabled bug (not an instrumentation bug) as I was also
getting xruns with 2.6.13-rt12.

Lee

