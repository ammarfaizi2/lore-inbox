Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315442AbSELWGp>; Sun, 12 May 2002 18:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315441AbSELWGo>; Sun, 12 May 2002 18:06:44 -0400
Received: from inet01.olgc.on.ca ([216.94.172.42]:37905 "EHLO inet01")
	by vger.kernel.org with ESMTP id <S315440AbSELWGm>;
	Sun, 12 May 2002 18:06:42 -0400
To: barryn@pobox.com (Barry K. Nathan)
Cc: linux-kernel@vger.kernel.org
Subject: Re: UDMA Troubles and Possible Physical Damage?!
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF705FCF97.C476D53D-ON85256BB7.007934A6@LocalDomain>
From: aeleblanc@olgc.on.ca
Date: Sun, 12 May 2002 18:04:55 -0400
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok thanks for the pointers Barry, I'll try out that other kernel.






barryn@pobox.com (Barry K. Nathan)
12-05-02 06:06 PM

 
        To:     aeleblanc@olgc.on.ca
        cc:     linux-kernel@vger.kernel.org
        Subject:        Re: UDMA Troubles and Possible Physical Damage?!


> Duron 1GHz on an ACS Mobo with SiS Chipset. 100MHz FSB & 384 MB PC133 
> SDRAM.
> and a Fujitsu 30MB ATA100 Drive
> 
> 
> I Just finished installing Debian - Woody, which installs Kernel Version 

> 2.2.17 I Believe (I may be wrong there)

For anything recent, you really want the IDE support in 2.4.19-preX 
(latest
is -pre8).

> I installed and ran hdparm and after telling me that dma and all that 
> other good stuff was disabled it said "HDIO: Failed to check BUSSTATE"
> 
> i ran hdparm -c3 -d1 -X34 to try and get DMA Working... the command ran 

Usually -X## commands are just asking for trouble these days (the driver
should be doing it on its own, and in the newer kernels, it does). The
most that should be needed is "hdparm -d1" and that's only needed if the
"DMA enabled by default" config option wasn't enabled at kernel compile
time. 

> fine but as soon as I tried to run another command (just 'ls' in fact) 
the 
> system Locked up Solid.  upon rebooting my Bios didn't even Pick up the 
> Hard drive.. I did a Hard reset again and the Bios picked it up, then 
> reset again and it failed to pick it up again.. is it possible that I 
> Screwed up my motherboard or Hard drive somehow?

In this kind of situation you want to turn off the power to the machine
for a few minutes, ideally unplugging the machine from mains if you really
want to be sure. If the IDE controller somehow gets confused, a "hard
reset" alone isn't enough to fix things (speaking from personal
experience).

I doubt there is physical damage, but I don't know for sure. In any case,
try unplugging the thing for a few minutes, and see if you still have
problems. (Make sure you do *not* use that hdparm -X34 option.)

> the on a side note, before attempting to use hdparm under the above 
> mentioned kernel, I compiled a custom 2.4.18 kernel, however it caused 
> even more problems with ide, a bunch of:
> 
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> 
> Flew by then it said ide0: reset: success, then locked up again.
> 
> if anyone can help it would be greatly appreciated.

I would start by trying 2.4.19-pre8. If that doesn't help, there are even
newer IDE driver patches on http://www.linuxdiskcert.org/ which might be
worth a try.

-Barry K. Nathan <barryn@pobox.com>



