Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313315AbSDKJeJ>; Thu, 11 Apr 2002 05:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313649AbSDKJeI>; Thu, 11 Apr 2002 05:34:08 -0400
Received: from [194.202.59.31] ([194.202.59.31]:63240 "EHLO
	tempest.chil.ndsuk.com") by vger.kernel.org with ESMTP
	id <S313315AbSDKJeH>; Thu, 11 Apr 2002 05:34:07 -0400
Message-ID: <F128989C2E99D4119C110002A507409802944AAE@topper.hrow.ndsuk.com>
From: "Elgar, Jeremy" <JElgar@ndsuk.com>
To: linux-kernel@vger.kernel.org
Subject: RE: Mouse interrupts: the death knell of a VP6
Date: Thu, 11 Apr 2002 10:33:56 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As another data point I also have a VP6 (2x PIII 700)
Up until Tuesday only had a serial mouse, but now has a PS/2
Never any problems before (on most 2.4.x kernels) now running 2.4.17 + Int +
XFS and haven't seen any problems after a couple of heavy desktop session ~6
hours.
But I can keep an eye out, not at the machine right now but can forward on
some info tonight if required.


Jeremy

> -----Original Message-----
> From: John Adams [mailto:johna@onevista.com]
> Sent: 10 April 2002 18:17
> To: linux-kernel-owner@vger.kernel.org; Oleg Drokin; Brent Cook
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Mouse interrupts: the death knell of a VP6
> 
> 
> On Wednesday 10 April 2002 11:23 am, Oleg Drokin wrote:
> > Hello!
> >
> > On Wed, Apr 10, 2002 at 09:02:05AM -0500, Brent Cook wrote:
> > > I have an ABIT VP6 motherboard, using the VIA Apollo chipset and 2
> > > 700Mhz PIII's, but please don't hold that against me. The 
> system is
> > > running 2.4.19-pre6. I believe that I either have a 
> system that has
> > > trouble handling a sudden bursts of interrupts, or have 
> found a fault
> > > in mouse handling.
> >
> > Have you tried to change MPS mode to 1.1 from 1.4 (I see 
> addres message
> > timeouts in your log)?
> >
> > > I have already tried removing memory, adding memory, changing
> > > processors, video cards. The only thing that has remained 
> constant is
> > > the VP6 motherboard and the hard drive.
> >
> > My VP6 died on me recently with some funny symptoms:
> > it hangs in X when I start netscape and move mouse, or if I do
> > bk clone on kernel tree, it dies with
> > kernel BUG at /usr/src/linux-2.4.18/include/asm/smplock.h:62!
> > BUG in various places pretty soon.
> > (this BUG is only appears if 2 CPUs are present in motherboard).
> > So if your troubles began only recently, you might want to 
> try another
> > motherboard just to be sure.
> 
> I have a VP6 with 2 CPUs.  Its has both a PS/2 mouse and a 
> usb mouse.  Its 
> been up for 90 days and handled lots of mouse interrupts.  See below.
>            CPU0       CPU1       
>   0:  392228152  392338774    IO-APIC-edge  timer
>   1:     312494     312380    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   3:          1          3    IO-APIC-edge  serial
>  12:   40362907   40324010    IO-APIC-edge  PS/2 Mouse
>  14:    3386577    3383180    IO-APIC-edge  ide0
>  15:     679030     672810    IO-APIC-edge  ide1
>  17:    1165246    1162993   IO-APIC-level  DC395x_TRM
>  18:   83937970   83935445   IO-APIC-level  ide2, eth0
>  19:     131956     132468   IO-APIC-level  es1371, usb-uhci, usb-uhci
> NMI:          0          0 
> LOC:  784686934  784686951 
> ERR:        191
> MIS:          0
> 
> Its running a recent kernel.  Maybe 2.4.18 is broken.  Here's 
> a uname -a
> Linux flash 2.5.0 #16 SMP Wed Jan 9 16:48:16 EST 2002 i686 unknown
> 
> johna
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
