Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289026AbSBXBH2>; Sat, 23 Feb 2002 20:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289053AbSBXBHS>; Sat, 23 Feb 2002 20:07:18 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:42513 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S289026AbSBXBHF>;
	Sat, 23 Feb 2002 20:07:05 -0500
Date: Sat, 23 Feb 2002 18:05:21 -0700
From: yodaiken@fsmlabs.com
To: Andrew Morton <akpm@zip.com.au>
Cc: Robert Love <rml@tech9.net>, Roman Zippel <zippel@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
Message-ID: <20020223180521.A5150@hq.fsmlabs.com>
In-Reply-To: <1014449389.1003.149.camel@phantasy> <3C774AC8.5E0848A2@zip.com.au> <20020223043815.B29874@hq.fsmlabs.com> <1014488408.846.806.camel@phantasy> <20020223120648.A1295@hq.fsmlabs.com> <3C781037.EA4ADEF5@linux-m68k.org> <3C781351.DCB40AD3@zip.com.au> <1014505987.1003.1104.camel@phantasy> <1014507951.850.1140.camel@phantasy> <3C782C34.2CC0E417@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3C782C34.2CC0E417@zip.com.au>; from akpm@zip.com.au on Sat, Feb 23, 2002 at 03:56:36PM -0800
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 03:56:36PM -0800, Andrew Morton wrote:
> Robert Love wrote:
> > 
> For the situation Victor described:
> 
> 	const int cpu = smp_get_cpuid();
> 
> 	per_cpu_array_foo[cpu] = per_cpu_array_bar[cpu] +
> 					per_cpu_array_zot[cpu];
> 
> 	smp_put_cpuid();
> 
> It's a nice interface - it says "pin down and return the current
> CPU ID".

Go for it! Only 900 odd calls to smp_processor_id in the kernel
source last time I checked.


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

