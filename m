Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318569AbSHABal>; Wed, 31 Jul 2002 21:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318572AbSHABal>; Wed, 31 Jul 2002 21:30:41 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:50193 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S318569AbSHABak>;
	Wed, 31 Jul 2002 21:30:40 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200208010133.g711Xq7338295@saturn.cs.uml.edu>
Subject: Re: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
To: ltd@cisco.com (Lincoln Dale)
Date: Wed, 31 Jul 2002 21:33:52 -0400 (EDT)
Cc: david_luyer@pacific.net.au (David Luyer),
       alan@lxorguk.ukuu.org.uk ('Alan Cox'), linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020801094111.02776df0@mira-sjcm-3.cisco.com> from "Lincoln Dale" at Aug 01, 2002 09:42:15 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lincoln Dale writes:
> At 10:59 PM 31/07/2002 +1000, David Luyer wrote:
> >Alan Cox wrote:

>>> HZ on x86 for user space is defined as 100. Its a procps problem
>>
>> Slight error in my initial diagnosis of why procps is getting Hertz
>> wrong tho.  It's not because timer interrupts are only happening
>> on one CPU.  It's because it thinks I have 4 CPUs per system, when
>> really I only have 2 CPUs per system.
>
> procps is still wrong.
>
> HZ on x86 is 100 by default.
> that isn't 100 per CPU, but 100 per second, regardless of whether the timer 
> interrupt is distributed between CPUs or serviced on a single CPU.

No shit. Now, how do you create a ps executable that handles
a 2.4.xx kernel with a modified HZ value? People did this all
the time. I got many bug reports from these people, so don't
go saying they don't exist. Remember: one executable, running
on both of the these:

2.2.xx i386 as shipped by Linus
2.4.xx i386 with HZ modified

Come on, write the code if you think it's so easy.
You get bonus points for supporting 2.0.xx kernels
and the IA-64 kernel with that same executable.

Maybe you think I should tell these people to go to Hell?
In that case, what about the Alpha systems that ran HZ at
1200 instead of 1024?

I really wonder why people love to torment me for having the
decency to support systems that aren't 100% Linus-compliant.
Do you people burn idols for Linus, or only kiss his butt?
