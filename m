Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262657AbREVQze>; Tue, 22 May 2001 12:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262656AbREVQzY>; Tue, 22 May 2001 12:55:24 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:16657 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262643AbREVQzN>; Tue, 22 May 2001 12:55:13 -0400
Message-ID: <3B0A99E7.467CE534@transmeta.com>
Date: Tue, 22 May 2001 09:55:03 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Output of L1,L2 and L3 cache sizes to /proc/cpuinfo
In-Reply-To: <3B0A28C0.2FFFC935@TeraPort.de> <3B0A3794.15BDF9D6@TeraPort.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin.Knoblauch" wrote:
> 
>  After some checking, I could have made the answer a bit less terse:
> 
> - it would require that the kernel is compiled with cpuid [module]
> support
>   - not everybody may want enable this, just for getting one or two
>     harmless numbers.

If so, then that's their problem.  We're not here to solve the problem of
stupid system administrators.

> - you would need a utility with root permission to analyze the cpuid
> info. The
>   cahce info does not seem to be there in clear ascii.

Bullsh*t.  /dev/cpu/%d/cpuid is supposed to be mode 444 (world readable.)

>   - this limits my script to root users, or you need the setuid-bit on
> the
>     utility. Not really good for security.

See above.

> - the cpuid stuff is i386 specific [today]. So are my changes. But
> implementing
>   them for other architectures [if there is interest in the info] would
> not
>   require to also implement the cpuid on other architectures. Which may
> not make any
>   sense at all.
> 
>  So, having the numbers in clear text in the cpuinfo file looks simpler
> and safer to me, although reading /dev/cpu/*/cpuinfo maybe more
> versatile [on i386] - at some cost.
> 
>  Question: are there any utilities or other uses for the cpuid device
> today? Just interested. The kernel seems to work well without it.

That is usually the case with devices -- the kernel doesn't care, why
would it?

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
