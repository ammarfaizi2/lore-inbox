Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267479AbSLSBcD>; Wed, 18 Dec 2002 20:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267490AbSLSBcD>; Wed, 18 Dec 2002 20:32:03 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:27399
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267479AbSLSBcC>; Wed, 18 Dec 2002 20:32:02 -0500
Subject: Re: [BENCHMARK] scheduler tunables with contest - max_timeslice
From: Robert Love <rml@tech9.net>
To: Con Kolivas <conman@kolivas.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1040261508.3e012184e56c4@kolivas.net>
References: <1040261508.3e012184e56c4@kolivas.net>
Content-Type: text/plain
Organization: 
Message-Id: <1040262005.848.102.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Dec 2002 20:40:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-18 at 20:31, Con Kolivas wrote:

> Using the osdl (http://www.osdl.org) resources provided to me I'm running a
> series of contest benchmarks on 2.5.52-mm1 and modifying the scheduler tunables
> as provided by RML's patch. SMP used to minimise how long it will take me to do
> these. This is the first in the series and I've run a range of max_timeslices
> (default is 300ms; range 100-400):

Thanks, Con.

> I will continue to do these with some of the other scheduler tunables. I will
> need recommendations if anyone is interested in further resolution testing than
> that I'm currently doing.

Some ideas...

Try child_penalty=50,75 (default is 95%)

Try max_sleep_avg=500,1000,4000 (default is 2000ms)

Try prio_bonus_ratio=0,10,30,50 (default is 25%)

Try starvation_limit=1000 (default is 2000ms)

Some of these are just academic, although I am curious about
child_penalty and starvation_limit.  In other cases, we can assuredly
improve interactivity but we have to worry about throughput and
starvation.  Nonetheless, I am curious as to what you will find. :)

	Robert Love

