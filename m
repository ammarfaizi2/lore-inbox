Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129572AbQK0SIq>; Mon, 27 Nov 2000 13:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129645AbQK0SIg>; Mon, 27 Nov 2000 13:08:36 -0500
Received: from sneaker.sch.bme.hu ([152.66.226.5]:32267 "EHLO
        sneaker.sch.bme.hu") by vger.kernel.org with ESMTP
        id <S129572AbQK0SIV>; Mon, 27 Nov 2000 13:08:21 -0500
Date: Mon, 27 Nov 2000 18:37:48 +0100 (CET)
From: "Mr. Big" <mrbig@sneaker.sch.bme.hu>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM: crashing kernels
In-Reply-To: <Pine.GSO.3.96.1001127182529.13774T-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.3.96.1001127183433.9692E-100000@sneaker.sch.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > How could an APIC 'forget' how to deliver the interrupts? Could this mean
> > a problem with the mainboard, or with the CPU?
> 
>  Do you have an USB host controller in your system?  If so, could you
> please send me an output of `/sbin/lspci' and the contents of
> /proc/interrupts?  I wonder if this might be the reason...

Nope, we also disabled all unneeded periferies, like serial and parallel
ports.

But maybe the /proc/interrupts could be usefull:
           CPU0       CPU1       
  0:     413111          0          XT-PIC  timer
  1:        687          0          XT-PIC  keyboard
  2:          0          0          XT-PIC  cascade
  7:     751660          0          XT-PIC  eth1
 10:    7377626          0          XT-PIC  eth0
 11:     238981          0          XT-PIC  Mylex AcceleRAID 352, aic7xxx, aic7xxx
 13:          1          0          XT-PIC  fpu
 14:         10          0          XT-PIC  ide0
NMI:          0
ERR:          0

This is how it looks like, since we have the apic disabled. I've tried to
avoid that the Mylex and the Adaptec (aic7xxx) get the same irq, but the
bios was too lame on these things :(

+--------------------------------------------+
| Nagy Attila                                |
|   mailto:mrbig@sneaker.sch.bme.hu          |
+--------------------------------------------+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
