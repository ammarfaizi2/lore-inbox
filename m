Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129829AbQJaXDc>; Tue, 31 Oct 2000 18:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130082AbQJaXDW>; Tue, 31 Oct 2000 18:03:22 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:35083 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129829AbQJaXDK>; Tue, 31 Oct 2000 18:03:10 -0500
Message-ID: <39FF4EC7.446570C7@timpanogas.org>
Date: Tue, 31 Oct 2000 15:59:19 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Andi Kleen <ak@suse.de>, Pavel Machek <pavel@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <Pine.LNX.4.21.0011010102370.17233-100000@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:
> 
> On Tue, 31 Oct 2000, Jeff V. Merkey wrote:
> 
> > One more optimization it has.  NetWare never "calls" functions in the
> > kernel.  There's a template of register assignments in between kernel
> > modules that's very strict (esi contains a WTD head, edi has the target
> > thread, etc.) and all function calls are jumps in a linear space.
> 
> this might be a win on a i486, but is a loss with any branch predicting,
> large-pipeline CPUs (think Pentium IV), which are optimized for CALLs, not
> for JMP *EAX instructions. This is the problem with assembly optimizations
> that try to compete with the compiler's work: hand-made assembly can only
> get worse over time (stay constant in the best case), while compilers are
> known to improve slowly but steadily. Plus hand-made assembly is a huge
> stone tied to your legs if you try to swim to other architectures. Eg. we
> quite often make use of GCC's register-based function parameter passing
> optimization. We do use hand-made assembly in a number of cases in Linux
> as well, and double-check GCC's assembly output in critical code paths,
> but we try to not make it an essential facility.

It's hand optimized for all these cases to one of the highest degrees
that exist anywhere in the world.   Intel and Novell have been in bed
together for a very long time...

Jeff

> 
>         Ingo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
