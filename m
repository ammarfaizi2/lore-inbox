Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293244AbSBWWmx>; Sat, 23 Feb 2002 17:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293243AbSBWWmn>; Sat, 23 Feb 2002 17:42:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19204 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293244AbSBWWm1>;
	Sat, 23 Feb 2002 17:42:27 -0500
Message-ID: <3C781A7A.24B59934@zip.com.au>
Date: Sat, 23 Feb 2002 14:40:58 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Roman Zippel <zippel@linux-m68k.org>, Robert Love <rml@tech9.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
In-Reply-To: <3C773C02.93C7753E@zip.com.au>, <1014444810.1003.53.camel@phantasy> <3C773C02.93C7753E@zip.com.au> <1014449389.1003.149.camel@phantasy> <3C774AC8.5E0848A2@zip.com.au> <20020223043815.B29874@hq.fsmlabs.com> <1014488408.846.806.camel@phantasy> <20020223120648.A1295@hq.fsmlabs.com> <3C781037.EA4ADEF5@linux-m68k.org> <3C781351.DCB40AD3@zip.com.au>,
		<3C781351.DCB40AD3@zip.com.au>; from akpm@zip.com.au on Sat, Feb 23, 2002 at 02:10:25PM -0800 <20020223152337.A3577@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yodaiken@fsmlabs.com wrote:
> 
> Is this part of some scheme to make the GPL support model actually
> pay?

No, no, no.  It's all the uncommented code which brings in the dollars.
 
>         c = smp_get_cpuid(); // disables preemption
> 
>         ...
>         f(); // oops, me forgotee, this function also references cpuid
>         ..
>         x = ++local_cache[c]; // live dangerously
>         smp_put_cpuid(); // G_d knows what that does now.
> 

preempt_disable() nests.   It's not a problem.

-
