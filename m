Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263265AbTEIQmU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 12:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTEIQmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 12:42:20 -0400
Received: from holomorphy.com ([66.224.33.161]:2209 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263265AbTEIQmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 12:42:19 -0400
Date: Fri, 9 May 2003 09:53:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@tech9.net>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: how to measure scheduler latency on powerpc?  realfeel doesn't work due to /dev/rtc issues
Message-ID: <20030509165359.GX8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@tech9.net>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50.0305081735040.2094-100000@blue1.dev.mcafeelabs.com> <20030509003825.GR8978@holomorphy.com> <Pine.LNX.4.53.0305082052160.21290@chaos> <3EBB25FD.7060809@nortelnetworks.com> <20030509042659.GS8978@holomorphy.com> <3EBB4735.30701@nortelnetworks.com> <20030509062008.GT8978@holomorphy.com> <3EBB504C.1030001@nortelnetworks.com> <20030509070142.GU8978@holomorphy.com> <1052498824.867.8.camel@icbm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052498824.867.8.camel@icbm>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-09 at 03:01, William Lee Irwin III wrote:
>> Why not just keep track of it in the scheduler? The statistic is well-
>> defined in terms of things measurable at context switch and wakeup.

On Fri, May 09, 2003 at 12:47:05PM -0400, Robert Love wrote:
> This would measure context switch latency.  Or something.
> By definition, scheduling latency is the time from an interrupt which
> wakes the task up until the task is actually running.
> Historically, it has been measured by things like realfeel or amlat or
> whatever which generate interrupts and wake a waiting task up. You then
> measure the latency between the interrupt and when the task actually
> runs in user-space.
> So Chris can then go run this test under varying loads and see how bad
> the latency gets.  I understand his question, but (sorry Chris) I have
> no idea of the solution on PPC.

Not at all. Just stamp at wakeup and difference when it runs.


-- wli
