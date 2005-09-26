Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbVIZTEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbVIZTEb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 15:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbVIZTEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 15:04:31 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:38319 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932465AbVIZTEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 15:04:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=KJh3VAJjExYISoQshAyRVmWo9bk0uNSzxQTrE8sNZr+luj2bGSfaUCGcediG+rsShcsotvkzgeYq7J5mdQ753xPHUMd+2ODCMDfPk3aMkN0/V0tYmA7kcNRaiIGowwIXWUX9/7pXe/411tFnQ8Y8V4iRS5ZiOCs/sajyPd4FUVc=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: "Fernando Lopez-Lezcano" <nando@ccrma.stanford.edu>
Subject: Re: jack, PREEMPT_DESKTOP, delayed interrupts?
Date: Mon, 26 Sep 2005 21:08:55 +0200
User-Agent: KMail/1.8.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509262108.55448.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> # cat /proc/latency_trace
> preemption latency trace v1.1.5 on 2.6.13-0.3.rdtd.rhfc4.ccrmasmp
> --------------------------------------------------------------------
>  latency: 10852 us, #70/70, CPU#0 | (M:preempt VP:0, KP:1, SP:1 HP:1
> #P:2)
>     -----------------
>     | task: qjackctl-4797 (uid:743 nice:0 policy:1 rt_prio:61)
>     -----------------
> 
>                  _------=> CPU#
>                 / _-----=> irqs-off
>                | / _----=> need-resched
>                || / _---=> hardirq/softirq
>                ||| / _--=> preempt-depth
>                |||| /
>                |||||     delay
>    cmd     pid ||||| time  |   caller
>       \   /    |||||   \   |   /
>    <...>-4593  1Dnh3    0us : MacPrivateStat (SkPnmiGetStruct)
>    <...>-4593  1Dnh3    0us : MacPrivateStat (SkPnmiGetStruct)
<snip>
>    <...>-4593  1Dnh3   18us : SkGmMacStatistic (GetPhysStatVal)
>    <...>-4593  1Dnh3   20us : GetStatVal (MacPrivateStat)
>    <...>-4593  1Dnh3   20us : GetPhysStatVal (GetStatVal)
>    <...>-4593  1Dnh3   20us+: SkGmMacStatistic (GetPhysStatVal)
>    <...>-4593  1Dnh3   22us : GetStatVal (MacPrivateStat)
>    <...>-4593  1Dnh3   22us : GetPhysStatVal (GetStatVal)
>    <...>-4593  1Dnh3   22us+: SkGmMacStatistic (GetPhysStatVal)
>    <...>-4593  1Dnh3   24us!: MacPrivateStat (SkPnmiGetStruct)
> softirq--8     0Dnh4 9901us : trace_change_sched_cpu (1 0 0)

Maybe your ethernet device is getting in the way.
Do you also get jack dropouts with ethernet chip disabled,
it's Module unloaded?

      Karsten

		
___________________________________________________________ 
Was denken Sie über E-Mail? Wir hören auf Ihre Meinung: http://surveylink.yahoo.com/wix/p0379378.aspx
