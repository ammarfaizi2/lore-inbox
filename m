Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133110AbRDVBs1>; Sat, 21 Apr 2001 21:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133111AbRDVBsS>; Sat, 21 Apr 2001 21:48:18 -0400
Received: from chaos.analogic.com ([204.178.40.224]:34945 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S133110AbRDVBsB>; Sat, 21 Apr 2001 21:48:01 -0400
Date: Sat, 21 Apr 2001 21:46:56 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ulrich Drepper <drepper@cygnus.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: Global FPU corruption in 2.2
In-Reply-To: <m33db3s0ty.fsf@otr.mynet.cygnus.com>
Message-ID: <Pine.LNX.3.95.1010421213945.1407A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Apr 2001, Ulrich Drepper wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> writes:
> 
> > The kernel doesn't know if a process is going to use the FPU when
> > a new process is created. Only the user's code, i.e., the 'C' runtime
> > library knows.
> 
> Maybe you should try to understand the kernel code and the features of
> the processor first.  The kernel can detect when the FPU is used for
> the first time.
> 

Only if it traps on the esc op-code --and if it does, we are in a
world or hurt for performance. There is no other way that the kernel
can 'protect' on a per-process basis since the FPU executes instructions
in "process-owned" address space, and addresses "process-owned" data.

I'll have to check this out. Of course it traps on all such instructions
if we have a '386 (so the FPU can be emulated), but that was never a
performance issue.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


