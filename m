Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031179AbWI0Wu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031179AbWI0Wu2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031183AbWI0Wu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:50:28 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:59564 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1031179AbWI0WuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:50:25 -0400
Subject: Re: Athlon64x2 problem with 2.6.18-rt4 and hrtimers
From: Lee Revell <rlrevell@joe-job.com>
To: tglx@linutronix.de
Cc: Clark Williams <williams@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1159394364.9326.560.camel@localhost.localdomain>
References: <451ADF7A.8070709@redhat.com>
	 <1159394364.9326.560.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 18:50:59 -0400
Message-Id: <1159397459.1275.55.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-27 at 23:59 +0200, Thomas Gleixner wrote:
> Can you please switch on CONFIG_LATENCY_TRACE (depends on
> CONFIG_LATENCY_TIMING) ?
> 
> Use the latest version of cyclictest and add -b XXX to the command
> line,
> where XXX is the maximum latency in micro seconds. Once the latency is
> greater than the given maximum, the kernel tracer and cyclictest is
> stopped.
> 
> Now you can read the kernel trace:
> 
> cat /proc/latency_trace >trace.log 
> 
> The trace should give us more insight. 

I thought latency tracing did not work on Athlon X2 due to the unsynced
TSCs problem?

Lee

