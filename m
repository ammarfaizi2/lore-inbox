Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUHHCbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUHHCbO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 22:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264973AbUHHCbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 22:31:14 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:9352 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264937AbUHHCbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 22:31:02 -0400
Subject: Re: [patch] preempt-timing-on-2.6.8-rc2-O2
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040802105100.GA22855@elte.hu>
References: <1091234100.1677.41.camel@mindpipe>
	 <Pine.LNX.4.58.0408010725030.23711@devserv.devel.redhat.com>
	 <1091403477.862.4.camel@mindpipe> <1091407585.862.40.camel@mindpipe>
	 <20040802073938.GA8332@elte.hu> <1091435237.3024.9.camel@mindpipe>
	 <20040802092855.GA15894@elte.hu> <20040802100815.GA18349@elte.hu>
	 <20040802101840.GB2334@holomorphy.com> <20040802103516.GA20584@elte.hu>
	 <20040802105100.GA22855@elte.hu>
Content-Type: text/plain
Message-Id: <1091932214.1150.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 07 Aug 2004 22:31:06 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-02 at 06:51, Ingo Molnar wrote:
> Newest patch at:
> 
>  http://redhat.com/~mingo/voluntary-preempt/preempt-timing-on-2.6.8-rc2-O2
> 

I get a *lot* of these:

(swapper/0): 996us non-preemptible critical section violated 100 us
preempt threshold starting at schedule+0x55/0x5a0 and ending at
do_IRQ+0x110/0x180
 [<c0106717>] dump_stack+0x17/0x20
 [<c0113eec>] dec_preempt_count+0x3c/0x50
 [<c0107a20>] do_IRQ+0x110/0x180
 [<c01062d8>] common_interrupt+0x18/0x20
 [<c0104222>] cpu_idle+0x32/0x50
 [<c030a782>] start_kernel+0x1a2/0x1f0
 [<c010019f>] 0xc010019f

This has to be a false positive, because if there were really ~1ms
non-preemptible critical sections all over the place I would be getting
xruns.

Lee 

