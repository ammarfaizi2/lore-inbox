Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316887AbSGXGbq>; Wed, 24 Jul 2002 02:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316892AbSGXGbq>; Wed, 24 Jul 2002 02:31:46 -0400
Received: from [196.26.86.1] ([196.26.86.1]:12194 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316887AbSGXGbp>; Wed, 24 Jul 2002 02:31:45 -0400
Date: Wed, 24 Jul 2002 08:52:41 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: george anzinger <george@mvista.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: odd memory corruption in 2.5.27?
In-Reply-To: <3D3DBD4B.4EFD3543@mvista.com>
Message-ID: <Pine.LNX.4.44.0207240851030.32636-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2002, george anzinger wrote:

> protecting them with a combination of interrupt disables and
> spin_locks.  Preemption is allowed (incorrectly) if
> interrupts are off and preempt_count goes to zero on the
> spin_unlock.  I will wager that this is an SMP machine. 
> After the preemption interrupts will be on (schedule() does
> that) AND you could be on a different cpu.  Either of these
> is a BAD thing.
> 
> The proposed fix is to catch the attempted preemption in
> preempt_schedule() and just return if the interrupt system
> is off.  (Of course there is more that this to it, but I do
> believe that the problem is known.  You could blow this
> assertion out of the water by asserting that the machine is
> NOT smp.)

I haven't looked at it further than gathering oopses and idly browsing 
surrounding code. About your assertion, you're almost right, its UP box 
running an SMP kernel w/ CONFIG_PREEMT. 

-- 
function.linuxpower.ca

