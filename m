Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265022AbUHHCrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265022AbUHHCrH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 22:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUHHCrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 22:47:07 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:6026 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265022AbUHHCrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 22:47:04 -0400
Subject: Re: [patch] preempt-timing-on-2.6.8-rc2-O2
From: Lee Revell <rlrevell@joe-job.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040808023941.GQ17188@holomorphy.com>
References: <20040802073938.GA8332@elte.hu>
	 <1091435237.3024.9.camel@mindpipe> <20040802092855.GA15894@elte.hu>
	 <20040802100815.GA18349@elte.hu> <20040802101840.GB2334@holomorphy.com>
	 <20040802103516.GA20584@elte.hu> <20040802105100.GA22855@elte.hu>
	 <1091932214.1150.3.camel@mindpipe> <20040808023306.GP17188@holomorphy.com>
	 <1091932615.1150.6.camel@mindpipe>  <20040808023941.GQ17188@holomorphy.com>
Content-Type: text/plain
Message-Id: <1091933229.1150.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 07 Aug 2004 22:47:09 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-07 at 22:39, William Lee Irwin III wrote:
> On Sat, 2004-08-07 at 22:33, William Lee Irwin III wrote:
> >> This seems to be 996us spent in do_IRQ() when it interrupts idle tasks.
> 
> On Sat, Aug 07, 2004 at 10:36:55PM -0400, Lee Revell wrote:
> > I am not sure I understand how preemption can be disabled for 996us and
> > not cause an xrun.
> 
> You were idling at the time, so the latency affected nothing, except
> perhaps task migration on SMP.
> 

Would it be possible to detect this situation and treat it like a
preemptible section, just so the sheer volume of printks does not cause
a problem?

Lee

