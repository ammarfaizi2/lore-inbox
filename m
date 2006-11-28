Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758751AbWK1SrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758751AbWK1SrX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 13:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936009AbWK1SrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 13:47:23 -0500
Received: from outbound0.mx.meer.net ([209.157.153.23]:28684 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S1758751AbWK1SrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 13:47:22 -0500
Subject: Re: 2.6.19-rc6-mm1 -- sched-improve-migration-accuracy.patch slows
	boot
From: Don Mullis <dwm@meer.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061127101600.GB5812@elte.hu>
References: <20061123021703.8550e37e.akpm@osdl.org>
	 <1164484124.2894.50.camel@localhost.localdomain>
	 <1164522263.5808.12.camel@Homer.simpson.net>
	 <1164591509.2894.76.camel@localhost.localdomain>
	 <20061127101600.GB5812@elte.hu>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 10:47:02 -0800
Message-Id: <1164739622.2894.116.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-27 at 11:16 +0100, Ingo Molnar wrote:
> could you run this utility:
> 
>   http://people.redhat.com/mingo/time-warp-test/time-warp-test.c
> 
> on your box for a while (10 minutes or so) - what does it print?
> 
> 	Ingo

1 CPUs, running 1 parallel test-tasks.
checking for time-warps via:
- read time stamp counter (RDTSC) instruction (cycle resolution)
- gettimeofday (TOD) syscall (usec resolution)
- clock_gettime(CLOCK_MONOTONIC) syscall (nsec resolution)

new TOD-warp maximum:   -442709 usecs,  00042352e214e2f8 ->
00042352e20e21a3
 | 0.69 us, TSC-warps:0 | 6.89 us, TOD-warps:1 | 6.89 us, CLOCK-warps:0
|


