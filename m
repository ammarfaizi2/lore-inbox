Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129811AbRBYD4p>; Sat, 24 Feb 2001 22:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129812AbRBYD4f>; Sat, 24 Feb 2001 22:56:35 -0500
Received: from cc668399-a.ewndsr1.nj.home.com ([24.180.97.113]:24048 "EHLO
	eriador.mirkwood.net") by vger.kernel.org with ESMTP
	id <S129811AbRBYD4U>; Sat, 24 Feb 2001 22:56:20 -0500
Date: Sat, 24 Feb 2001 22:51:15 -0500 (EST)
From: pf-kernel@mirkwood.net
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.2 - kernel BUG at apic.c:220!
In-Reply-To: <000c01c09e92$25dd2e40$5517fea9@local>
Message-ID: <Pine.LNX.4.20.0102242243340.385-100000@eriador.mirkwood.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Feb 2001, Manfred Spraul wrote:

> > kernel BUG at apic.c:220!
> >From apic.c:
> <<<<<<<<<<<
> 
>         /*
>          * Double-check wether this APIC is really registered.
>          */
>         if (!test_bit(GET_APIC_ID(apic_read(APIC_ID)),
> &phys_cpu_present_map))
>                 BUG();
> >>>>>>>>>>>
> Really odd. That's usually a sign of a bad MP table.
> 
> Could you check your BIOS settings for an entry MP, or MPS, or
> Multiprocessor Table?
> Usually the options are 1.1 and 1.4 - just try the other one.

This is a single CPU system, not dual.  The kernel is compiled for a
single CPU system as well.

Looking at .config, I notice that Processor family is set to
Pentium-Pro/Celeron/Pentium-II.  I could have *sworn* I changed that
before compiling.  Could that cause the problem I'm seeing?

In any case, I'll try to get some time early next week to try the patch -
this is, unfortunately, a work machine, and as such, needs to work, even
if I go with 2.2.x.  :)

I'll let you know when I can try out the patch.

> 
> or try the attached patch - it prints 2 additional debug lines.
> 
> --
>     Manfred
> 
> 
> 


-----------------------------------
Unsolicited advertisments to this address are not welcome.

