Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbTITIdq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 04:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbTITIdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 04:33:46 -0400
Received: from lidskialf.net ([62.3.233.115]:19938 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S261669AbTITIdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 04:33:45 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Allen Martin <AMartin@nvidia.com>, "'Merlin Hughes'" <lnx@merlin.org>
Subject: Re: [PATCH] 2.4.23-pre4 add support for udma6 to nForce IDE drive  r
Date: Sat, 20 Sep 2003 09:33:48 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <8F12FC8F99F4404BA86AC90CD0BFB04F039F714A@mail-sc-6.nvidia.com>
In-Reply-To: <8F12FC8F99F4404BA86AC90CD0BFB04F039F714A@mail-sc-6.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309200933.48696.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 September 2003 00:49, Allen Martin wrote:
> > Interesting; lots of ACPI edge-triggered interrupts:
> >
> >   dagda:~# cat /proc/interrupts
> >              CPU0
> >     0:     519365    IO-APIC-edge  timer
> >     1:      16713    IO-APIC-edge  keyboard
> >     2:          0          XT-PIC  cascade
> >     8:          4    IO-APIC-edge  rtc
> >     9:          0   IO-APIC-level  acpi
> >    14:     863415    IO-APIC-edge  ide0
> >    15:     201651    IO-APIC-edge  ide1
> >    19:     306188   IO-APIC-level  nvidia
> >    20:      57261   IO-APIC-level  usb-ohci, eth0
> >    21:          0   IO-APIC-level  ehci_hcd, NVidia nForce2
> >    22:          3   IO-APIC-level  usb-ohci, ohci1394
> >   NMI:          0
> >   LOC:     519312
> >   ERR:          0
> >   MIS:          0
>
> Your interrupts look fine, this is the way they should be.
>
> > ... but no stability problems since the primary drive has been
> > running at UDMA133. Earlier UDMA100 freezes were completely
> > repeatable; identical kernel, just without your two patches.
>
> You can try downgrading your drive to udma5 to see if udma6 really does
> make it more stable (hdparm -X udma5 /dev/hdX) but I can't think of any
> reason why it should.
>
> > I take it that I should boot with noapic in future to be safe.
>
> I've been telling people to disable APIC / ACPI because of the interrupt
> problem, but your interrupts are fine, so I'd leave it alone.  I'm curious,
> what version BIOS do you have?

ACPI/APIC should work on most nforce/nforce2 boards in 2.4.22 upwards. If not, 
let me know, and I'll look into it.

