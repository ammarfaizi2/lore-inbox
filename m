Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266381AbUGUA7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266381AbUGUA7q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 20:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266386AbUGUA7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 20:59:46 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:54544 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266381AbUGUA7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 20:59:44 -0400
Message-ID: <40FDC625.9080804@techsource.com>
Date: Tue, 20 Jul 2004 21:25:57 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary	Kernel	Preemption
 Patch
References: <20040712163141.31ef1ad6.akpm@osdl.org>	 <1090306769.22521.32.camel@mindpipe> <20040720071136.GA28696@elte.hu>	 <200407202011.20558.musical_snake@gmx.de>	 <1090353405.28175.21.camel@mindpipe>  <40FDAF86.10104@gardena.net> <1090369957.841.14.camel@mindpipe>
In-Reply-To: <1090369957.841.14.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Lee Revell wrote:

> There are still a few areas that need work, ioctl gives me problems, but
> the latest 2.6 kernels are quite good.  If you look at the 'clean'
> version of the voluntary kernel preemption patch it is pretty small.  My
> understanding is that the kernel is already preemptible anytime that a
> spin lock (including the BKL) is not held, and that the voluntary kernel
> preemption patch adds some scheduling points in places where it is safe
> to sleep, but preemption is disabled because we are holding the BKL, and
> that the number of these should approach zero as the kernel is improved
> anyway.


That's confusing to me.  It was my understanding that the BKL is used to 
completely lock down the kernel so that no other CPU can have a process 
get into the kernel... something like how SMP was done under 2.0.

So, if you sleep during a BKL, wouldn't that imply that nothing else 
would be allowed to enter the kernel until after the kernel thread that 
took the lock wakes up and releases the lock?


