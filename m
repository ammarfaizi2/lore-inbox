Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbQL1SPv>; Thu, 28 Dec 2000 13:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131230AbQL1SPm>; Thu, 28 Dec 2000 13:15:42 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:2311 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S129523AbQL1SPW>; Thu, 28 Dec 2000 13:15:22 -0500
Date: Thu, 28 Dec 2000 17:44:54 +0000 (GMT)
From: John Levon <moz@compsoc.man.ac.uk>
To: David Huggins-Daines <dhd@eradicator.org>
cc: fpieraut@casi.polymtl.ca, linux-kernel@vger.kernel.org
Subject: Re: Activating APIC on single processor
In-Reply-To: <87ae9g8o1q.fsf@monolith.cepstral.com>
Message-ID: <Pine.LNX.4.21.0012281741180.22864-100000@mrworry.compsoc.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Dec 2000, David Huggins-Daines wrote:

> <fpieraut@casi.polymtl.ca> writes:
> 
> > I activate APIC interruption with the configuration of linux kernel
> > 2.4.0test-11. In the linux kernel configuration under processor type and
> > features I activate "APIC and IO-APIC support on uniprocessor",  and I
> > desactivate "Symmetric multi-processing support". The only way I found to
> > check APIC activation is looking into /proc/interrupts, no "IO-APIC" can
> > be found there. So I read IO-APIC.txt and I suppose there sould be
> > conflicts with IRQ of my PCI cards. So I remove all my PCI cards and still
> > have no APIC interrupt. 
> > Is there another way to check APIC activation? 
> > Am-I doing to right things to activate IO-APIC?
> 
> You might not actually have an IO-APIC or even a local APIC.  This is
> the case with the Mobile PIII for instance (I puzzled over this myself
> for a long time).
> 
> To find out for sure, run:
> 
> grep 'flags.*apic' /proc/cpuinfo

This isn't for sure. I bet you *do* have a local APIC.

This flag is missing on a Pentium II here - I think the BIOS disables
it. However, it can be enabled in the normal way just fine.

The presence of an IO-APIC is a different matter.

thanks
john

--
"The majority of the stupid is invincible and guaranteed for all time. The
 terror of their tyranny, however, is alleviated by their lack of consistency."
	- Albert Einstein

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
