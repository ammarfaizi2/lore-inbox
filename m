Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317924AbSHHTx6>; Thu, 8 Aug 2002 15:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317922AbSHHTxz>; Thu, 8 Aug 2002 15:53:55 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:47342 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317918AbSHHTxw>;
	Thu, 8 Aug 2002 15:53:52 -0400
Message-ID: <3D52CD0B.AF8C5068@mvista.com>
Date: Thu, 08 Aug 2002 12:56:59 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: marcelo <marcelo@conectiva.com.br>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL][PATCH] cpu_has_tsc cleanup
References: <1028765030.22918.166.camel@cog>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> 
> Marcelo,
> 
> Here is a trivial cleanup patch that replaces:
>         test_bit(X86_FEATURE_TSC, &boot_cpu_data.x86_capability)
> w/ the cpu_has_tsc macro.
> 
> I believe this was originally by Brian Gerst for 2.5
> 
This patch has a problem in the TSC not defined case in that
it access the PIT with out taking the required
locks.         spin_lock_irq(&i8253_lock) is used to protect
the PIT...

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
