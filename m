Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265964AbRGJJMz>; Tue, 10 Jul 2001 05:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266044AbRGJJMo>; Tue, 10 Jul 2001 05:12:44 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:3347 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S265964AbRGJJMe>;
	Tue, 10 Jul 2001 05:12:34 -0400
Date: Tue, 10 Jul 2001 11:12:31 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: VIA Southbridge bug (Was: Crash on boot (2.4.5))
To: landley@webofficenow.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3B4AC6FF.A7363AA2@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley (landley@webofficenow.com) wrote :
> On Sunday 08 July 2001 13:37, Alan Cox wrote: 
> > > > possible on the memory bus. Several people have reported that machines 
> > > > that are otherwise stable on the bios fast options require the proper 
> > > > conservative settings to be stable with the Athlon optimisations 
> > > 
> > > Do we need patch to memtest to use 3dnow? 
> > 
> > Possibly yes. Although memtest86 really tries to test for onchip not bus 
> > related problems 
> 
> What else tends to fail on the motherboard that might be easy to test for? 
> Processor overheating? (When the thermometer circuitry's there, anyway.) 
> Something to do with DMA? (Would DMA to/from a common card like VGA catch 
> chipset-side DMA problems?) There was an SMP exception thing floating by 
> recently, is that common and testable? 
> 
> I know there's a lot of funky peripheral combinations that behave strangely, 
> but without opening that can of worms what kind of common problems on the 
> motherboard itself might be easy to test for in a "run this overnight and see 
> if it finds a problem with your hardware" sort of way? 
> 
> Rob 
> 
> (P.S. What kind of CPU load is most likely to send a processor into overheat? 

CPUburn from http://users.ev1.net/~redelm/

My Celeron 300 oc'ed to 450 run RC5 and Mersenne Prime for hours,
but locked up after 5 minutes of CPU burn.

The best CPU ( and bus/memory) test program that exists, IMHO

>  (Other than "a tight loop", thanks. I mean what kind of instructions?) 
> This is going to be CPU specific, isn't it? Our would a general instruction 
> mix that doesn't call halt be enough? It would need to keep the FPU busy 
> too, wouldn't it? And maybe handle interrupts. Hmmm...) 
> 
> I wonder... The torture test Tom's Hardware guide uses for processor 
> overheating is GCC compiling the Linux kernel. (That's what caught the 
> Pentium III 1.13 gigahertz instability when nothing else would.) I wonder, 
> maybe if a stripped down subset of a known version of GCC and a known version 
> of the kernel were running from a ramdisk... It USED to fit in 8 megs with 
> no swap, might still fit in 32 with a decent chunk of kernel source. Throw 
> the compile in a loop, add in a processor temperature detector daemon to kill 
> the test and HLT the system if the temperature went too high... 
> 
> I wonder what bits of the kernel GCC actually needs to run these days? 
> (System V inter-process communication? sysctl support? Hmmm... Would 
> 2.4.anything be a stable enough base for this yet, or should it be 2.2.19? 
> Is 2.4 still psychotic with less swap space than ram (I.E. no swap space at 
> all)?) 
> 
> Off to play... 
> 
> Still Rob. 

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
