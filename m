Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268786AbUI2Sk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268786AbUI2Sk7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 14:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268800AbUI2Sk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 14:40:59 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:31966 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268786AbUI2Sk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 14:40:58 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm4-S7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20040928000516.GA3096@elte.hu>
References: <1094683020.1362.219.camel@krustophenia.net>
	 <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu>
	 <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu>
	 <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu>
	 <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu>
	 <20040924074416.GA17924@elte.hu>  <20040928000516.GA3096@elte.hu>
Content-Type: text/plain
Message-Id: <1096483257.1600.44.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 29 Sep 2004 14:40:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 20:05, Ingo Molnar wrote:
> i've released the -S7 VP patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm4-S7

Disabling latency tracing does not seem to work.  To demonstrate:

	echo 0 > /proc/sys/kernel/preempt_max_latency
	echo 0 > /proc/sys/kernel/trace_enabled
	modprobe foo-module (will reliably cause a ~3-600 usec latency in resolve_symbol)
	check /proc/latency_trace, or dmesg, it will be the modprobe latency.
	cat /proc/sys/kernel/trace_enabled, it is still 0

This definitely worked at one point.  Not sure when it broke.

Lee

