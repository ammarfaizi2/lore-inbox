Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130165AbRBZO5O>; Mon, 26 Feb 2001 09:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130203AbRBZO4m>; Mon, 26 Feb 2001 09:56:42 -0500
Received: from omecihuatl.rz.Uni-Osnabrueck.DE ([131.173.17.35]:54799 "EHLO
	omecihuatl.rz.uni-osnabrueck.de") by vger.kernel.org with ESMTP
	id <S130215AbRBZOza>; Mon, 26 Feb 2001 09:55:30 -0500
Date: Mon, 26 Feb 2001 15:51:57 +0100 (MET)
From: Arnd Bergmann <std7652@et.FH-Osnabrueck.DE>
To: Francois Romieu <romieu@cogenit.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: IRQ (routing ?) problem [was Re: epic100 in current -ac kernels]<
In-Reply-To: <Pine.GSO.4.21.0102151137500.19331-200000@gamma10>
Message-ID: <Pine.GSO.4.21.0102261547470.11657-100000@gamma10>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that there have been updates to epic100 again and just wanted
to note that the problem remains:
2.4.2-ac3 still crashes, but it works fine when I use the epic100.c
from 2.4.0-test9, which was the last working version for me.

Arnd <><

On Thu, 15 Feb 2001, ARND BERGMANN wrote:

> Sorry for the delay, I could not get physical access to the machine
> for the last days.
> 
> I was able to do some more testing today and found this:
> - The problem is not the IRQ /sharing/, after getting rid of all the
>   other PCI cards, the problem was still there.
> - The only thing that seems to have any effect on the symptoms is the
>   presence of the USB driver, either usb-uhci or uhci. I am not using
>   USB at all. As described before, the system behaves is either of those
>   ways:
>    * epic100 driver without DMA mapping (e.g. 2.4.0-ac9): normal operation
>    * driver with DMA mapping+USB driver loaded: lots of interrupts -> slow
>    * driver with DMA mapping, USB driver not loaded: hang after ~2 seconds
> - I sometimes get 'spurious interrupt: IRQ7', even though no device is 
>   connected there. Probably not important.
> 
> On Sat, 10 Feb 2001, Francois Romieu wrote:
> 
> > 
> > The following informations may help:
> > - motherboard type
> Asus A7V, onboard USB hub and Promise ATA/100 chip
> 
> > - bios revision
> Can't see right now, system was bought in October 2000
> I think it was 1.004, but I am not sure.
> 
> > - lspci -x 
> see attachment, this was when I ripped out sound, tv and scsi
> 
> > - 2.4.2pre3 + whatever recent ac epic100 = ?
> Still no improvement until latest -ac (2.4.1-ac13)
> 
> Arnd <><
> 
> 
> 

