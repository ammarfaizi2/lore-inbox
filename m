Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318915AbSICSbO>; Tue, 3 Sep 2002 14:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318916AbSICSbO>; Tue, 3 Sep 2002 14:31:14 -0400
Received: from [209.249.170.16] ([209.249.170.16]:1800 "EHLO dns1.nvidia.com")
	by vger.kernel.org with ESMTP id <S318915AbSICSbN>;
	Tue, 3 Sep 2002 14:31:13 -0400
From: Terence Ripperda <TRipperda@nvidia.com>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Terence Ripperda <TRipperda@nvidia.com>, linux-kernel@vger.kernel.org
Date: Tue, 3 Sep 2002 13:35:24 -0500
Subject: Re: lockup on Athlon systems, kernel race condition?
Message-ID: <20020903183524.GC2343@hygelac>
References: <20020830204022.GC736@hygelac> <3D6FE062.A48B6F03@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D6FE062.A48B6F03@zip.com.au>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.4.19 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 02:15:14PM -0700, akpm@zip.com.au wrote:
> This CPU is spinning, waiting for kernel_flag.  It will take the IPI
> and the other CPU's smp_call_function() will succeed.

thank you for the clarification, Andrew. I was unclear whether the 'lock' command would block out the IPI or not.

> Possibly the IPI has got lost - seems that this is a popular failure mode
> for flakey chipsets/motherboards.

this sounds like the most likely candidate. I'm working on tracking down documentation for further study. Is there an easy way to determine this as the cause? 

> Or someone has called sys_ioctl() with interrupts disabled.  That's very
> doubtful.

I agree, that's highly doubtful.

one of our QA guys tried to reproduce this issue on an ATI card, but was unable to get through viewperf long enough to repro this problem before hitting other system lockups. I'm also installing an ATI card to try and see if I can reproduce the problem.

Terence
