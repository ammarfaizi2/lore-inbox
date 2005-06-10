Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVFJTCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVFJTCm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 15:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVFJTCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 15:02:42 -0400
Received: from fsmlabs.com ([168.103.115.128]:50825 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261173AbVFJTCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 15:02:40 -0400
Date: Fri, 10 Jun 2005 13:05:44 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andre <andre@rocklandocean.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ZFx86 support broken?
In-Reply-To: <00fb01c56dec$91f0e440$6702a8c0@niro>
Message-ID: <Pine.LNX.4.61.0506101304520.31175@montezuma.fsmlabs.com>
References: <00fb01c56dec$91f0e440$6702a8c0@niro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2005, Andre wrote:

> I am trying to boot LFS6.0.1 livecd which has 2.6.8.1, but the kernel hangs
> at:
> Freeing unused kernel memory: 456k freed
> 
> My system is a pc/104 board based on ZFx86 with 64M ram
> I also found this posting:
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-03/5939.html
> Looking at the console output, the cpu gets recognized as 486, whereas
> 2.4.22 detects the cpu as Cyrix Cx486DX4
> 
> Looking at the kernel source, it seems to get stuck after the call to
> free_initmem and when I tried to specify init=/bin/sh it still got stuck at
> the same place so I figured it doesn't even get to the run_init_process
> calls in ..../init/main.c. Could the call to unlock_kernel get stuck?

It looks like it may be having trouble with userspace, try confirming that 
it is indeed mounting root and doing run_init_process.

