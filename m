Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314414AbSDRSuM>; Thu, 18 Apr 2002 14:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314417AbSDRSuL>; Thu, 18 Apr 2002 14:50:11 -0400
Received: from chaos.analogic.com ([204.178.40.224]:17285 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S314414AbSDRSuK>; Thu, 18 Apr 2002 14:50:10 -0400
Date: Thu, 18 Apr 2002 14:53:02 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: linux@horizon.com
cc: linux-kernel@vger.kernel.org
Subject: Re: SSE related security hole
In-Reply-To: <20020418183639.20946.qmail@science.horizon.com>
Message-ID: <Pine.LNX.3.95.1020418144215.30908A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Apr 2002 linux@horizon.com wrote:

> Um, people here seem to be assuming that, in the absence of MMX,
> fninit *doesn't* leak information.
> 
> I thought it was well-known to just clear (set to all-ones) the
> tag register and not alter the actual floating-point registers.
> 
> Thus, it seems quite feasible to reset the tag word with FLDENV and
> store out the FPU registers, even on an 80387.
> 
> Isn't this the same security hole?  Shouldn't there be 8 FLDZ instructions
> (or equivalent) in the processor state initialization?

Well, if what's on the internal stack of the FPU can actually leak
information, I think the notion of "leak" has expanded just a bit
too much.

A rogue process could not even know what instruction was about to
be executed, nor what the previous instruction was, nor when since
boot it was executed, nor by whom. The 'data' associated with those
unknown instructions would make a good random number generator,
or a round-about method of obtaining PI (st0 almost always contains it).
That's about all.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

