Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270672AbTHGUpX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 16:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270749AbTHGUpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 16:45:23 -0400
Received: from holomorphy.com ([66.224.33.161]:14742 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270672AbTHGUpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 16:45:22 -0400
Date: Thu, 7 Aug 2003 13:45:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: rob@landley.net, Ed Sweetman <ed.sweetman@wmich.edu>,
       Eugene Teo <eugene.teo@eugeneteo.net>,
       LKML <linux-kernel@vger.kernel.org>, kernel@kolivas.org,
       Davide Libenzi <davidel@xmailserver.org>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Message-ID: <20030807204559.GY32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Daniel Phillips <phillips@arcor.de>, rob@landley.net,
	Ed Sweetman <ed.sweetman@wmich.edu>,
	Eugene Teo <eugene.teo@eugeneteo.net>,
	LKML <linux-kernel@vger.kernel.org>, kernel@kolivas.org,
	Davide Libenzi <davidel@xmailserver.org>
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307271046.30318.phillips@arcor.de> <200308061728.04447.rob@landley.net> <200308071642.55517.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308071642.55517.phillips@arcor.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 August 2003 22:28, Rob Landley wrote:
>> So, how does SCHED_SOFTRR fail?  Theoretically there is a minimum timeslice
>> you can hand out, yes?  And an upper bound on scheduling latency.  So
>> logically, there is some maximum number "N" of SCHED_SOFTRR tasks running
>> at once where you wind up round-robining with minimal timeslices and the
>> system is saturated.  At N+1, you fall over.  (And in reality, there are
>> interrupts and kernel threads and other things going on that get kind of
>> cramped somewhere below N.)

On Thu, Aug 07, 2003 at 04:42:55PM +0100, Daniel Phillips wrote:
> The upper bound for softrr realtime scheduling isn't based on number
> of tasks, it's a global slice of cpu time: so long as the sum of
> running times of all softrr tasks in the system lies below limit,
> softrr tasks will be scheduled as SCHED_RR, otherwise they will be
> SCHED_NORMAL.

You're thinking of Little's law, which is describes the mean number of
waiters on a queue as the mean service time divided by the number of
servers times the mean inter-arrival time.


-- wli
