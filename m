Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293246AbSBWWtx>; Sat, 23 Feb 2002 17:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293241AbSBWWto>; Sat, 23 Feb 2002 17:49:44 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:55823 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S293250AbSBWWtb>;
	Sat, 23 Feb 2002 17:49:31 -0500
Date: Sat, 23 Feb 2002 15:48:06 -0700
From: yodaiken@fsmlabs.com
To: Andrew Morton <akpm@zip.com.au>
Cc: yodaiken@fsmlabs.com, Roman Zippel <zippel@linux-m68k.org>,
        Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
Message-ID: <20020223154806.A4272@hq.fsmlabs.com>
In-Reply-To: <1014449389.1003.149.camel@phantasy> <3C774AC8.5E0848A2@zip.com.au> <20020223043815.B29874@hq.fsmlabs.com> <1014488408.846.806.camel@phantasy> <20020223120648.A1295@hq.fsmlabs.com> <3C781037.EA4ADEF5@linux-m68k.org> <3C781351.DCB40AD3@zip.com.au>, <3C781351.DCB40AD3@zip.com.au>; <20020223152337.A3577@hq.fsmlabs.com> <3C781A7A.24B59934@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3C781A7A.24B59934@zip.com.au>; from akpm@zip.com.au on Sat, Feb 23, 2002 at 02:40:58PM -0800
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 02:40:58PM -0800, Andrew Morton wrote:
> yodaiken@fsmlabs.com wrote:
> > 
> > Is this part of some scheme to make the GPL support model actually
> > pay?
> 
> No, no, no.  It's all the uncommented code which brings in the dollars.
>  
> >         c = smp_get_cpuid(); // disables preemption
> > 
> >         ...
> >         f(); // oops, me forgotee, this function also references cpuid
> >         ..
> >         x = ++local_cache[c]; // live dangerously
> >         smp_put_cpuid(); // G_d knows what that does now.
> > 
> 
> preempt_disable() nests.   It's not a problem.

Ah, got the reference count already! Good progress.
Is it irq safe yet?


BTW: Robert, whats a good kernel version that you recommend with
preemption patch? I want to rerun some tests.

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

