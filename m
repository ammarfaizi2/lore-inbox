Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269007AbUI2Ukt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269007AbUI2Ukt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 16:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269048AbUI2Ui4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 16:38:56 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:56450 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269007AbUI2UeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 16:34:07 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm4-S7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20040929203056.GA7707@elte.hu>
References: <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com>
	 <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu>
	 <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>
	 <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>
	 <20040928000516.GA3096@elte.hu> <1096483257.1600.44.camel@krustophenia.net>
	 <20040929203056.GA7707@elte.hu>
Content-Type: text/plain
Message-Id: <1096490043.15983.2.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 29 Sep 2004 16:34:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-29 at 16:30, Ingo Molnar wrote:
>  > 
> > >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm4-S7
> > 
> > Disabling latency tracing does not seem to work.  To demonstrate:

> is it the full modprobe latency trace, or just the header?  Putting zero
> into trace_enabled wont disable the critical-section-timing code - it
> only disables the function tracer. Since /proc/latency_trace takes the
> header portion from the latency-timing code that might change. To
> disable both do something like:
> 
>   echo 100000000 > /proc/sys/kernel/preempt_max_latency
>   echo 0 > /proc/sys/kernel/trace_enabled

OK, thanks for clarifying.

Lee


