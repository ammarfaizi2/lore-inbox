Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265350AbRGJBvg>; Mon, 9 Jul 2001 21:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265334AbRGJBvQ>; Mon, 9 Jul 2001 21:51:16 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:41415 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S264906AbRGJBvK>; Mon, 9 Jul 2001 21:51:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: VIA Southbridge bug (Was: Crash on boot (2.4.5))
Date: Mon, 9 Jul 2001 12:48:59 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <E15JIVD-0000Qc-00@the-village.bc.nu>
In-Reply-To: <E15JIVD-0000Qc-00@the-village.bc.nu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01070912485904.00705@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 July 2001 13:37, Alan Cox wrote:
> > > possible on the memory bus. Several people have reported that machines
> > > that are otherwise stable on the bios fast options require  the proper
> > > conservative settings to be stable with the Athlon optimisations
> >
> > Do we need patch to memtest to use 3dnow?
>
> Possibly yes. Although memtest86 really tries to test for onchip not bus
> related problems

What else tends to fail on the motherboard that might be easy to test for?  
Processor overheating?  (When the thermometer circuitry's there, anyway.)  
Something to do with DMA?  (Would DMA to/from a common card like VGA catch 
chipset-side DMA problems?)  There was an SMP exception thing floating by 
recently, is that common and testable?

I know there's a lot of funky peripheral combinations that behave strangely, 
but without opening that can of worms what kind of common problems on the 
motherboard itself might be easy to test for in a "run this overnight and see 
if it finds a problem with your hardware" sort of way?

Rob

(P.S. What kind of CPU load is most likely to send a processor into overheat? 
 (Other than "a tight loop", thanks.  I mean what kind of instructions?)  
This is going to be CPU specific, isn't it?  Our would a general instruction 
mix that doesn't call halt be enough?  It would need to keep the FPU busy 
too, wouldn't it?  And maybe handle interrupts.  Hmmm...)

I wonder...  The torture test Tom's Hardware guide uses for processor 
overheating is GCC compiling the Linux kernel.  (That's what caught the 
Pentium III 1.13 gigahertz instability when nothing else would.)  I wonder, 
maybe if a stripped down subset of a known version of GCC and a known version 
of the kernel were running from a ramdisk...  It USED to fit in 8 megs with 
no swap, might still fit in 32 with a decent chunk of kernel source.  Throw 
the compile in a loop, add in a processor temperature detector daemon to kill 
the test and HLT the system if the temperature went too high...

I wonder what bits of the kernel GCC actually needs to run these days?  
(System V inter-process communication?  sysctl support?  Hmmm...  Would 
2.4.anything be a stable enough base for this yet, or should it be 2.2.19?  
Is 2.4 still psychotic with less swap space than ram (I.E. no swap space at 
all)?)

Off to play...

Still Rob.
