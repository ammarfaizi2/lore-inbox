Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTLDCfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 21:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbTLDCfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 21:35:50 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:17872 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S261326AbTLDCfs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 21:35:48 -0500
Date: Wed, 3 Dec 2003 19:45:47 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: "b@netzentry.com" <b@netzentry.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
Message-ID: <20031204024547.GA175@tesore.local>
References: <3FCE90CD.6060501@netzentry.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCE90CD.6060501@netzentry.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 05:41:33PM -0800, b@netzentry.com wrote:
> >Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
> >>Josh McKinney wrote:
> >> To me the strangest thing is that when I first got this
> >>board a month or
> >> so ago it would hang with APIC or LAPIC enabled.

I have just bought an nForce2 board - a Shuttle AN35N Ultra.  I just got it and set it up just yesterday and found the same thing with linux kernel 2.6.0-test11.  It is simple to trigger it too.  I just do a large recursive grep:  "grep -R any ~/linux-source/*"  deadlocks almost immediately.  Starting a kernel compile, the same occurs (which is how I discovered it in the first place).


> >>  Now it works
> >>fine
> >> without disabling APIC.  All I did was update the BIOS and
> >>use it for a
> >> while with APIC disabled...
> >
> >Does the new BIOS use different defaults for memory timing,
> >bus speed, etc?
> >Did you change any of the default settings in the BIOS?
> >
...
> -- In general: I dont think it should be so easy to blame
> the BIOS. If one isnt overclocking and using the SPD on the
> memory and using conservative settings, what difference
> should that make? And if the board is stable with another
> OS I take this "BIOS blaming" and basically throw it out. BIOS
> is a deprecated arcane ridiculous thing and should never be
> trusted.

I don't think it could be the BIOS either, as this occurs on boards from different manufacturers.  But like you say, the BIOS is old stuff, and linux pretty much handles on its own after it gets running.


> 
> * The boards are stable under certain conditions. The final
> test for this (Proposed by Allen Martin
> [AMartin at nvidia ! com] is to get a stable well supported
> PCI-IDE add in card and ignore the "AMD/NVIDIA" IDE onboard.
...
> 
> Thanks everyone for your continued interest in this, I'll
> try and test the no-onboard-PATA + UP LAPIC and IOAPIC and
> add-in-card-PATA with no onboard PATA + + UP LAPIC and IOAPIC
> when I get a spare moment which is rare.

I suppose I could try right now.  I don't have a pci ide with me right now, but I do have pci scsi cards.  But doesn't running with the generic ide driver basically prove the same thing?  APIC & Generic IDE: works, PIC & nForce IDE: works, APIC & nForce IDE: deadlocks.  It's not like we are expecting faulty nforce ide hardware, or are we?


Jesse
